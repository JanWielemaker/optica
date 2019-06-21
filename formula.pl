/*  $Id: formula.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(formula,
	  [ create_formula/2,		% +Term, -Formula
	    create_formula/3		% +Hook, +Term, -Formula
	  ]).
:- meta_predicate
	create_formula(:, +, -).

:- use_module(library(pce)).
:- use_module(util).
:- require([ call/3
	   , chain_list/2
	   , default/3
	   , forall/2
	   , maplist/3
	   , member/2
	   , memberchk/2
	   , nth1/3
	   , round/2
	   ]).

:- pce_autoload(drag_and_drop_gesture, library(dragdrop)).
:- pce_autoload(editable_text, library(pce_editable_text)).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
This module contains a drag-and-drop based formula editor.  The public
classes are:

	# formula
	A generic formula
	
	# formula_symbol
	A terminal symbol

	# formula_window
	A subclass of class window for editing formulas

	# formula_menu
	A subclass of class dialog providing prototype formulas

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- initialization
   send(@display, font_alias, symbol,
	font(symbol, roman, 16,
	     '-adobe-symbol-*-*-*-*-16-*-*-*-*-*-*-fontspecific')).

/*
formula(equal,
	=:=,
	format(vertical, 1, @on) + [adjustment(vector(center)), row_sep(3)],
	[op(1), symbol(61), op(2)],
	[cursor('dragequal.crs')]).
*/
formula(plus,
	+,
	format(vertical, 1, @on) + [adjustment(vector(center)), row_sep(3)],
	[op(1), symbol(43), op(2)],
	[cursor('dragplus.crs')]).
formula(minus,
	-,
	format(vertical, 1, @on) + [adjustment(vector(center)), row_sep(3)],
	[op(1), symbol(45), op(2)],
	[cursor('dragminus.crs')]).
formula(times,
	*,
	format(vertical, 1, @on) + [adjustment(vector(center)), row_sep(3)],
	[op(1), symbol(180), op(2)],
	[cursor('dragtimes.crs')]).
formula(divide,
	/,
	format(horizontal, 1, @on) + [adjustment(vector(center)), row_sep(2)],
	[op(1), hrule, op(2)],
	[cursor('dragdiv.crs')]).

formula(Name, PrologName, Layout, Parts) :-
	formula(Name, PrologName, Layout, Parts, _).

current_formula(Name) :-
	formula(Name, _, _, _).


:- pce_begin_class(drag_formula, drag_and_drop_gesture, "Drag a formula").

initiate(G, Ev:event) :->
	get(Ev, receiver, Formula),
	(   get(Formula, drag_cursor, Cursor)
	->  send(G, cursor, Cursor)
	;   send(G, cursor, @default)
	),
	send(G, send_super, initiate, Ev).
	    
:- pce_end_class.



:- pce_begin_class(formula, figure, "General formula").

variable(functor,	name*,	      get, "Functor for the formula").
variable(embrace,	bool := @off, get, "Formula has braces around it").

initialise(F, Functor:name*) :->
	send(F, send_super, initialise),
	send(F, slot, functor, Functor).

value(F, Value:'int|real') :<-
	"Compute value of the formula"::
	get(F, functor, Functor),
	get(F?graphicals, find_all,
	    or(message(@arg1, instance_of, operant),
	       message(@arg1, instance_of, formula)),
	    Args),
	chain_list(Args, L0),
	maplist(op_value_and_position, L0, L1),
	keysort(L1, L2),
	unkey(L2, Values),
	Term =.. [Functor|Values],
	eval(Term, Value).

eval(_/B, _) :-				% avoid illegal operations.
	B =:= 0, !,
	fail.
eval(Term, Value) :-
	Value is Term.

op_value_and_position(Op, Pos-Value) :-
	get(Op, rank, Pos),
	get(Op, value, Value).

unkey([], []).
unkey([_-V|T0], [V|T]) :-
	unkey(T0, T).

orientation(F, O:{vertical,horizontal,none}) :<-
	get(F, format, Fmt),
	(   get(Fmt, direction, vertical)
	->  O = horizontal
	;   O = vertical
	).

:- pce_group(brace).

embrace(F, Embrace:[bool]) :->
	"Put braces around the formula"::
	default(Embrace, @on, Do),
	(   get(F, embrace, Do)
	->  true
	;   send(F, slot, embrace, Do),
	    (   Do == @off
	    ->  send(F?graphicals, for_all,
		     if(message(@arg1, instance_of, arc),
			message(@arg1, free)))
	    ;   send(F, display, new(L, arc)),
		send(F, display, new(R, arc)),
		send(L, name, left_brace),
		send(R, name, right_brace),
		send(F, request_compute)
	    )
	).

braces(F, L, R) :-
	get(F, embrace, @on),
	get(F, member, left_brace, L),
	get(F, member, right_brace, R).

display_braces(F, Bool) :-
	braces(F, L, R), !,
	send(L, displayed, Bool),
	send(R, displayed, Bool).
display_braces(_, _).
	
priority(F, Arg:'[1..]', P:'0..1200') :<-
	"Priority of operator or argument"::
	get(F, functor, Func),
	current_op(OpPri, Acc, Func),
	atom_codes(Acc, Chars),
	priority(Chars, OpPri, Arg, PFormula),
	P is PFormula.

priority(_,       P, @default, P) :- !.
priority([A,_,_], P, 1,	       Pri) :-
	priority(A, P, Pri).
priority([A,_],   P, 1,	       Pri) :-
	priority(A, P, Pri).
priority([_,_,B], P, 2,	       Pri) :-
	priority(B, P, Pri).

priority(0'x, P, P-1).
priority(0'y, P, P).


:- pce_group(compute).

adjust_spacing(F) :-
	(   get(F, orientation, horizontal)
	->  operant_width(F, W),
	    RowSep is max(5, round(2 + W/10)),
	    send(F?format, row_sep, RowSep)
	;   true
	).


operant_width(F, W) :-
	new(N, number(0)),
	send(F?graphicals, for_all,
	     if(message(@arg1, instance_of, operant),
		message(N, maximum, @arg1?width))),
	get(N, value, W).


compute(F) :->
	(   get(F, request_compute, @nil)
	->  true
	;   get(F, attribute, computing_rules, @on)
	->  send(F, send_super, compute)
	;   get(F?graphicals, find_all, @arg1?name == hrule, Rules),
	    send(Rules, for_all,
		 message(@arg1, points, 0, @default, 0, @default)),
	    display_braces(F, @off),
	    adjust_spacing(F),
	    send(F, send_super, compute),
	    get(F, area, area(X, Y, W, H)),
	    get(F, position, point(OX, OY)),
	    LS is X-OX,
	    RS is X+W-OX,
	    TS is Y-OY,
	    BS is Y+H-OY,
	    send(F, attribute, computing_rules, @on),
	    send(Rules, for_all,
		 message(@arg1, points, LS, @default, RS, @default)),
	    (	braces(F, LB, RB)
	    ->	send(LB, points, LS, TS, LS, BS, -H/6),
		send(RB, points, RS, TS, RS, BS, H/6),
		display_braces(F, @on),
		get(F, format, Fmt),
		send(Fmt, lock_object, @on),
		send(F, format, @nil),
		send(F, send_super, compute),
		send(F, format, Fmt),
		send(Fmt, lock_object, @off)
	    ;	true
	    ),
	    send(F, delete_attribute, computing_rules),
	    send(F, send_super, compute)
	).


:- pce_global(@formula_recogniser, make_formula_recogniser).

make_formula_recogniser(G) :-
	new(DD, drag_formula),
	send(DD, condition,
	     not(message(@event?receiver?device, instance_of, operant))),
	new(G, handler_group(DD)).


event(F, Ev:event) :->
	(   send(F, send_super, event, Ev)
	;   send(@formula_recogniser, event, Ev)
	).

drag_cursor(F, Cursor:[cursor]) :<-
	"Cursor used for dragging the formula"::
	get(F, functor, Functor),
	formula(_, Functor, _, _, Attributes),
	memberchk(cursor(File), Attributes),
	(   get(@cursors, member, File, Cursor)
	->  true
	;   new(Cursor, cursor(File, image(File)))
	).

:- pce_end_class.

:- pce_begin_class(operant, figure, "Placeholder for a formula operant").

variable(rank,	int,	get, "Place of the operant").

initialise(O, R:int) :->
	send(O, send_super, initialise),
	send(O, slot, rank, R),
	send(O, bind, @nil).

value(O, Value:'int|real') :<-
	(   get(O?graphicals, find, message(@arg1, instance_of, formula), F)
	->  get(F, value, Value)
	;   send(O, report, error, 'Operant has no value'),
	    fail
	).

priority(O, P:'0..1200') :<-
	(   get(O, device, Dev),
	    send(Dev, instance_of, formula)
	->  get(O, rank, Rank),
	    get(Dev, priority, Rank, P)
	;   P = 0
	).

bind(O, F:'formula|symbol'*) :->
	(   F == @nil
	->  send(O, clear),
	    send(O, display, bitmap('operant.xpm'))
	;   send(O, clear),
	    send(O, display, F),
	    (	get(O, device, P),
		send(P, instance_of, formula)
	    ->	(   get(F, orientation, vertical),
		    get(P, orientation, vertical)
		->  send(F, embrace, @on)
		;   (   get(F, orientation, vertical)
		    ;   get(P, orientation, vertical)
		    )
		->  send(F, embrace, @off)
		;   get(O, priority, OP),
		    get(F, priority, FP),
		    (	FP =< OP
		    ->	send(F, embrace, @off)
		    ;	send(F, embrace, @on)
		    )
		)
	    ;	send(F, embrace, @off)
	    )
	).


part_of(D, D) :- !.
part_of(Part, Whole) :-
	get(Part, device, Dev),
	Dev \== @nil,
	part_of(Dev, Whole).


preview_drop(O, F:'formula|symbol*') :->
	"Preview the drop: give it a border"::
	(   F == @nil
	->  send(O, pen, 0)
	;   \+ part_of(O, F),
	    get(O, window, W),
	    send(W, instance_of, formula_window), % only edit there
	    send(O, pen, 1)
	).

drop(O, F:formula) :->
	"Drop a formula: bind it"::
	\+ part_of(O, F),
	get(F, clone, F2),
	send(O, bind, F2).

:- pce_end_class.

		 /*******************************
		 *	      SYMBOLS		*
		 *******************************/


:- pce_begin_class(formula_symbol, formula, "Variable symbol in a formula").

initialise(S, Text:name, Font:[font]) :->
	default(Font, italic, TheFont),
	send(S, send_super, initialise, @nil),
	send(S, name, Text),
	send(S, display, text(Text, center, TheFont)).

name(S, Name:name) :->
	send(S, send_super, name, Name),
	(   get(S, member, text, T)
	->  send(T, string, Name)
	;   true
	).

orientation(_, O:{vertical,horizontal,none}) :<-
	O = none.

priority(_, P:'0..1200') :<-
	P = 0.

:- pce_end_class. 

		 /*******************************
		 *	      CONSTANTS		*
		 *******************************/

:- pce_begin_class(formula_constant, formula, "Constant in a formula").

variable(value,		'real|int',	get, "Value of the constant").

initialise(S, Value:'int|real', Label:[name], Font:[font]) :->
	default(Font, normal, TheFont),
	send(S, slot, value, Value),
	send(S, send_super, initialise, @nil),
	default(Label, Value, TheLabel),
	send(S, display, new(T, editable_text(TheLabel, center, TheFont))),
	send(T, message, message(@receiver?device, typed_value, @arg1)).

typed_value(S, Text:string) :->
	"User typed a new value"::
	(   get(@pce, convert, Text, 'int|real', Value)
	->  send(S, slot, value, Value)
	;   send(S, report, error, 'Could not translate to a number'),
	    fail
	).

orientation(_, O:{vertical,horizontal,none}) :<-
	O = none.

priority(_, P:'0..1200') :<-
	P = 0.

:- pce_global(@dragcontant_cursor,
	      new(cursor(@nil, image('dragconst.crs')))).

drag_cursor(_, C:cursor) :<-
	C = @dragcontant_cursor.

:- pce_end_class. 


		 /*******************************
		 *      FORMULA PROTOTYPES      *
		 *******************************/

make_formula(Name, Gr) :-
	formula(Name, Functor, Format+Mod, Elements),
	new(Gr, formula(Functor)),
	send(Gr, format, new(F, Format)),
	apply_modifications(F, Mod),
	forall(member(E, Elements), add_formula_element(Gr, E)).

apply_modifications(_, []) :- !.
apply_modifications(O, [Term|T]) :-
	Term =.. List,
	Goal =.. [send, O | List],
	Goal,
	apply_modifications(O, T).

add_formula_element(F, op(N)) :- !,
	send(F, display, new(operant(N))).
add_formula_element(F, symbol(N)) :- !,
	char_code(A, N),
	send(F, display, text(A, center, symbol)).
add_formula_element(F, hrule) :-
	send(F, display, new(L, line)),
	send(L, name, hrule).

		 /*******************************
		 *        CREATE FORMULA	*
		 *******************************/

create_formula(Term, T) :-
	create_formula([], Term, T).

create_formula(Hook, Term, F) :-
	Hook \== [],
	call(Hook, Term, F), !,
	F \== @nil.
create_formula(Hook, Term, F) :-
	Term =.. [Functor|Args],
	maplist(create_formula(Hook), Args, FArgs),
	formula(_Name, Functor, Format+Mod, Elements),
	new(F, formula(Functor)),
	send(F, format, new(Fmt, Format)),
	apply_modifications(Fmt, Mod),
	insert_arguments(Elements, FArgs, F).
create_formula(_, Number, F) :-
	number(Number), !,
	new(F, formula_constant(Number)).
create_formula(_, Var, F) :-
	atom(Var), !,
	new(F, formula_symbol(Var)).
	
insert_arguments([], _, _).
insert_arguments([op(N)|T], Args, F) :-
	nth1(N, Args, Arg), !,
	send(Arg, attribute, rank, N),
	send(F, display, Arg),
	insert_arguments(T, Args, F).
insert_arguments([A|T], Args, F) :-
	add_formula_element(F, A),
	insert_arguments(T, Args, F).


		 /*******************************
		 *	  FORMULA-MENU		*
		 *******************************/

:- pce_begin_class(formula_menu, dialog, "Formula prototypes").

initialise(FM) :->
	"Create a building-block menu"::
	send(FM, send_super, initialise),
	send(FM, add_prototypes),
	new(Fmt, format(vertical, 1, @on)),
	send(Fmt, adjustment, vector(center)),
	send(FM, format, Fmt).

add_prototypes(FM) :->
	"Add the default formula building-blocks"::
	forall(current_formula(Name),
	       (   make_formula(Name, F),
		   send(FM, display, F)
	       )),
	send(FM, display, formula_constant(1)).

:- pce_end_class.


		 /*******************************
		 *      FORMULA-TRASHCAN	*
		 *******************************/

:- pce_begin_class(formula_trashcan, bitmap, "Eat formulas").

initialise(TC) :->
	send(TC, send_super, initialise, 'snapr.xpm').

preview_drop(TC, F:formula*) :->
	(   F == @nil
	->  send(TC, pen, 0)
	;   get(TC, window, Win),
	    get(F, window, Win),
	    send(TC, pen, 1)
	).

drop(TC, F:formula) :->
	get(TC, window, Win),
	get(F, window, Win),
	send(F, destroy).

:- pce_end_class.


		 /*******************************
		 *	 A FORMULA-SHEET	*
		 *******************************/

:- pce_begin_class(formula_window, window, "Formula editor working area").

initialise(FW) :->
	send(FW, send_super, initialise),
	send(FW, display, new(TC, formula_trashcan)),
	send(FW, resize_message,
	     message(TC, y, @arg2?height - TC?height)).

preview_drop(P, Gr:formula*, Pos:[point]) :->
	(   Gr == @nil                  % pointer leaves area
	->  (   get(P, attribute, drop_outline, OL)
	    ->  send(OL, free),
		send(P, delete_attribute, drop_outline)
	    ;   true
	    )
	;   (   get(P, attribute, drop_outline, OL)
	    ->  send(OL, position, Pos)
	    ;   get(Gr?area, size, size(W, H)),
		new(OL, box(W, H)),
		send(OL, texture, dotted),
		send(P, display, OL, Pos),
		send(P, attribute, drop_outline, OL)
	    )
	).


drop(P, Gr:formula, Pos:point) :->
        (   get(Gr, device, P)
        ->  send(Gr, position, Pos)
        ;   get(Gr, clone, Gr2),
            send(P, display, Gr2, Pos)
        ).

:- pce_end_class.


