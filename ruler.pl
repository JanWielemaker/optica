/*  $Id: ruler.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1996 University of Amsterdam. All rights reserved.
*/

:- module(ruler, []).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(save).
:- use_module(tool).
:- use_module(log).
:- use_module(gauge).
:- require([ gensym/2
	   , send_list/3
	   ]).

:- pce_autoload(tagged_connection, library(pce_tagged_connection)).

		 /*******************************
		 *	       RULER		*
		 *******************************/

:- pce_begin_class(ruler(from, to, offset), tagged_connection,
		   "Connection for measuring distances").
:- use_class_template(gauge).

variable(deleting,	bool := @off,	get, "I am being deleted").

:- pce_global(@rule_line_proto, make_rule_line_proto).

make_rule_line_proto(L) :-
	send(new(L, line(arrows := both)), colour, steel_blue).

:- pce_global(@rule_link,
	      new(link(rule, rule, @rule_line_proto, ruler))).

:- pce_global(@ruler_recogniser,
	      new(click_gesture(left, '', single,
				message(@receiver, clicked)))).

to_graphical(Gr, Gr) :-
	object(Gr), !.
to_graphical(Name, Gr) :-
	get(@optical_workspace, member, Name, Gr0), !,
	(   send(Gr0, instance_of, device),
	    get(Gr0, member, centerline, Gr)
	->  true
	;   get(Gr0, hypered, centerline, Gr)
	->  true
	;   Gr = Gr0
	).
to_graphical(centerline, Gr) :-		% backward compatibility hack!
	get(@optical_workspace?graphicals, find,
	    message(@arg1, instance_of, lamp3),
	    Lamp),
	get(Lamp, hypered, centerline, Gr).

initialise(C, From:'graphical|name', To:'graphical|name',
	   A:[real|link], HF:[name]*, HT:[name]*) :->
	to_graphical(From, F),
	to_graphical(To, T),
	(   number(A)
	->  gensym(rule, HName),
	    (	get(F, orientation, vertical)
	    ->	get(F?window, scale_y, ScaleY),
		get(F?area, y, FY),
		YPos is A / ScaleY - FY,
		XPos = 0
	    ;	get(F?window, scale_x, ScaleX),
		get(F?area, x, FX),
		XPos is A / ScaleX - FX,
		YPos = 0
	    ),
	    new(H, handle(XPos, YPos, rule, HName)),
	    send_list([F, T], handle, H),
	    send(C, send_super, initialise, F, T, @rule_link, HName, HName)
	;   send(C, send_super, initialise, F, T, A, HF, HT),
	    (   get(F, window, Window),
		get(Window, next_id, d, Name)
	    ->  true
	    ;   Name = ''
	    ),
	    send(C, slot, name, Name)
	),
	send(C, tag, new(Label, gauge_text(C))),
	send(Label, unit, cm),
	send(Label, recogniser,
	     handler(any, message(@event, post, C))).

orientation(C, Orientation:{horizontal,vertical}) :<-
	"Horizontal or vertical ruler"::
	get(C, from, From),
	get(From, orientation, O0),
	opposite_orientation(O0, Orientation).

offset(C, Pos:real) :<-
	get(C, window, Window),
	(   get(C, orientation, horizontal)
	->  get(Window, scale_y, ScaleY),
	    get(C, y, Y0),
	    Pos is float(Y0 * ScaleY)
	;   get(Window, scale_x, ScaleX),
	    get(C, x, X0),
	    Pos is float(X0 * ScaleX)
	).

opposite_orientation(horizontal, vertical).
opposite_orientation(vertical, horizontal).

gauge_text(C, GT:gauge_text) :<-
	get(C, tag, GT).

:- instrument_state([from, to, offset, varname]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

value(C, Y:real) :<-
	get(C, window, Window),
	get(C, length, L),
	(   get(C, orientation, vertical)
	->  get(Window, scale_y, ScaleY),
	    Y is float(L * abs(ScaleY))
	;   get(Window, scale_x, ScaleX),
	    Y is float(L * ScaleX)
	).

points(C, X1:[int], Y1:[int], X2:[int], Y2:[int]) :->
	"Set points, and update the displayed value"::
	send(C, send_super, points, X1, Y1, X2, Y2),
	(   get(C, deleting, @off)
	->  get(C, length, L),
	    get(C, window, Window),
	    (   get(C, orientation, horizontal)
	    ->  get(Window, scale_x, ScaleX),
		Val is L * ScaleX
	    ;   get(Window, scale_y, ScaleY),
		Val is L * abs(ScaleY)
	    ),
	    send(C?tag, value, Val)
	;   true
	).

%	->compute
%
%	Tricky!  Normally, this is the super-class (i.e. no need to define),
%	but when we are deleting, we should avoid the compute of the connection
%	to take us back from where we come.  We do however need to invoke the
%	implementation of class line, to force a recompute of the area and
%	visual feedback.  Hence, we get the send-method of the line and invoke
%	this one explicitely :-)

compute(C) :->
	(   get(C, deleting, @off)
	->  send(C, send_super, compute)
	;   get(class(line), send_method, compute, SM),
	    send(SM, send, C)
	).

event(_, Ev:event) :->
	send(@ruler_recogniser, event, Ev).

clicked(C) :->
	"Click on ruler"::
	get(C?frame, instrument, Instrument),
	(   Instrument == delete
	->  send(C, delete),
	    get(C, name, Id),
	    log(delete(Id))
	;   Instrument == tool
	->  send(C, tool)
	).

relative_move(C, Offset:point) :->
	get(C, start, point(SX, SY)),
	get(C, end, point(EX, EY)),
	object(Offset, point(OX, OY)),
	send(C, points, SX+OX, SY+OY, EX+OX, EY+OY).

delete(OI) :->
	"Just drop from the window"::
	send(OI, slot, deleting, @on),
	send(new(snapper), delete, OI).

tool(C) :->
	(   get(C, orientation, horizontal)
	->  Label = 'rulelength.lbl',
	    Type = type(on_bar)
	;   Label = 'vrulelength.lbl',
	    Type = type(real_range(-10, 10, cm, '%.2f'))
	),
	apply_tool(C,
		   [ varname(type(varname)),
		     value(label(image(Label)), Type)
		   ]).

:- pce_group(name).

find_to(Dev, To, To) :-
	get(To, device, Dev), !.
find_to(Dev, To0, To) :-
	get(To0, device, To1),
	To1 \== @nil,
	find_to(Dev, To1, To).

value(C, Val:real) :->
	get(C, window, Window),
	get(C, device, CommonDev),
	get(C, from, From0),
	get(C, to, To0),
	find_to(CommonDev, From0, From),
	find_to(CommonDev, To0, To),
	(   get(C, orientation, horizontal)
	->  get(Window, scale_x, ScaleX),
	    get(From, x, FX),
	    TX is FX + Val/ScaleX,
	    send(To, x, TX)
	;   get(Window, scale_y, ScaleY),
	    get(From, y, FY),
	    TY is FY - Val/ScaleY,
	    send(To, y, TY)
	),
	send(C?tag, value, Val),
	send(Window, update).

:- pce_end_class.

		 /*******************************
		 *       CONNECT A RULER	*
		 *******************************/

:- pce_begin_class(ruler_gesture, connect_gesture,
		   "Create a ruler between two construction lines").

variable(handle,	handle*,	get, "Handle created at <-from").

initialise(RG, B:[button_name], M:[modifier], L:[link]) :->
	send(RG, send_super, initialise, B, M, L).

verify(G, Ev:event) :->
	"Prepare our ruler"::
	get(Ev, receiver, Target),	% Target is a centerline!
	get(Target, window, Window),
	get(Window?frame, instrument, ruler),
	gensym(rule, HandleName),
	send(G, slot, from_handle, HandleName),
	(   get(Target, orientation, vertical)
	->  get(Ev, y, Target, HY),
%	    send(G, cursor, sb_h_double_arrow),
	    HX = 0
	;   get(Ev, x, Target, HX),
%	    send(G, cursor, sb_v_double_arrow),
	    HY = 0
	),
	send(Target, handle, new(H, handle(HX, HY, rule, HandleName))),
	send(G, slot, handle, H),
	send(G, send_super, verify, Ev),
	send(G, device, Window).

drag(G, Ev:event) :->
	"Drag, `loodrecht' on centerline"::
	get(G, device, Dev),
	get(Ev, receiver, FromTarget),
	(   get(FromTarget, orientation, vertical)
	->  get(Ev, x, Dev, X),
	    send(G?line, end_x, X)
	;   get(Ev, y, Dev, Y),
	    send(G?line, end_y, Y)
	),
	(   get(G, pointed, Ev, Pointed),
	    get(Pointed, head, Target)
	->  send(G, slot, to, Target),
	    send(G, indicate_target, Target)
	;   send(G, slot, to, @nil),
	    send(G?to_indicators, for_all,
		 and(message(@arg1, device, @nil),
		     message(@arg1, name, unused)))
	).


indicate_target(G, Target:graphical) :->
	"Indicate the target"::
	get(G, device, Dev),
	get(Target, absolute_position, Dev, point(TX, TY)),
	(   get(Target, orientation, vertical)
	->  X = TX,
	    get(G?line, y, Y)
	;   Y = TY,
	    get(G?line, x, X)
	),
	(   get(G?to_indicators, find, @arg1?name == unused, Bitmap)
	->  true
	;   send(G?to_indicators, append,
		 new(Bitmap, bitmap(@mark_handle_image)))
	),
	send(Bitmap, name, used),
	send(Bitmap, center, point(X, Y)),
	send(Dev, display, Bitmap).


pointed(G, Ev:event, Objects:chain) :<-
	"Find other ruler (recursively in sub-devices)"::
	get(Ev, receiver, Gr),
	get(Gr, orientation, O),
	get(G, device, Dev),
	get(Dev, find, Ev,
	    and(or(message(@arg1, instance_of, construction_line),
		   message(@arg1, instance_of, centerline)),
		Gr \== @arg1,
		@arg1?orientation == O),
	    Target),
	new(Objects, chain(Target)).
	    

terminate(G, Ev:event) :->
	get(G, handle, HandleFrom),
	(   get(G, to, To), To \== @nil
	->  get(Ev, receiver, Target),
	    gensym(rule, HandleName),
	    (	get(Target, orientation, vertical)
	    ->  get(HandleFrom, y_position, YPos),
		XPos = 0
	    ;	get(HandleFrom, x_position, XPos),
		YPos = 0
	    ),
	    send(To, handle, handle(XPos, YPos, rule, HandleName)),
	    send(G, slot, from_handle, HandleFrom?name),
	    send(G, slot, to_handle,   HandleName)
	;   true			% remove dummy handle!
	),
	send(G, send_super, terminate, Ev).
	    

connect(_, F:graphical, T:graphical, L:link, FH:[name], TH:[name]) :->
	new(R, ruler(F, T, L, FH, TH)),
	send(R, compute),
	send(R, show_value, @on),
	log(add(term(R))).

:- pce_end_class.

