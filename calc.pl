/*  $Id: calc.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(calculator, []).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(formula).
:- use_module(gauge).
:- use_module(save).
:- use_module(tool).
:- require([ atom_to_term/3
	   , ceiling/2
	   , checklist/2
	   , concat_atom/2
	   , log10/2
	   ]).

:- pce_begin_class(calculator(formula), optical_instrument, "A calculator").
:- use_class_template(gauge).

variable(formula,	name,	      get,  "Text of formula").

initialise(C, Formula:name) :->
	"Create from a (textual) formula"::
	(   atom_to_term(Formula, Term, Vars),
	    checklist(call, Vars)
	->  (   create_formula(make_symbol, Term, Graphical)
	    ->	true
	    ;	send(C, error, illegal_formula),
		fail
	    )
	;   send(C, error, syntax_error),
	    fail
	),
	send(C, send_super, initialise),
	send(C, slot, formula, Formula),
	new(F, format(vertical, 1, @on)),
	send(F, adjustment, vector(center)),
	send(C, format, F),
	send(Graphical, name, formula),
	send(C, display, Graphical),
	send(C, display, new(Is, text(=))),
	send(Is, name, is),
	send(C, display, new(gauge_text)).
	
reference_x(C, X:int) :<-
	"Reference for alignment (center of the =)"::
	get(C, x, X0),
	get(C, member, is, Is),
	get(Is, center_x, X1),
	X is X0 + X1.
reference_x(C, X:int) :->
	"Reference for alignment (center of the =)"::
	send(C, compute),
	get(C, member, is, Is),
	get(Is, center_x, X1),
	X0 is X - X1,
	send(C, x, X0).

make_symbol(A, F) :-
	atom(A),
	new(F, gauge_symbol(A)).
	
update(C) :->
	"Recompute the formula"::
	get(C, member, formula, F),
	get(C, member, gauge_text, GT),
	(   get(F, value, Value)
	->  send(GT, value, Value),
	    (	Value =:= 0
	    ->	Digits = 2
	    ;   Digits is max(0, 3-ceil(log10(abs(Value))))
	    ),
	    concat_atom(['%.', Digits, f], Fmt),
	    send(GT, value_format, Fmt)
	;   send(GT, value, @nil)
	).

show_value(C, Val:bool) :->
	(   Val == @on
	->  send(C, update)
	;   true
	),
	get(C, member, gauge_text, GT),
	send(GT, show_value, Val).

:- instrument_state([formula, varname, pos_x, pos_y]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ 
		   ]).

:- pce_group(event).

:- pce_global(@calculator_recogniser,
	      new(handler_group(click_gesture(left, '', single,
					      message(@receiver, clicked)),
				move_xy_gesture(left)))).

event(_C, Ev:event) :->
	send(@calculator_recogniser, event, Ev).

report_to(C, V:visual) :<-
	(   get(C, frame, _)
	->  get(C, device, V)
	;   send(@event, instance_of, event)
	->  get(@event, receiver, V)
	;   V = @display
	).

:- pce_end_class.

:- pce_begin_class(gauge_symbol, formula_symbol,
		   "Use a gauge value in a formula").

value(V, Val:'int|real') :<-
	get(V, name, Name),
	(   get(V, hypered, gauge, GaugeText),
	    get(GaugeText, varname, Name)
	->  true
	;   get(V, window, Window),
	    get(Window, gauge, @default, Name, GaugeText),
	    send(V, delete_hypers, gauge),
	    new(_, hyper(V, GaugeText, gauge, formula))
	),
	get(GaugeText, value, Val).

:- pce_end_class.








	  
