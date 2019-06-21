/*  $Id: protractor.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(protractor, []).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(save).
:- use_module(tool).
:- use_module(log).
:- use_module(util).
:- require([ concat/3
	   , default/3
	   , pow/3
	   , round/2
	   , send_list/3
	   , sqrt/2
	   ]).

:- pce_begin_class(protractor(path, segment, location), device,
		   "Protector for part of path").
:- use_class_template(gauge).

variable(segment,	'1..',	get,  "Segment mesured").
variable(location,	real,	get,  "Location relative to start of segment").

to_graphical(Gr, Gr) :-
	object(Gr), !.
to_graphical(Name, Gr) :-
	get(@optical_workspace, member, Name, Gr).

initialise(P, PathSpec:'path|name', Segment:'1..', Location:real) :->
	to_graphical(PathSpec, Path),
	send(P, send_super, initialise),
	send(P, display, new(C, circle(35))),
	send(P, display, new(T, gauge_text)),
	send(T, background, @nil),
	send(T, value_format, '\n%.1f'),
	send(C, pen, 0),
	send(C, fill_pattern, colour(navajo_white)),
	send_list([C, T], center, point(0,0)),
	new(_, depto_hyper(Path, P, gauge, path)),
	send(P, slot, segment, Segment),
	send(P, slot, location, Location).

path(P, Path:path) :<-
	get(P, hypered, path, Path).

:- instrument_state([path, segment, location, varname]).
state(P, Scene:scene_state, State:chain) :<-
	slot_states(Scene, P, State).


update(P) :->
	get(P, member, gauge_text, T),
	(   get(P, hypered, path, Beam),
	    get(Beam, device, Dev), Dev \== @nil,
	    get(Beam, points, Pts),
	    get(P, segment, Segment),
	    NSegment is Segment + 1,
	    get(Pts, nth1, Segment,  point(X1, Y1)),
	    get(Pts, nth1, NSegment, point(X2, Y2))
	->  get(Beam, angle, Segment, Rads),
	    Angle is Rads * 180 / pi,
	    send(T, value, Angle),
	    get(P, location, Loc),
	    get(Beam?window, scale_x, ScaleX),
	    Location is Loc/ScaleX,
	    Len is sqrt((X2-X1)^2 + (Y2-Y1)^2),
	    (	Len =:= 0
	    ->	send(P, device, @nil)
	    ;   (   Location > Len
		->  CX is round((X2+X1)/2), CY is round((Y2+Y1)/2)
		;   Frac is Location / Len,
		    CX is round(X1 + (X2-X1)*Frac),
		    CY is round(Y1 + (Y2-Y1)*Frac)
		),
		send(P, center, point(CX, CY)),
		send(Dev, display, P)
	    )
	;   send(P, device, @nil)
	).
		
/*
device(P, Dev:device*) :->
	send(P, send_super, device, Dev),
	(   Dev == @nil
	->  true
	;   send(P, show_value, @on)
	).
*/

show_value(P, Show:bool) :->
	"Show the value or '?'"::
	send_part(P/gauge_text, show_value(Show)).

:- pce_global(@protractor_recogniser,
	      new(click_gesture(left, '', single,
				message(@receiver, clicked)))).
	      
event(P, Ev:event) :->
	(   send(P, send_super, event, Ev)
	;   send(@protractor_recogniser, event, Ev)
	).


clicked(P) :->
	"Click on ruler"::
	get(P, name, Id),
	get(P?frame, instrument, Instrument),
	(   Instrument == delete
	->  send(P, delete),		% delete!
	    log(delete(Id))
	;   Instrument == tool
	->  send(P, tool)
	).

delete(P) :->
	"Just drop from the window"::
	send(new(snapper), delete, P).


lamp(P, Lamp:lamp1) :<-
	"Find lamp I'm showing the exit angle from"::
	get(P, segment, 1),
	get(P, hypered, path, Beam),
	get(Beam, device, Dev), Dev \== @nil,
	get(Beam, name, Name),
	atom_concat(LampName, '-beam', Name),
	get(Dev, member, LampName, Lamp).


tool(P) :->
	"Apply tool"::
	(   get(P, lamp, _Lamp)
	->  apply_tool(P,
		       [ varname(label(image('vname.lbl')),
				 type(varname)),
			 value(label(image('angle.lbl')),
			       type(real_range(-80, 80, degrees, '%.1f')))
		       ])
	;   apply_tool(P,
		       [ varname(label(image('vname.lbl')),
				 type(varname))
		       ])
	).


value(P, V:real) :->
	"Modify lamp if possible"::
	(   get(P, lamp, Lamp)
	->  send(Lamp, angle, V)
	;   send(P, error, protractor_value_on_bad_segment),
	    fail
	).

:- pce_end_class.


:- pce_begin_class(attach_protractor_gesture, click_gesture,
		   "Attach protractor to segment of path").

variable(segment,	'1..' := 1, get, "Remember ->segment from verify").
variable(location,	int := 0,   get, "Location relative to start").

verify(G, Ev:event) :->
	"Only accept if close to segment"::
	send(G, send_super, verify, Ev),
	get(Ev, receiver, Beam),
	get(Beam, device, Dev),
	get(Ev, position, Dev, Pev),
	get(Beam, segment, Ev, P1),
	get(Beam, points, Pts),
	get(Ev, position, Dev, Pos),
	get(Pts, next, P1, P2),
	new(Line, line),
	send(Line, start, P1),
	send(Line, end, P2),
	get(Line, distance, Pos, D),
	D < 7,
	get(Pts, index, P1, Segment),
	send(G, slot, segment, Segment),
	get(P1, distance, Pev, Location),
	send(G, slot, location, Location).


object(G, Beam:path, Segment:int, P:protractor) :<-
	get(G, location, Loc),
	get(Beam?window, scale_x, ScaleX),
	Location is Loc * ScaleX,
	new(P, protractor(Beam, Segment, Location)),
	get(Beam, window, Window),
	get(Window, next_id, a, Name),
	send(P, name, Name),
	send(P, update),
	send(P, show_value, @on).

terminate(G, Ev:event) :->
	"Attach protractor to proper segment"::
	get(Ev, receiver, Beam),
	get(G, segment, Segment),
	get(G, object, Beam, Segment, P),
	log(add(term(P))).

:- pce_end_class.


:- pce_begin_class(attach_beam_extender_gesture, attach_protractor_gesture,
		   "Attach an extension line").

variable(colour_name,	name*,	get,	"Name of colour to use").

verify(G, Ev:event) :->
	send(G, send_super, verify, Ev),
	get(G, segment, Segment),
	get(Ev, receiver, Beam),
	\+ get(Beam, hypered, gauge,
	       and(message(@arg3, instance_of, beam_extender),
		   @arg3?segment == Segment),
	       _).

object(G, Beam:path, Segment:int, L:beam_extender) :<-
	get(G, colour_name, CName),
	new(L, beam_extender(Beam, Segment, CName)),
	get(Beam, window, Window),
	get(Window, next_id, x, Name),
	send(L, name, Name),
	send(L, update).

extender_colour(light_sky_blue).
extender_colour(lime_green).
extender_colour(orange_red).
extender_colour(magenta).

browse_colour(_, Ev:event, Name:name) :<-
	new(D, dialog('Colour')),
	send(D, append,
	     new(M, menu(colour, choice, message(D, return, @arg1)))),
	send(D, append,
	     button(cancel, message(D, return, @nil))),
	send(M, show_label, @off),
	send(M, layout, vertical),
	(   extender_colour(Colour),
	    new(I, image(@nil, 32, 16, pixmap)),
	    new(L, line(0, 8, 32, 8)),
	    send(L, colour, Colour),
	    send(I, draw_in, L),
	    send(M, append, menu_item(Colour, @default, I)),
	    fail
	;   true
	),
	get(Ev, position, @display, Pos),
	get(Ev?window, frame, Frame),
	send(D, transient_for, Frame),
	send(D, modal, transient),
	get(D, confirm_centered, Pos, Name),
	send(D, destroy),
	Name \== @nil.

terminate(G, Ev:event) :->
	get(G, browse_colour, Ev, ColourName),
	send(G, slot, colour_name, ColourName),
	send(G, send_super, terminate, Ev).

:- pce_end_class.


:- pce_begin_class(beam_extender(path, segment, colour_name), line,
		   "Extend a beam in both directions").

variable(segment,	'1..',	get,  "Segment measured").

initialise(P, BeamSpec:'path|name', Segment:'1..', CN:[name]) :->
	default(CN, blue, TheCN),
	to_graphical(BeamSpec, Beam),
	send(P, send_super, initialise),
	send(P, colour_name, TheCN),
	new(_, depto_hyper(Beam, P, gauge, path)),
	send(P, slot, segment, Segment).

colour_name(P, Name:name) :->
	get(@pce, convert, Name, colour, Colour),
	send(P, colour, Colour).
colour_name(P, Name:name) :<-
	get(P, display_colour, Colour),
	get(Colour, name, Name).

path(P, Beam:path) :<-
	get(P, hypered, path, Beam).

:- instrument_state([path, segment, colour_name]).
state(P, Scene:scene_state, State:chain) :<-
	slot_states(Scene, P, State).

update(P) :->
	(   get(P, hypered, path, Beam),
	    get(Beam, device, Dev), Dev \== @nil,
	    get(Beam, points, Pts),
	    get(P, segment, Segment),
	    NSegment is Segment + 1,
	    get(Pts, nth1, Segment,  point(X1, Y1)),
	    get(Pts, nth1, NSegment, point(X2, Y2)),
	    get(Beam, window, Window),
	    get(Window, visible, area(XL,YT,W,H))
	->  (	X1 =:= X2
	    ->	send(P, points, X1, YT, X1, YT+H)
	    ;	Y1 =:= Y2
	    ->	send(P, points, XL, Y1, XL+W, Y1)
	    ;	XR is XL+W,
	        YL is Y1 - (Y2-Y1) * ((X1-XL) / (X2-X1)),
		YR is Y1 + (Y2-Y1) * ((XR-X1) / (X2-X1)),
		YP1 = YL,
		XP1 = XL,
		YP2 = YR,
		XP2 = XR,
		send(P, points, XP1, YP1, XP2, YP2)
	    ),
	    send(Window, display, P),
	    send(P, hide, Beam)
	;   send(P, device, @nil)
	).
		
event(P, Ev:event) :->
	(   send(P, send_super, event, Ev)
	;   send(@protractor_recogniser, event, Ev)
	).


clicked(P) :->
	"Click on ruler"::
	get(P, name, Id),
	get(P?frame, instrument, Instrument),
	(   Instrument == delete
	->  send(P, delete),		% delete!
	    log(delete(Id))
	).

delete(P) :->
	"Just drop from the window"::
	send(new(snapper), delete, P).

:- pce_end_class.
