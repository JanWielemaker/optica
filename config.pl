/*  $Id: config.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(config, []).
:- use_module(library(pce)).
:- use_module(util).
:- use_module(save).
:- use_module(configdb).
:- use_module(language).
:- use_module(test).			% TBD
:- require([ absolute_file_name/3
	   , chain_list/2
	   , checklist/2
	   , concat_atom/3
	   , default/3
	   , forall/2
	   , get_chain/3
	   , is_list/1
	   , member/2
	   , memberchk/2
	   , send_list/3
	   ]).

:- pce_autoload(reorder_icon_gesture, gesture).
:- pce_autoload(directory_item, library(file_item)).

value_set(radius,
	  [ value_set_type(0-inf),
	    editable(false),
	    default(5)
	  ]).
value_set(thickness,
	  [ value_set_type(0-inf),
	    editable(false),
	    default(0.1)
	  ]).
value_set(focal_distance,
	  [ value_set_type([-50-50]),
	    editable(true),
	    default(5)
	  ]).
value_set(pos_x,
	  [ value_set_type(on_bar),
	    editable(true)
	  ]).
value_set(pos_y,
	  [ value_set_type(-10-10),
	    editable(true)
	  ]).
value_set(varname,
	  [ value_set_type(name),
	    editable(true)
	  ]).
value_set(label,
	  [ value_set_type(name),
	    editable(false)
	  ]).
value_set(switch,
	  [ value_set_type(bool),
	    editable(false),
	    default(@on)
	  ]).
value_set(read_only,
	  [ value_set_type(bool),
	    editable(false),
	    default(@off)
	  ]).
value_set(divergence,
	  [ value_set_type(0-80),
	    editable(false),
	    default(5)
	  ]).
value_set(separation,
	  [ value_set_type(0-5),
	    editable(false),
	    default(0.5)
	  ]).
value_set(show_gauge,
	  [ value_set_type(bool),
	    editable(false),
	    default(@on)
	  ]).
value_set(angle,
	  [ value_set_type(-80-80),
	    editable(true),
	    default(0)
	  ]).
value_set(sfere_left,
	  [ value_set_type([-100-100]),
	    editable(true),
	    default(50)
	  ]).
value_set(sfere_right,
	  [ value_set_type([-100-100]),
	    editable(true),
	    default(50)
	  ]).
value_set(breaking_index,
	  [ value_set_type(0.5-5),
	    editable(true),
	    default(1.51)
	  ]).
value_set(unit,
	  [ value_set_type(0.1-2),
	    editable(true),
	    default(1)
	  ]).


instrument_class(lens,
		 [ image('poslens.xpm')
		 ]).
instrument_class(lamp1,
		 [ image('lamp1.xpm')
		 ]).
instrument_class(parlamp,
		 [ image('parlamp.xpm')
		 ]).
instrument_class(lamp3,
		 [ image('rbulb.xpm')
		 ]).
instrument_class(biglamp,
		 [ image('biglamp.xpm')
		 ]).
instrument_class(shield,
		 [ image('shield.xpm')
		 ]).
instrument_class(shield2,
		 [ image('shield2.xpm')
		 ]).
instrument_class(eye,
		 [ image('eyeshield.xpm')
		 ]).

tool(dotruler,		'dotruler.xpm').
tool(consline,		'consline.xpm').
tool(hconsline,		'hconsline.xpm').
tool(ruler,		'ruler.xpm').
tool(protractor,	'protractor.xpm').
tool(extend_beam,	'extbeam.xpm').
tool(show_gauges,	'showgauge.xpm').
tool(switch,		'switch.xpm').
tool(calculator,	'calc.xpm').
tool(tool,		'tool.xpm').
tool(rotlamp,		'rotlamp.xpm').
tool(movelamp,		'movelamp.xpm').
tool(xmove,		'xmove.xpm').
tool(ymove,		'ymove.xpm').
tool(move,		'move.xpm').
tool(delete,		'snapr.xpm').
tool(delete_all,	'snapall.xpm').
tool(hypothesis_editor, 'quant.xpm').
tool(notebook, 		'idea.xpm').
tool(theory_viewer,	'theory.xpm').
tool(assignment_viewer,	'assignment.xpm').
tool(help_viewer,	'winhelp.xpm').
tool(save,		'save.xpm').
tool(restore,		'restore.xpm').


		 /*******************************
		 *     INSTRUMENT ATTRIBUTES	*
		 *******************************/

:- pce_begin_class(attribute_item, dialog_group,
		   "Editor for an attribute").

column([0, r(130-10), 40, 110, 150, 0]) :-
	current_language(dutch), !.
column([0, r(100-10), 35, 80, 150, 0]).

variable(selection,      attribute_specifier,
	 get, "Current specifier").
variable(modified,	 bool := @off,
	 get, "Item was modified").
variable(value_set_type, {bool,name,real,range,on_bar},
	 get, "Type category").

initialise(AI, Name:name) :->
	send(AI, send_super, initialise, Name, group),
	send(AI, display, new(Anchor, graphical(0,0,0,1))),
	get(AI, label_name, Name, LabelText),
	send(AI, display, new(Label, label(label, LabelText, bold))),
	send(Anchor, name, anchor),
	send(Label, length, 0),
	send(AI, display, ticker(edit, @on, message(AI, edit, @arg1))),
	send(AI, display,
	     new(Type, menu(type, cycle, message(AI, type, @arg1)))),
	send_list(Type, append, [bool, range, on_bar, set, name]),
	send(Type, show_label, @off),
	layout(AI).
	
layout_dialog(AI) :->
	layout(AI).

layout(AI) :-
	send(AI?graphicals, for_all,
	     if(message(@arg1, has_send_method, layout_dialog),
		message(@arg1, layout_dialog))),
	get_chain(AI, graphicals, Grs),
	column(Alignments),
	layout(Alignments, Grs, 0).

layout([], _, _) :- !.
layout(_, [], _) :- !.
layout([r(W-Sep)|Ta], [Gr|Tg], X) :- !,
	NX is X + W,
	get(Gr, width, GrW),
	GrX is NX - GrW - Sep,
	send(Gr, set, GrX),
	layout(Ta, Tg, NX).
layout([W|Ta], [Gr|Tg], X) :- !,
	send(Gr, set, X),
	NX is X + W,
	layout(Ta, Tg, NX).

value_set(AI, T:{bool,range,on_bar,set,name},
	      Low:[real], High:[real|{inf}]) :->
	get(AI, member, type, Menu),
	send(Menu, active_all_items, @off),
	send(Menu, active_item, T, @on),
	(   T \== bool
	->  send(Menu, active_item, set, @on)
	;   true
	),
	send(Menu, selection, T),
	send(AI, type, T),
	(   T == range
	->  (   float(Low)
	    ->	send_parts(AI/value_set/low, selection(Low))
	    ;	true
	    ),
	    (	float(High)
	    ->	send_parts(AI/value_set/high, selection(High))
	    ;	true
	    )
	;   true
	).

default_value(AI, Value) :->
	send_parts(AI/value, selection(Value)).

edit(AI, Val:bool) :->
	"Edit toggle was changed"::
	send_parts(AI/[type,value_set], active(Val)).

type(AI, T:{bool,range,on_bar,set,name}) :->
	send_parts(AI/[value_set,value], destroy),
	value_set_item(T, VSItem),
	value_item(T, VItem),
	send(VItem, show_label, @off),
	send(AI, display, VSItem),
	send(AI, display, VItem),
	send(AI, layout_dialog).
	
value_set_item(range, Group) :- !,
	new(Group, dialog_group(value_set, group)),
	send(Group, append, new(L, text_item(low, ''))),
	send(Group, append, new(Sep, label(sep, to)), right),
	send(Sep, length, 0),
	send(Group, append, new(H, text_item(high, '')), right),
	send_list([L, H], length, 6),
	send_list([L, H], show_label, @off),
	send(Group, gap, size(5, 0)).
value_set_item(set, Item) :- !,
	new(Item, text_item(value_set, '')),
	send(Item, show_label, @off),
	send(Item, set, width := 130).
value_set_item(_, Item) :- !,		% no value-set
	new(Item, graphical),
	send(Item, name, value_set).

value_item(bool, Item) :- !,
	new(Item, menu(value, choice)),
	send_list(Item, append,
		  [ menu_item(@off, @default, false),
		    menu_item(@on, @default, true)
		  ]).
value_item(range, Item) :- !,
	new(Item, text_item(value, '')),
	send(Item, length, 6).
value_item(set, Item) :- !,
	new(Item, text_item(value, '')),
	send(Item, length, 6).
value_item(name, Item) :- !,
	new(Item, text_item(value, '')),
	send(Item, length, 6).

:- pce_end_class.

make_title_item(TI, Titles) :-
	new(TI, dialog_group(title, group)),
	send(TI, send_method,
	     send_method(layout_dialog, new(vector), new(and))),
	send(TI, display, graphical(0,0,0,1)),
	forall(member(T, Titles),
	       (   get(TI, label_name, T, Text),
		   send(TI, display, new(L, label(title, Text, bold))),
		   send(L, length, 0)
	       )),
	layout(TI).

		 /*******************************
		 * INSTRUMENT ATTRIBUTE DIALOG	*
		 *******************************/

:- pce_begin_class(instrument_config_item, dialog_group,
		   "Dialog for configuring a tool").

variable(instrument_class,	name,	get, "Classname of the instrument").

initialise(CI, Class:name) :->
	send(CI, send_super, initialise, attributes),
	send(CI, slot, instrument_class, Class),
	make_title_item(TI, [attribute, edit, type, value_set, default]),
	send(CI, append, TI),
	send(CI, append, graphical(0,0,0,5)),
	instrument_state(Class, Attributes),
	forall(member(A, Attributes),
	       add_attribute_editor(CI, Class, A)).

add_attribute_editor(CI, Class, A) :-
	instrument_class(Class, Options),
	send(CI, append, new(AI, attribute_item(A))),
	default_settings(AI, Options, A).

value_set_option(Attribute, Options, Opt) :-
	(   memberchk(value_set(Attribute, Opt0), Options)
	->  true
	;   Opt0 = []
	),
	(   member(Opt, Opt0)
	;   value_set(Attribute, Opt1),
	    member(Opt, Opt1),
	    functor(Opt, N, A),
	    functor(VO, N, A),
	    \+ memberchk(VO, Opt0)
	).


default_settings(AI, Options, A) :-
	value_set_option(A, Options, Term),
	default_settings(Term, AI),
	fail.
default_settings(_,_,_).

default_settings(editable(false), AI) :-
	send_parts(AI/edit, selection(@off)),
	send(AI, edit, @off).
default_settings(value_set_type([Low-High]), AI) :- !,
 	send(AI, value_set, range, Low, High).
default_settings(value_set_type(Low-High), AI) :- !,
 	send(AI, value_set, range, Low, High).
default_settings(value_set_type(VST), AI) :-
	send(AI, value_set, VST).
default_settings(default(Default), AI) :-
	send(AI, default_value, Default).

:- pce_end_class.

:- pce_begin_class(instrument_item, labeled_dialog_item,
		   "Item for the instruments").

variable(hor_stretch, int := 100, both, "Stretchability").

initialise(II, Name:name, Def:'any|function', Msg:[code]*) :->
	send(II, send_super, initialise, Name, Def, Msg),
	send(II, display, new(W, window(size := size(400, 120)))),
	send(II, display, new(B1, button(new)), point(0,0)),
	send(II, display, new(B2, button(browse)), point(0,0)),
	send(II, display, new(B3, button(separate)), point(0,0)),
	send(B1, label, image('newtool.xpm')),
	send(B2, label, image('browse.xpm')),
	send(B3, label, image('separate.xpm')),
	send(B1, help_message, tag, 'Define new instrument'),
	send(B2, help_message, tag, 'Browse defined instruments'),
	send(B3, help_message, tag, 'Add small space'),
	send(W, name, item),
	send(W, format, format(horizontal, 200, @off)),
	send(W, resize_message, message(W, format, width, W?width - 10)),
	send(W, recogniser,
	     click_gesture(left, '', single, message(W, selection, @nil))),
	send(W, scroll_to, point(-5, -5)).

geometry(II, X:[int], Y:[int], W:[int], H:[int]) :->
	(   W \== @default
	->  get(II, member, item, Item),
	    get(II, member, new, New),
	    get(II, member, browse, Browse),
	    get(II, member, separate, Sep),
	    get(New, width, IW),
	    IX is W - IW,
	    send(Item, right_side, IX-10),
	    stack_icons([New, Browse, Sep], IX, 0)
	;   true
	),
	send(II, send_super, geometry, X, Y, W, H).
	   
stack_icons([], _, _).
stack_icons([H|T], X, Y) :-
	send(H, set, X, Y),
	get(H, height, DY),
	NY is Y + DY,
	stack_icons(T, X, NY).

selection(II, Sel:chain) :<-
	get_part(II/item, graphicals, Grs),
	get(Grs, map, @arg1?name, Sel).
selection(II, Sel:chain) :->
	get(II, member,	item, Win),
	send(Win, clear),
	send(Sel, for_all,
	     message(Win, display,
		     create(instrument_config_icon, @arg1))).


separate(II) :->
	"Add as separator line"::
	send_part(II/item, display(instrument_config_icon(separator))).

browse(II) :->
	get(II, member, item, Window),
	findall(I, importable_instrument(Window, I), BrowseList),
	(   BrowseList == []
	->  send(II, report, error, 'No more instruments'),
	    fail
	;   new(P, picture),
	    send(P, format, format(horizontal, P?width, @off)),
	    send(P, scroll_to, point(-5,-5)),
	    forall(member(I, BrowseList),
		   send(P, display, instrument_config_button(I))),
	    send(new(D, dialog), below, P),
	    send(D, append, button(cancel, message(D, return, @nil))),
	    get(II, frame, Frame),
	    send(P, transient_for, Frame),
	    send(P, modal, transient),
	    get(P, confirm_centered, Frame?area?center, Base),
	    send(P, destroy),
	    (   Base \== @nil
	    ->  send(Window, display, instrument_config_icon(Base))
	    ;   true
	    )
	).

importable_instrument(Window, I) :-
	config(instrument(I, _, _)),
	\+ get(Window, member, I, _).


new(II) :->
	"Create a new instrument"::
	get(II, frame, Frame),
	new(D, dialog('Create new instrument')),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	send(D, append, label(reporter, 'Define a new instrument')),
	send(D, append, new(N, text_item(name))),
	send(D, append, new(C, menu(class, choice))),
	forall(instrument_class(Class, Options),
	       ( memberchk(image(Image), Options),
		 send(C, append, menu_item(Class, @default, image(Image))))),
	send(C, columns, 2),
	send(D, append, new(I, label(icon, image('poslens.xpm')))),
	send(D, append,
	     new(B, button('browse ...',
			   message(@prolog, browse_icon, I))), right),
	send_list([I,B], alignment, right),
	send(I, reference, point(0, I?height/2)),
	send(B, reference, point(0, B?height/2)),
	send(D, append, new(Ok, button(ok, and(message(II, new_2, 
						       N?selection,
						       C?selection,
						       I?selection),
					       message(D, destroy)))),
	     next_row),
	send(D, append, button(cancel, message(D, destroy))),
	send(Ok, default_button, @on),
	send(D, open_centered, Frame?area?center).


new_2(II, Name:name, Class:name, I:image) :->
	"New, specify attributes"::
	valid_instrument_name(Name),
	get(II, frame, Frame),
	new(D, instrument_dialog(Name, Class, I)),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	get(D, confirm_centered, Frame?area?center, Ok),
	(   Ok == saved
	->  get_part(D/name, selection, Name),
	    send_part(II/item, display(instrument_config_icon(Name)))
	;   true
	),
	send(D, destroy).


valid_instrument_name(Name) :-
	(   Name == ''
	->  send(@display, inform, 'Please enter a name'),
	    fail
	;   config(instrument(Name, _, _))
	->  send(@display, confirm, 'Redefine instrument %s?', Name)
	;   builtin_instrument(Name)
	->  send(@display, inform, 'Instrument name %s is reserved', Name),
	    fail
	;   true
	).

builtin_instrument(Name) :-
	instrument:instrument(Name, _).	% hack

browse_icon(Label) :-
	get(Label, frame, Frame),
	browse_icon(Frame, ImageName),
	send(Label, selection, image(ImageName)).

:- pce_end_class.


:- pce_begin_class(instrument_config_icon, device,
		   "Icon for an instrument (config)").

:- pce_global(@config_icon_popup, make_config_icon_popup).

make_config_icon_popup(P) :-
	new(P, popup(options)),
	send_list(P, append,
		  [ menu_item(edit,
			      message(@arg1, open)),
		    menu_item(copy,
			      message(@arg1, copy)),
		    menu_item(delete,
			      message(@arg1, delete))
		  ]).

:- pce_global(@config_icon_recogniser,
	      new(handler_group(click_gesture(left, '', single,
					      message(@receiver?device,
						      selection,
						      @receiver)),
				click_gesture(left, '', double,
					      message(@receiver, open)),
				reorder_icon_gesture(left),
				popup_gesture(@config_icon_popup)))).
	      
initialise(II, Name:name) :->
	(   config(instrument(Name, Options, _)),
	    memberchk(icon(Image), Options)
	->  true
	;   Name == separator
	->  Image = 'separator.xpm'
	),
	send(II, send_super, initialise),
	send(II, name, Name),
	send(II, display, bitmap(Image)),
	send(II, display, text(Name, center, normal)),
	send(II, recenter).

event(_, Ev:event) :->
	send(@config_icon_recogniser, event, Ev).

recenter(II) :->
	"Align label under icon"::
	get(II, member, bitmap, BM),
	get(II, member, text, Txt),
	get(BM, bottom_side, Y),
	get(BM, center_x, CX),
	send(Txt, center_x, CX),
	send(Txt, y, Y).

open(II) :->
	"Edit the associated instrument"::
	get(II, name, Name),
	new(D, instrument_dialog(Name)),
	send(D, instrument, Name),
	get(II, frame, Frame),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	get(D, confirm_centered, Frame?area?center, _),
	send(D, destroy).

copy(II) :->
	"Copy the instrument"::
	get(II, frame, Frame),
	new(D, dialog('New name')),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	send(D, append, new(NI, text_item(name_for_copy, ''))),
	send(D, append, button(ok,
			       and(message(II, copy_to, NI?selection),
				   message(D, destroy)))),
	send(D, append, button(cancel,
			       message(D, destroy))),
	send(D, default_button, ok),
	send(D, open_centered, Frame?area?center).

copy_to(II, Name:name) :->
	"Copy to new name"::
	valid_instrument_name(Name),
	get(II, name, Org),
	config(instrument(Org, O, A)),
	add_config(instrument(Name, O, A)),
	send(II?device, display, instrument_config_icon(Name)).

delete(II) :->
	"Delete associated instrument"::
	free(II).

:- pce_end_class.

:- pce_begin_class(instrument_config_button, device,
		   "Select instrument button (config)").

initialise(II, Name:name) :->
	config(instrument(Name, Options, _)),
	memberchk(icon(Image), Options),
	send(II, send_super, initialise),
	send(II, name, Name),
	send(II, display,
	     new(B, button(button, message(II?frame, return, Name)))),
	send(B, label, image(Image)),
	send(II, display,
	     text(Name, center, normal)),
	send(II, recenter),
	send(II, recogniser, @config_icon_recogniser).

recenter(II) :->
	"Align label under icon"::
	get(II, member, button, BM),
	get(II, member, text, Txt),
	get(BM, bottom_side, Y),
	get(BM, center_x, CX),
	send(Txt, center_x, CX),
	send(Txt, y, Y).

:- pce_end_class.

		 /*******************************
		 *       INSTRUMENT DIALOG	*
		 *******************************/

:- pce_begin_class(instrument_dialog, dialog,
		   "Dialog for instrument properties").

cardinality_label('0..',	0, inf).
cardinality_label('1..',	1, inf).
cardinality_label('0..1',	0, 1).
cardinality_label('1..1',	1, 1).

initialise(D, Name:name, Class:[name], I:[image]) :->
	send(D, send_super, initialise, 'Specify instrument'),
	default(I, image('poslens.xpm'), TheI),
	(   atom(Class)
	->  TheClass = Class
	;   config(instrument(Name, Options, _)),
	    memberchk(class(TheClass), Options)
	->  true
	;   TheClass = poslens
	),
	send(D, append, new(Lbl, label(icon, TheI))),
	send(Lbl, recogniser,
	     click_gesture(left, '', double,
			   message(@prolog, browse_icon, Lbl))),
	send(D, append, new(C, text_item(class, TheClass)), right),
	send(D, append, new(L, text_item(name, Name)), right),
	send_list([C,L], length, 10),
	send(C, editable, @off),
	send(D, append, new(Card, menu(cardinality, cycle)), right),
	forall(cardinality_label(Label, _, _), send(Card, append, Label)),
	send_list([L, C, Card], alignment, left),
	send(D, append, text_item(balloon, '')),
	send(D, append, instrument_config_item(TheClass)),
	send(D, append, button(ok,and(message(D, save),
				      message(D, return, saved)))),
	send(D, append, button(cancel, message(D, return, cancel))).

instrument(D, Name:name) :->
	"Load instrument from config"::
	config(instrument(Name, Options, Attributes)),
	send_part(D/name, selection(Name)),
	forall(set_instrument_option(D, Options), true),
	get(D, member, attributes, AItems),
	checklist(set_instrument_attribute(AItems), Attributes).

set_instrument_option(D, Options) :-
	memberchk(class(Class), Options),
	send_part(D/class, selection(Class)).
set_instrument_option(D, Options) :-
	memberchk(icon(Icon), Options),
	send_part(D/icon, selection(image(Icon))).
set_instrument_option(D, Options) :-
	memberchk(cardinality(Low, High), Options),
	cardinality_label(Label, Low, High),
	send_part(D/cardinality, selection(Label)).
set_instrument_option(D, Options) :-
	memberchk(balloon(Text), Options),
	send_part(D/balloon, selection(Text)).

set_instrument_attribute(AItems, attribute(Name, Options)) :-
	get(AItems, member, Name, AI),
	forall(set_ia_option(AI, Options), true).

set_ia_option(IA, Options) :-
	(   memberchk(edit(How), Options)
	->  send(IA, edit, @on),
	    send_part(IA/edit, selection(@on)),
	    functor(How, Type, _),
	    send(IA, type, Type),
	    send_part(IA/type, selection(Type)),
	    (	arg(1, How, VS)
	    ->	(   VS = Low-High
		->  send_part(IA/value_set/low, selection(Low)),
		    send_part(IA/value_set/high, selection(High))
		;   is_list(VS)
		->  concat_atom(VS, ', ', Text),
		    send_part(IA/value_set, selection(Text))
		)
	    ;	true
	    )
	;   send(IA, edit, @off),
	    send_part(IA/edit, selection(@off))
	).
set_ia_option(IA, Options) :-
	memberchk(default(Def), Options),
	(   Def == (*)
	->  send_part(IA/value, selection(''))
	;   send_part(IA/value, selection(Def))
	).


save(D) :->
	"Save settings of dialog to the database"::
	get_part(D/icon,        selection, Icon),
	get_part(D/class,       selection, Class),
	get_part(D/name,        selection, Name),
	get_part(D/cardinality, selection, CardLabel),
	get_part(D/balloon,	selection, Balloon),
	get(Icon, name, ImageFile),
	get(D, member, attributes, CI),
	get_chain(CI, graphicals, Grs),
	instrument_attributes(Grs, Attributes),
	cardinality_label(CardLabel, Low, High),
	Term = instrument(Name,
			  [ class(Class),
			    icon(ImageFile),
			    cardinality(Low, High),
			    balloon(Balloon)
			  ],
			  Attributes),
	del_config(instrument(Name, _, _)),
	add_config(Term).


instrument_attributes([], []).
instrument_attributes([IA|T0], [attribute(Name, Options)|T]) :-
	send(IA, instance_of, attribute_item), !,
	get(IA, name, Name),
	findall(O, ia_option(IA, O), Options),
	instrument_attributes(T0, T).
instrument_attributes([_|T0], T) :-
	instrument_attributes(T0, T).

ia_option(IA, default(Default)) :-
	get_part(IA/value, selection, Default0),
	(   atom(Default0)
	->  new(S, string('%s', Default0)),
	    send(S, strip),
	    get(S, value, Default1),
	    (	Default1 == ''
	    ->	(   get(IA, name, AttName),
		    value_set(AttName, Options),
		    memberchk(value_set_type([_L-_H]), Options)
		->  Default = (*)
		)
	    ;	atom_codes(Default1, Chars),
		name(Default, Chars)
	    )
	;   Default = Default0
	).

ia_option(IA, edit(How)) :-
	get_part(IA/edit, selection, @on),
	get_part(IA/type, selection, Functor),
	(   ia_value_set(Functor, IA, VS)
	->  How =.. [Functor,VS]
	;   How = Functor
	).

ia_value_set(range, IA, Low-High) :- !,
	get_part(IA/value_set/low, selection, Low0),
	get_part(IA/value_set/high, selection, High0),
	range_argument(Low0, Low),
	range_argument(High0, High).
ia_value_set(set, IA, List) :-
	get_part(IA/value_set, selection, Atom),
	atom_to_list(Atom, List).

range_argument('', inf) :- !.
range_argument(inf, inf) :- !.
range_argument(infinite, inf) :- !.
range_argument(Text, Num) :-
	atom_codes(Text, Chars),
	number_codes(Num, Chars).

:- pce_end_class.


		 /*******************************
		 *     EXPERIMENT CONFIGURATION	*
		 *******************************/

:- pce_begin_class(experiment_dialog, dialog,
		   "Edit an experiment environment").

initialise(D, Exp:[name]) :->
	send(D, send_super, initialise, 'Optica experiment configuration'),
	send(D?frame, attribute, instrument, none),
	send(D, append, new(Idx, text_item(index, 1))),
	send(Idx, length, 3),
	send(D, append, new(Mlenses, text_item(max_lenses, '')), right),
	send(Mlenses, length, 3),
	send(D, append, new(MT, real_item(minimum_time, 0, @nil)), right),
	send(MT, allow_default, @on),
	send(D, append, new(TU, label(time_unit, 'min.')), right),
	send(TU, length, 0),
	send_list([MT, TU], alignment, right),
	send(Mlenses, alignment, center),
	send(D, append, text_item(name, '')),
	send(D, append, new(Tools, menu(tools, toggle))),
	forall(tool(Name, Image),
	       send(Tools, append,
		    menu_item(Name, @default, image(Image)))),
	send(Tools, columns, 2),
	ToolFromEvent = ?(Tools, item_from_event, @event)?value,
	ToolFromPopup = ?(Tools, item_from_event,
			  @arg1?window?focus_event)?value,
	send(Tools, recogniser,
	     click_gesture(left, '', double,
			   message(D, open_tool, ToolFromEvent))),
	send(Tools, popup, new(TP, popup)),
	send(TP, append,
	     menu_item(open,
		       message(D, open_tool, ToolFromPopup),
		       condition := message(D, can_open_tool, ToolFromEvent))),
	send(D, append, thumb_item(initial_state, @nil, @nil, size(600, 120))),
	send(D, append, instrument_item(instruments)),
	send(D, append, button(ok, and(message(D, save),
				       message(D, destroy)))),
	send(D, append, button(cancel, message(D, destroy))),
	(   Exp \== @default
	->  send(D, experiment, Exp)
	;   true
	).

tool_text(theory_viewer,	theory).
tool_text(assignment_viewer,	assignment).
tool_text(help_viewer,		help).

can_open_tool(_, Tool:name) :->
	"Test of `open' applies to this tool"::
	tool_text(Tool, _).

open_tool(D, Tool:name) :->
	"Open tool for configuration"::
	tool_text(Tool, TextId),
	send(D, edit_text, TextId),
	send_part(D/tools, selected(Tool, @on)).

edit_text(D, Which:name) :->
	"Edit associated text"::
	get(D, frame, Frame),
	get_part(D/name, selection, Name),
	new(TV, textviewer(Which, Name, edit := @on)),
	send(TV, transient_for, Frame),
	send(TV, modal, transient),
	send(TV, open_centered, Frame?area?center).

save(D) :->
	"Save to experiment to config database"::
	get_part(D/index, selection, Index),
	get_part(D/max_lenses, selection, ML0),
	get_part(D/minimum_time, selection, MinTime),
	get_part(D/name, selection, Name),
	get_part(D/tools, selection, ToolChain),
	chain_list(ToolChain, Tools),
	get_part(D/initial_state, selection, StateObj),
	(   StateObj == @nil
	->  State = []
	;   state_to_term(StateObj, State)
	),
	get_part(D/instruments, selection, InstrumentChain),
	chain_list(InstrumentChain, Instruments),
	Term = experiment(Name,
			  [ initial_state(State),
			    tools(Tools),
			    instruments(Instruments),
			    index(Index)
			  | Options
			  ]),
	(   MinTime == @default
	->  Options = []
	;   Options = [minimum_time(MinTime)|Options1]
	),
	(   get(@pce, convert, ML0, '0..', ML)
	->  Options1 = [max_lenses(ML)]
	;   Options1 = []
	),
	del_config(experiment(Name, _)),
	add_config(Term),
	(   get(D, transient_for, F),	% broadcast service?
	    F \== @nil
	->  send(F, update)
	;   true
	).

experiment(D, Name:name) :->
	"Load experiment from config database"::
	(   config(experiment(Name, Options))
	->  send_part(D/name, selection(Name)),
	    forall(fill_experiment_options(D, Options), true)
	;   send(D, report, error, 'No such experiment: %s', Name),
	    fail
	).

fill_experiment_options(D, Options) :-
	(   memberchk(initial_state(Term), Options),
	    Term \== []
	->  state_to_term(State, Term),
	    send_part(D/initial_state, selection(State))
	;   send_part(D/initial_state, selection(@nil))
	).
fill_experiment_options(D, Options) :-
	(   memberchk(tools(Tools), Options)
	->  chain_list(ToolChain, Tools),
	    send_part(D/tools, selection(ToolChain))
	;   send_part(D/tools, clear_selection)
	).
fill_experiment_options(D, Options) :-
	(   memberchk(instruments(Instruments), Options)
	->  chain_list(InstrumentChain, Instruments),
	    send_part(D/instruments, selection(InstrumentChain))
	;   send_part(D/instruments, selection(new(chain)))
	).
fill_experiment_options(D, Options) :-
	(   memberchk(index(Index), Options)
	->  send_part(D/index, selection(Index))
	;   send_part(D/index, selection(1))
	).
fill_experiment_options(D, Options) :-
	(   memberchk(minimum_time(MT), Options)
	->  send_part(D/minimum_time, selection(MT))
	;   send_part(D/minimum_time, selection(@default))
	).
fill_experiment_options(D, Options) :-
	(   memberchk(max_lenses(ML), Options)
	->  send_part(D/max_lenses, selection(ML))
	;   send_part(D/max_lenses, selection(''))
	).

:- pce_end_class.


		 /*******************************
		 *     OVERALL CONFIGURATION	*
		 *******************************/

:- pce_begin_class(optica_configure, frame,
		   "The configuration tool").

setting(settings, language,		  [english,dutch],	english).
setting(settings, window,		  [window,full_screen], window).
setting(settings, log,			  bool,			@off).
setting(settings, log_directory,	  directory,		optica(log)).
setting(settings, test_mode,		  bool,			@off).
setting(settings, auto_switch_off,	  bool,			@off).
setting(settings, auto_switch_on,	  bool,			@on).

setting(test,	  pretest,		  identifier,		pretest).
setting(test,	  test_moment,		  [logout,experiment],  logout).
setting(test,	  test_sets,		  identifier_list,	chain(test)).
setting(test,	  test_random_order,	  bool,			@off).
setting(test,     test_scale,		  real(0.3, 2),		0.75).
setting(test,	  test_clear_quickly,	  bool,			@off).
setting(test,     test_font,		  [normal,large,huge],	large).
setting(test,     test_with_ok_button,	  bool,			@off).

initialise(F) :->
	send(F, send_super, initialise, 'Optica Configuration'),
	send(F, append, new(MD, dialog)),
	send(MD, name, menu_dialog),
	send(MD, append, new(menu_bar)),
	send(MD, gap, size(0, 5)),
	send(MD, pen, 0),
	send(new(D, dialog), below, MD),
	send_list([D,MD], gap, size(0, 3)),
	send(D, pen, 0),
	send(D, append, new(TS, tab_stack)),
	setof(Tab, Name^Type^Default^setting(Tab, Name, Type, Default), Tabs),
	forall(member(T, Tabs), send(TS, append, tab(T))),
	send(TS, append, new(ET, tab(experiments))),
	send(ET, append, new(LB, list_browser)),
	send(D, append, button(test)),
	send(D, append, button(quit, message(F, destroy))),
	send(D, append, new(label(reporter))),
	send(LB, attribute, hor_stretch, 100),
	send(LB, open_message, message(F, edit_experiment, @arg1?key)),
	send(F, fill_menu_bar),
	send(F, fill_settings),
	send(F, update).

fill_menu_bar(F) :->
	get_part(F/menu_dialog, member(menu_bar), MB),
	send(MB, append, new(File, popup(file))),
	send(MB, append, new(Exp, popup(experiment))),
	new(CurrentExp, F?experiment_browser?selection?key),
	send_list(File, append, 
		  [ menu_item(load,
			      message(F, load)),
		    menu_item(save,
			      message(F, save)),
		    menu_item(save_as,
			      message(F, save_as),
			      end_group := @on),
		    menu_item(quit,
			      message(F, destroy))
		  ]),
	send_list(Exp, append,
		  [ menu_item(edit,
			      message(F, edit_experiment, CurrentExp),
			      condition := CurrentExp),
		    menu_item(delete,
			      message(F, delete_experiment, CurrentExp),
			      condition := CurrentExp),
		    menu_item(new,
			      message(F, new_experiment))
		  ]).

default_setting(Name, Def) :-
	setting(_, Name, directory, DefSpec), !,
	absolute_file_name(DefSpec, [file_type(directory)], Def).
default_setting(Name, Def) :-
	setting(_, Name, _, Def).

fill_settings(F) :->
	(   setting(TabName, Name, Type, _),
	    get_part(F/dialog/tab_stack/TabName, self, Tab),
	    default_setting(Name, Default),
	    add_setting_item(Tab, Name, Type, Default),
	    fail
	;   true
	).

add_setting_item(Tab, Name, bool, Def) :- !,
	send(Tab, append, new(TB, right_tick_box(Name))),
	send(TB, selection, Def).
add_setting_item(Tab, Name, directory, Def) :- !,
	send(Tab, append, directory_item(Name, Def)).
add_setting_item(Tab, Name, real(Low, High), Def) :- !,
	send(Tab, append, new(I, real_item(Name, Low, High))),
	send(I, selection, Def).
add_setting_item(Tab, Name, name, Def) :- !,
	send(Tab, append, text_item(Name, Def)).
add_setting_item(Tab, Name, identifier, Def) :- !,
	send(Tab, append, identifier_item(Name, Def)).
add_setting_item(Tab, Name, identifier_list, Def) :- !,
	send(Tab, append, new(II, identifier_list_item(Name, ''))),
	send(II, selection, Def).
add_setting_item(Tab, Name, List, Def) :-
	is_list(List), !,
	send(Tab, append, new(M, menu(Name, choice))),
	send_list(M, append, List),
	send(M, selection, Def).

experiment_browser(F, EB:list_browser) :<-
	get_part(F/dialog/tab_stack/experiments/list_browser, self, EB).

external_value(@on,	true)  :- !.
external_value(@off,	false) :- !.
external_value(Chain,   List)  :-
	object(Chain),
	send(Chain, instance_of, chain), !,
	chain_list(Chain, List).
external_value(Chain,   List)  :-
	is_list(List), !,
	chain_list(Chain, List).
external_value(X,	X).

update(F) :->
	get(F, experiment_browser, Browser),
	send(Browser, clear),
	experiments(Names),
	send_list(Browser, append, Names),
	(   setting(TabName, Name, _, _),
	    get_part(F/dialog/tab_stack/TabName, self, Tab),
	    (	Term =.. [Name, ExtValue],
		config(Term),
		external_value(Value, ExtValue)
	    ->	true
	    ;	default_setting(Name, Value)
	    ),
	    get(Tab, member, Name, Item),
	    send(Item, selection, Value),
	    fail
	;   true
	).

test(F) :->
	"Run test session"::
	send(F, save_settings),
	new(O, optica),
	send(O, attach_experiment_menu),
	send(O, open),
	send(O, attribute, test_version, @on),
	(   get(F, experiment_browser, B),
	    get(B, selection, ExpItem)
	->  get(ExpItem, key, Exp),
	    send(O, experiment, Exp)
	;   true
	).
	    

save_settings(F) :->
	(   setting(TabName, Name, _, _),
	    get_part(F/dialog/tab_stack/TabName, self, Tab),
	    get(Tab, member, Name, Item),
	    get(Item, selection, Value),
	    functor(Pattern, Name, 1),
	    del_config(Pattern),
	    external_value(Value, ExtValue),
	    Term =.. [Name, ExtValue],
	    add_config(Term),
	    fail
	;   true
	).

load(F) :->
	get(@finder, file, @on, '.opa', ConfigFile),
	load_config(ConfigFile),
	send(F, update).
	
save(F) :->
	send(F, save_settings),
	(   config(config_file(File))
	->  save_config(File),
	    send(F, report, status, 'Saved to %s', File)
	;   send(F, report, error, 'No current file'),
	    fail
	).

save_as(F) :->
	get(@finder, file, @off, '.opa', ConfigFile),
	send(F, save_settings),
	del_config(config_file(_)),
	add_config(config_file(ConfigFile)),
	save_config(ConfigFile),
	send(F, report, status, 'Saved to %s', ConfigFile).

new_experiment(F) :->
	get(F, experiment_browser, Browser),
	get(Browser?dict?members, size, N),
	Index is N + 1,
	new(E, experiment_dialog),
	send_part(E/index, selection(Index)),
	send(E, transient_for, F),
	send(E, modal, transient),
	send(E, open_centered, F?area?center).

edit_experiment(F, Exp:name) :->
	new(E, experiment_dialog(Exp)),
	send(E, transient_for, F),
	send(E, modal, transient),
	send(E, open_centered, F?area?center).

delete_experiment(F, Exp:name) :->
	"Delete the named experiment"::
	send(F?display, confirm, 'Delete experiment %s', Exp),
	del_config(experiment(Exp, _)),
	send(F, update),
	send(F, report, status, 'Deleted experiment %s', Exp).

:- pce_end_class.
