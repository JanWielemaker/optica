/*  $Id: util.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(optica_util,
	  [ set_drop_cursor/2,
	    scale/3,			% +Gr, -ScaleX, -ScaleY
	    send_parts/2,		% +Path, +Message
	    send_part/2,		% +Path, +Message
	    get_part/3,			% +Path, +Message, -Result
	    find_graphical/2,		% +Spec, -Graphical
	    browse_icon/2,		% +Frame, -ImageBase
	    browse_icon/3,		% +Frame, -ImageBase, +Options
	    atom_to_list/2,		% +Atom, -List
	    with_long_atoms/1,		% Call, allow for long atoms
	    with_strings/1		% Call, read "bla" as string
	  ]).
:- meta_predicate
	with_long_atoms(:),
	with_strings(:).

:- use_module(library(pce)).
:- use_module(library(help_message)).
:- use_module(language).
:- use_module(parts).			% should be imported directly
:- require([ absolute_file_name/3
	   , append/3
	   , chain_list/2
	   , concat/3
	   , concat_atom/3
	   , expand_file_name/2
	   , file_base_name/2
	   , forall/2
	   , get_chain/3
	   , member/2
	   ]).


set_drop_cursor(Obj, Cursor) :-
	get(@event, window, DragWindow),
	(   Obj == @nil
	->  (	get(DragWindow, attribute, saved_drop_cursor, Old)
	    ->	send(DragWindow, focus_cursor, Old),
		send(DragWindow, delete_attribute, saved_drop_cursor)
	    ;	true
	    )
	;   (   get(DragWindow, attribute, saved_drop_cursor, _)
	    ->	true
	    ;	get(DragWindow, focus_cursor, Old),
		send(DragWindow, attribute, saved_drop_cursor, Old)
	    ),
	    send(DragWindow, focus_cursor, Cursor)
	).
	    
scale(Gr, ScaleX, ScaleY) :-
	get(Gr, window, W), W \== @nil, !,
	get(W, scale_x, ScaleX),
	get(W, scale_y, ScaleY).
scale(_, ScaleX, ScaleY) :-
	send(@optical_workspace, instance_of, optical_workspace), !,
	get(@optical_workspace, scale_x, ScaleX),
	get(@optical_workspace, scale_y, ScaleY).
scale(_, 0.05, -0.05).


		 /*******************************
		 *	    ICON BROWSER	*
		 *******************************/

%	browse_icon(+Frame, -ImageName, Options)

browse_icon(Frame, ImageName) :-
	browse_icon(Frame, ImageName,
		    [ directory(local(icons)),
		      size(32,32)
		    ]).

browse_icon(Frame, ImageName, Options) :-
	findall(IFD, (member(directory(Dir), Options),
		      icons_from_dir(Dir, IFD)), IFDS),
	flatten(IFDS, Icons),
	new(P, picture),
	send(P, format, format(horizontal, P?width, @off)),
	forall(member(Icon, Icons),
	       append_icon(P, Icon, Options)),
	send(new(D, dialog), below, P),
	send(D, append, button(cancel, message(D, return, @nil))),
	send(P, transient_for, Frame),
	send(P, modal, transient),
	get(P, confirm_centered, Frame?area?center, Base),
	send(P, destroy),
	Base \== @nil,
	ImageName = Base.

append_icon(W, I, Options) :-
	(   new(Img, image(I)),
	    get(Img, size, size(IW,IH)),
	    memberchk(size(IW, IH), Options)
	->  file_base_name(I, Base),
	    new(B, button(Base, message(W, return, Base))),
	    send(B, label, Img),
	    send(W, display, B)
	;   true
	).

icons_from_dir(Dir, Icons) :-
	absolute_file_name(Dir,
			   [ file_type(directory),
			     access(read),
			     file_errors(fail)
			   ], IconDir),
	atom_concat(IconDir, '/*.xpm', Pattern),
	expand_file_name(Pattern, Icons).



:- pce_begin_class(right_tick_box, menu).

initialise(TB, Name:name, Msg:[code]*) :->
	send(TB, send_super, initialise, Name, marked, Msg),
	send(TB, multiple_selection, @on),
	send(TB, append, menu_item(@on, @default, '')).

selection(TB, Val:bool) :<-
	get(TB, member, @on, MI),
	get(MI, selected, Val),
	send(TB, modified, @off).
selection(TB, Val:bool) :->
	get(TB, member, @on, MI),
	send(MI, selected, Val),
	send(TB, modified, @off).

:- pce_end_class.


:- pce_begin_class(ticker, menu, "Boolean tick-box without label").

:- pce_global(@ticker_message,
	      new(if(message(@receiver?message, instance_of, code),
		     message(@receiver?message, forward, @arg1?selected)))).

initialise(TB, Name:name, Value:[bool], Message:[code]*) :->
	send(TB, send_super, initialise, Name, marked, Message),
	send(TB, multiple_selection, @on),
	send(TB, show_label, @off),
	get(TB, resource_value, label_font, Font),
	send(TB, value_font, Font),
	send(TB, append, new(MI, menu_item(@on, @ticker_message, ''))),
	(   Value == @default
	->  send(MI, selected, @off)
	;   send(MI, selected, Value)
	).

selection(TB, Val:bool) :->
	(   Val == @on
	->  send(TB, send_super, selection, @on)
	;   send(TB, clear_selection)
	).
selection(TB, Val:bool) :<-
	get(TB, member, @on, Item),
	get(Item, selected, Val).

:- pce_end_class.

		 /*******************************
		 *          TOOL BUTTON		*
		 *******************************/

:- pce_begin_class(optica_tool_button, button, "Image button").

initialise(TB, Name:name, Msg:[code]*, Img:[image], Tag:[char_array]) :->
	send(TB, send_super, initialise, Name, Msg),
	(   Img \== @default
	->  send(TB, label, Img)
	;   true
	),
	(   Tag == @default
	->  message(Name, Balloon)
	;   Balloon = Tag
	),
	send(TB, help_message, tag, Balloon),
	send(TB, reference, point(0, TB?height/2)).


:- pce_end_class.

:- pce_begin_class(identifier_item, text_item, "Item for an identifier").

selection(II, Sel:name) :<-
	get(II, get_super, selection, Sel0),
	new(S, string('%s', Sel0)),
	send(S, strip),
	get(S, value, Sel),
	Sel \== ''.

:- pce_end_class.

:- pce_begin_class(identifier_list_item, text_item,
		   "Item for an identifier or list").

selection(II, Sel:chain) :->
	chain_list(Sel, List),
	concat_atom(List, ', ', Atom),
	send(II, send_super, selection, Atom).
selection(II, Sel:chain) :<-
	get(II, get_super, selection, Sel0),
	get(Sel0, value, Atom),
	atom_to_list(Atom, List),
	chain_list(Sel, List).

:- pce_end_class.


		 /*******************************
		 *	   EDITOR STUFF		*
		 *******************************/

:- pce_extend_class(editor).

associate_diagram(V, D:graphical, N:int) :<-
	"Associate and return index"::
	(   get(V, attribute, diagrams, Vector)
	->  true
	;   send(V, attribute, diagrams, new(Vector, vector(dummy)))
	),
	send(Vector, append, D),
	send(D, cursor, top_left_arrow),
	get(Vector, high_index, N).

diagram(V, N:int, D:graphical) :<-
	"Fetch Nth diagram"::
	get(V, attribute, diagrams, Vector),
	get(Vector, element, N, D).

insert_diagram(V, D:graphical) :->
	"Insert a diagram here"::
	get(V, associate_diagram, D, N),
	send(V, format, '%c%c%c', 1, N, 1).

:- pce_end_class.

		 /*******************************
		 *       TRANSIENT DIALOG	*
		 *******************************/

:- pce_begin_class(transient_dialog, dialog,
		   "Modal, transient dialog").

initialise(TD, Frame:frame, Name:[name]) :->
	send(TD, send_super, initialise, Name),
	send(TD, transient_for, Frame),
	send(TD, modal, transient).

open_centered(TD) :->
	"Open centered to master"::
	get(TD, transient_for, Frame),
	send(TD, send_super, open_centered, Frame?area?center).

confirm_centered(TD, Answer:any) :<-
	"Confirm centered to master"::
	get(TD, transient_for, Frame),
	get(TD, get_super, confirm_centered, Frame?area?center, Answer).

reset(TD) :->
	"Delete myself on an abort"::
	send(TD, destroy).

report(TD, Kind:name, Fmt:char_array, Args:any ...) :->
	(   Kind == error
	->  send(TD?display, send_vector, report, Kind, Fmt, Args)
	;   send(TD, send_super, send_vector, report, Kind, Fmt, Args)
	).

:- pce_end_class.

		 /*******************************
		 *	   SOME GRAMMARS	*
		 *******************************/

%	atom_to_list(Atom, List)
%	Turns an atom of the form "bla, foo, 0" into a list [bla, foo, 0]

atom_to_list(Atom, List) :-
	atom_codes(Atom, Chars),
	phrase(set(List), Chars).

set([]) -->
	blanks,
	end, !.
set([H|T]) -->
	blanks,
	string(S),
	(   ","
	;   end
	), !,
	{name(H, S)},
	set(T).

blanks -->
	[C],
	{C =< 32}, !,
	blanks.
blanks -->
	[].

string([]) --> [].
string([H|T]) --> [H], string(T).

end([], []).


		 /*******************************
		 *	  READING STUFF		*
		 *******************************/

pce_ifhostproperty(prolog(swi), [
(   with_long_atoms(G) :-
	style_check(-atom),
	(   G
	->  style_check(+atom)
	;   style_check(+atom),
	    fail
	)),
(   with_strings(G) :-
	style_check(+string),
	(   G
	->  style_check(-string)
	;   style_check(-string),
	    fail
	))],
[ (with_long_atoms(G) :- call(G)),
  (with_strings(G) :- call(G))
]).
  
