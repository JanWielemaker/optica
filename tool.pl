/*  $Id: tool.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(tool,
	  [ apply_tool/2		% Object, Attributes
	  ]).
:- use_module(library(pce)).
:- use_module(log).
:- use_module(configdb).
:- require([ checklist/2
	   , concat_atom/2
	   , memberchk/2
	   , send_list/3
	   ]).

apply_tool(Object, _) :-
	get(Object, frame, Optica),
	get(Optica, instrument, none), !,
	fail.
apply_tool(Object, _) :-
	send(Object, instance_of, optical_instrument),
	get(Object, instrument_name, I),
	config(instrument(I, _Options, Attributes)), !,
	tool_attributes(Attributes, ToolAttributes),
	do_apply_tool(Object, ToolAttributes).
apply_tool(Object, Attributes) :-
	send(Object, has_send_method, read_only),
	get(Object, frame, Optica),
	get(Optica, attribute, author_version, @on), !,
	do_apply_tool(Object, [read_only(type(bool))|Attributes]).
apply_tool(Object, Attributes) :-
	do_apply_tool(Object, Attributes).
	       

attribute_label(pos_x,          image('x.lbl')).
attribute_label(pos_y,          image('y.lbl')).
attribute_label(varname,        image('vname.lbl')).
attribute_label(label,		image('label.lbl')).
attribute_label(focal_distance, image('focald.lbl')).
attribute_label(breaking_index, image('breakidx.lbl')).
attribute_label(switch,		image('switch.lbl')).
attribute_label(divergence,	image('diver.lbl')).
attribute_label(unit,		image('dotsep.lbl')).
attribute_label(angle,		image('angle.lbl')).
attribute_label(separation,	image('beamsep.lbl')).
attribute_label(thickness,	image('thickness.lbl')).
attribute_label(radius,		image('radius.lbl')).
attribute_label(sfere_left,	image('lsfere.lbl')).
attribute_label(sfere_right,	image('rsfere.lbl')).
attribute_label(read_only,	image('readonly.lbl')).

attribute_unit(pos_y,		cm,	 '%.2f').
attribute_unit(focal_distance,	cm,	 '%.1f').
attribute_unit(breaking_index,	'',	 '%.2f').
attribute_unit(divergence,	degrees, '%.1f').
attribute_unit(unit,		cm,	 '%.2f').
attribute_unit(thickness,	cm,	 '%.1f').
attribute_unit(radius,		cm,	 '%.1f').
attribute_unit(sfere_left,	'%',	 '%d').
attribute_unit(sfere_right,	'%',	 '%d').
attribute_unit(angle,		Degrees, '%.1f') :-
	char_code(Degrees, 176).

tool_attributes([], []).
tool_attributes([attribute(Name, Options)|TA], [H|T]) :-
	memberchk(edit(Type), Options), !,
	H =.. [Name, type(Type)],
	tool_attributes(TA, T).
tool_attributes([_|TA], L) :-
	tool_attributes(TA, L).


do_apply_tool(Object, _) :-
	send(Object, has_get_method, read_only),
	get(Object, read_only, @on), !,
	send(Object, report, warning, 'Read only'),
	fail.
do_apply_tool(Object, Attributes) :-
	get(Object, frame, Frame),
	new(D, tool_window('Tool')),
	new(_, depto_hyper(Object, D, tool, client)),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	checklist(add_attribute(D, Object), Attributes),
	send(D, append, new(Apply, button(apply))),
	send(D, append, button(restore)),
	send(D, append, button(quit, message(D, quit))),
	send(D, open_centered, Frame?area?center),
	send(Apply, default_button),
	send(Apply, active, @off),
	id(Object, Id),
	log(begin(tool(Id))).

id(@nil, _) :- !,
	fail.
id(Gr, Id) :-
	send(Gr, has_get_method, state), !,
	get(Gr, name, Id).
id(Gr0, Id) :-
	get(Gr0, device, Gr1),
	\+ send(Gr1, instance_of, window),
	id(Gr1, Id), !.
id(Gr0, Id) :-
	send(Gr0, has_get_method, client_for),
	get(Gr0, client_for, ClientFor),
	id(ClientFor, Id).


add_attribute(D, O, Term) :-
	Term =.. [Attribute|Options],
	memberchk(type(Type), Options),
	(   memberchk(label(Label), Options)
	->  true
	;   attribute_label(Attribute, Label)
	),
	type_to_item(Type, O, Attribute, D, Item),
	(   Label == @nil
	->  send(Item, show_label, @off)
	;   atomic(Label)
	->  send(Item, label, string('%s:', Label?label_name))
	;   send(Item, label, Label)
	).

type_to_item(bool, _, A, D, M) :- !,
	send(D, append,
	     new(M, right_tick_box(A, message(D, value, A, @arg1)))),
	send(M, default, ?(D, value, A)).
type_to_item(bool(On, Off), _, A, D, M) :- !,
	send(D, append, new(M, menu(A, marked, message(D, value, A, @arg1)))),
	send(M, layout, horizontal),
	send(M, append, menu_item(@on,  @default, On)),
	send(M, append, menu_item(@off, @default, Off)),
	send(M, default, ?(D, value, A)).
type_to_item(label, O, A, D, TI) :- !,
	type_to_item(varname, O, A, D, TI).
type_to_item(varname, _, A, D, TI) :- !,
	send(D, append,
	     new(TI, text_item(A, '', message(D, value, A, @arg1)))),
	send(TI, length, 4),
	send(TI, default, when(?(D, value, A) \== @nil,
			       ?(D, value, A),
			       '')).
type_to_item(on_bar, O, Attribute, D, Item) :- !,
	get(O, window, Win),
	get(Win?visible, right_side, RS),
	get(Win, scale_x, ScaleX),
	High is RS * ScaleX,
	type_to_item(real_range(0, High, cm, '%.1f'), O, Attribute, D, Item).
type_to_item(range(Low-High), O, A, D, TI) :- !,
	attribute_unit(A, Unit, Format),
	type_to_item(real_range(Low, High, Unit, Format), O, A, D, TI).
type_to_item(real_range([Low, High], Unit, Format), _O, A, D, TI) :- !,
	send(D, append,
	     new(TI, real_item(A, Low, High, message(D, value, A, @arg1)))),
	send(TI, allow_default, @on),
	send(TI, format, Format),
	send(D, append, new(U, label(unit, Unit)), right),
	concat_atom(['%s [', Format, ' - ', Format, ']'], Fmt),
	send(U, format, Fmt, Unit, Low, High),
	send(U, alignment, right),
	send(TI, default, ?(D, value, A)).
type_to_item(real_range(Low, inf, Unit, Format), O, A, D, TI) :- !,
	type_to_item(real_range(Low, @nil, Unit, Format), O, A, D, TI).
type_to_item(real_range(Low, High, Unit, Format), _O, A, D, TI) :- !,
	send(D, append,
	     new(TI, real_item(A, Low, High, message(D, value, A, @arg1)))),
	send(TI, format, Format),
	send(D, append, new(U, label(unit, Unit)), right),
	concat_atom(['%s (', Format, ' - ', Format, ')'], Fmt),
	send(U, format, Fmt, Unit, Low, High),
	send(U, alignment, right),
	send(TI, default, ?(D, value, A)).
type_to_item(set(List), _O, A, D, M) :-
	send(D, append, new(M, menu(A, choice, message(D, value, A, @arg1)))),
	send_list(M, append, List),
	send(M, layout, horizontal),
	get(D, value, A, Val),
	(   get(M?members, find, message(@arg1?value, equal, Val), MI)
	->  send(M, selection, MI)
	;   true
	).
type_to_item(name, O, A, D, TI) :- !,
	type_to_item(varname, O, A, D, TI).
	
:- pce_begin_class(tool_window, dialog, "Optica tool manipulator").

quit(D) :->
	"Quit and close log"::
	get(D, hypered, client, Client),
	(   send(Client, instance_of, graphical),
	    get(Client, window, OpticalWorkspace),
	    send(OpticalWorkspace, instance_of, optical_workspace)
	->  send(OpticalWorkspace, auto_switch_on)
	;   true
	),
	send(D, destroy),
	log(end).

value(D, Attribute:name, Value:any) :->
	get(D, hypered, client, Client),
	send(Client, Attribute, Value),
	log(tool(Attribute, Value)).
value(D, Attribute:name, Value:any) :<-
	get(D, hypered, client, Client),
	get(Client, Attribute, Value).

:- pce_end_class.

:- pce_begin_class(real_item, text_item).

variable(low,	 real,	        both,	"Lowest value").
variable(high,	 real*,	        both,	"highest value").
variable(format, name := '%g',	both,	"How values are formatted").
variable(allow_default, bool := @off, both, "'' <-> @default").

initialise(RI, Label:name, Low:real, High:real*, Msg:[code]*) :->
	send(RI, send_super, initialise, Label, '', Msg),
	send(RI, length, 8),
	send(RI, slot, low, Low),
	send(RI, slot, high, High).

selection(RI, Sel:[real]) :<-
	get(RI, get_super, selection, Text),
	(   get(@pce, convert, Text, real, Sel)
	->  get(RI, low, Low),
	    get(RI, high, High),
	    (   Sel >= Low,
		(   High == @nil
		;   Sel =< High
		)
	    ->  true
	    ;   (   High == @nil
		->  send(RI, report, error, 'Minimum value is %g', Low)
		;   send(RI, report, error,
			 'Value out of range (%g .. %g)', Low, High)
		),
		fail
	    )
	;   get(RI, allow_default, @on),
	    new(S, string('%s', Text)),
	    send(S, strip),
	    get(S, size, 0)
	->  Sel = @default
	;   send(RI, report, error,
		 'Please enter a valid number'),
	    fail
	).

selection(RI, Sel:[real]) :->
	(   Sel == @default
	->  send(RI, clear)
	;   get(RI, format, Fmt),
	    send(RI, send_super, selection, string(Fmt, Sel))
	).


:- pce_end_class.
	
	

