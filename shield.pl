/*  $Id: shield.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1996 University of Amsterdam. All rights reserved.
*/


:- module(shield, []).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(model).
:- use_module(save).
:- use_module(tool).
:- use_module(util).
:- require([ default/3
	   , last/2
	   , pow/3
	   , round/2
	   , send_list/3
	   , sqrt/2
	   , tan/2
	   ]).

:- pce_begin_class(rotated_shield, figure, "Shield with holes or for viewing").

variable(points,	chain,	get,	  "Positions of the holes or spots").
variable(dotsize,	real,	get,	  "Dotsize (cm)").
variable(dot,		image,  get,	  "Image to show a single hole").
variable(size,		size,	get,	  "Size in cm").
variable(scaled,	real,   get,	  "Scale factor").
variable(enlargement,	real,	get,	  "Object enlargement").
variable(unit,		real,	get,	  "Unit-size (cm)").
variable(kind,	{picture,holes,dark,light} := picture,
				get, 	  "Whether there is light").

lpoints(small, chain(point(-1, -2),
		     point(-1, -1),
		     point(-1,	 0),
		     point(-1,  1),
		     point(-1,  2),
		     point( 0,  2),
		     point( 1,  2))).
lpoints(large, chain(point(-2, -4),
		     point(-2, -2),
		     point(-2,	 0),
		     point(-2,  2),
		     point(-2,  4),
		     point( 0,  4),
		     point( 2,  4))).

initialise(S, Points:[chain], Scaled:[real]) :->
	(   Points == @default
	->  lpoints(small, Pts)
	;   Pts = Points
	),
	default(Scaled, 0.5, TheScaled),
	send(S, slot, scaled, TheScaled),
	send(S, send_super, initialise),
	send(S, slot, points, Pts),
	send(S, slot, dotsize, 0),
	send(S, slot, size, size(8, 10)),
	send(S, slot, enlargement, 1),
	send(S, slot, unit, 1),
	send(S, display, new(B, box(0,0))),
	send(B, pen, 0),
	send(B, fill_pattern, colour(steel_blue)),
	send(B, name, background),
	send(S, request_compute).


compute(S) :->
	(   get(S, request_compute, @nil)
	->  true
	;   scale(S, DevScaleX, DevScaleY),
	    get(S, scaled, Scaled),
	    ScaleX is DevScaleX/Scaled,
	    ScaleY is DevScaleY/Scaled,

	    get(S, slot, size, size(SW, SH)), 		% update the background
	    PW is round(SW/ScaleX), PH is round(SH/ScaleY),
	    get(S, member, background, Bgnd),
	    send(Bgnd, set, -PW/2, -PH/2, PW, PH),
	
	    send(S?graphicals, for_all,			% remove old dots
		 if(message(@arg1, instance_of, circle),
		    message(@arg1, free))),

	    get(S, kind, Kind),
	    (	Kind == light
	    ->	dotcolour(6, DotColour),
		send(Bgnd, fill_pattern, DotColour)
	    ;	send(Bgnd, fill_pattern, colour(steel_blue)),
		(   get(S, kind, dark)
		->  true
		;   get(S, dotsize, DS),
		    PS is min(80, max(1, round(abs(DS/ScaleX)))),
		    dotcolour(PS, Kind, DotColour),
		    get(S, enlargement, Enlargement),
		    get(S, unit,	UnitSize),
		    (	Enlargement*UnitSize =:= 0
		    ->	DotScale = 1
		    ;   DotScale is ScaleX / (Enlargement*UnitSize)
		    ),
		    send(S?points, for_all,
			 message(S, paint_dot,
				 @arg1, DotScale, PS, DotColour))
		)
	    ),
	    send(S, clip_area, area(-PW/2, -PH/2, PW, PH)),
	    send(S, send_super, compute)
	).


scaled(S, Scaled:real) :->
	attribute(S, scaled, Scaled).
enlargement(S, Enlargement:real) :->
	attribute(S, enlargement, Enlargement).
kind(S, Status:{picture,holes,dark,light}) :->
	attribute(S, kind, Status).
dotsize(S, DS:real) :->
	attribute(S, dotsize, DS).
size(S, Size:size) :->
	attribute(S, size, Size).
unit(S, Unit:real) :->
	attribute(S, unit, Unit).

attribute(S, Att, Value) :-
	(   get(S, Att, Value)
	->  true
	;   send(S, slot, Att, Value),
	    send(S, request_compute)
	).


paint_dot(S, Pos:point, Scale:real, PS:int, Colour:colour) :->
	object(Pos, point(X, Y)),
	PS2 is (PS+1)//2,
	CX is round(X/Scale)-PS2,
	CY is round(Y/Scale)-PS2,
	new(C, circle(PS+1)),
	send(C, fill_pattern, Colour),
	send(C, colour, Colour),
	send(S, display, C, point(CX, CY)).

:- dynamic
	dot_colour_cache/2.

dotcolour(PS, DotColour) :-
	dot_colour_cache(PS, DotColour), !.
dotcolour(PS, DotColour) :-
	MaxC is (2^16-1),
	V is round(4 * MaxC / PS),
	new(SB, colour(steel_blue)),
	get(SB, red, R),
	get(SB, green, G),
	get(SB, blue, B),
	Red is   min(MaxC, V+R),
	Green is min(MaxC, V+G),
	DotColour = colour(@default, Red, Green, B),
	send(DotColour, lock_object, @on),
	asserta(dot_colour_cache(PS, DotColour)).

dotcolour(_, holes, black) :- !.
dotcolour(PS, _, Colour) :-
	dotcolour(PS, Colour).

:- pce_end_class.


:- pce_begin_class(shield, collidable_optical_instrument,
		   "Moveable shield with holes").
:- use_class_template(gauge).

variable(dotruler,	bool := @off,	get, "Show distance between dots").

initialise(S) :->
	send(S, send_super, initialise),
	scale(S, ScaleX, ScaleY),
	H is round(abs(5/ScaleY)),
	D is round(0.75/ScaleX),
	send(S, display, new(L, box(3, 2*H)), point(-1, -H)),
	send(S, display, new(centerline)),
	send(L, fill_pattern, @black_image),
	send(L, pen, 0),
	send(S, display, new(RS, rotated_shield)),
	get(RS, height, RSH),
	RSB is -H/2,
	RSY is RSB - RSH,
	send(RS, do_set, D, RSY),
	send(S, display, new(L1, line(0, -H, D, RSY))),
	send(S, display, new(L2, line(0,  H, D, RSB))),
	send_list([L1, L2], texture, dotted),
	get(RS, area, area(AX, AY, AW, _AH)),
	new(T, gauge_text),
	send(T, sensitive, @on),
	send(T, unit, cm),
	send(T, format, right),
	send(T, value_format, '%.2f'),
	send(S, display, T, point(AX+AW-3-T?width, AY+3)),
	send(T, displayed, @off).

left_side(L, Left:int) :<-
	get(L, x, Left).

right_side(L, Right:int) :<-
	get(L, x, Right).

valid(L, Valid:bool) :->
	(   get(L, valid, Valid)
	->  true
	;   send(L, slot, valid, Valid),
	    (	Valid == @on
	    ->	send(L, colour, @default)
	    ;	send(L, colour, red)
	    )
	).


clicked(S) :->
	(   send(S, send_super, clicked)
	->  true
	;   get(S?frame, instrument, dotruler)
	->  send(S, dotruler, @on),
	    send(S, show_value, @on)
	).


:- pce_group(measure).

dotruler(S, Val:bool) :->
	(   get(S, dotruler, Val)
	->  true
	;   send(S, slot, dotruler, Val),
	    get(S, member, gauge_text, Text),
	    send(Text, displayed, Val),
	    send(S, update_dotruler)
	).


update_dotruler(S) :->
	get(S, member, gauge_text, T),
	get(S, member, rotated_shield, RS),
	get(RS, unit, Unit),
	get(RS, enlargement, Mag),
	Value is abs(Unit * Mag),
	send(T, value, Value).


unit(L, Unit:real) :->
	get(L, member, rotated_shield, RS),
	send(RS, unit, Unit),
	send(L, update_dotruler),
	(   get(L, window, Window)
	->  send(Window, update)
	;   true
	).
unit(L, Unit:real) :<-
	get(L, member, rotated_shield, RS),
	get(RS, unit, Unit).


:- instrument_state([pos_x, unit, varname]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).


tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ unit(label(image('dotsep.lbl')),
			  type(real_range(0.1, 2, cm, '%.1f'))),
		     pos_x(label(image('xshield.lbl')),
			   type(on_bar))
		   ]).

dragged(S) :->
	send(S?window, update).


event(S, Ev:event) :->
	(   send(S, send_super, event, Ev)
	;   send(@bench_instrument_recogniser, event, Ev)
	).

update(S) :->
	get(S, device, Window),
	get(S, member, rotated_shield, RS),
	(   get(Window?graphicals, find,
		message(@arg1, instance_of, biglamp),
		Lamp),
	    get(Lamp, switch, @on)
	->  send(RS, kind, picture)
	;   send(RS, kind, holes)
	).

:- pce_end_class.

:- pce_begin_class(shield2, shield, "Moveable shield without holes").

initialise(SH) :->
	send(SH, send_super, initialise),
	scale(SH, ScaleX, _ScaleY),
	get(SH, member, rotated_shield, RS),
	get(RS, area, area(AX, AY, _AW, AH)),
	new(S, sharpness_indicator),
	get(S, height, Sh),
	D is 0.25/ScaleX,
	SY is AY + AH - Sh - D,
	send(SH, display, S, point(AX+D, SY)).

:- instrument_state([pos_x, varname]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ pos_x(label(image('xshield.lbl')),
			   type(on_bar))
		   ]).

update_dotruler(S) :->
	send(S, send_super, update_dotruler),
	get(S, member, gauge_text, T),
	(   get(S, dotruler, @on),
	    get(S, member, sharpness_indicator, SI),
	    get(SI, displayed, @on)
	->  send(T, displayed, @on)
	;   send(T, displayed, @off)
	).

update(SH) :->
	"Update for the current scene"::
	get(SH, device, Window),
	get(SH, x, MyX),
	get(Window, graphicals, Graphicals),
	get(SH, member, rotated_shield, RS),
	get(SH, member, sharpness_indicator, Sharp),
	get(SH, member, gauge_text, Ruler),
	(   get(Graphicals, find,
		and(message(@arg1, instance_of, biglamp),
		    @arg1?x < MyX),
		BigLamp),
	    get(BigLamp, switch, @on),
	    scene_parms(Window, _, _, _) % validate the scene
	->  (   get(Graphicals, find_all,
		    and(@arg1?class_name == shield,
			@arg1?x < MyX),
		    Patterns),
		get(Patterns, size, 1),
		get(Patterns, head, Pattern)
	    ->  send(RS, kind, picture),
		get(Pattern, x, PX),
		get(Pattern, unit, Unit),
		send(RS, unit, Unit),
		compute_picture(Window, PX, MyX, Enlargement, DotSize),
		send(Sharp, value, DotSize),
		send(RS, enlargement, Enlargement),
		send(SH, update_dotruler),
		send(RS, dotsize, DotSize)
	    ;   send(RS, kind, light),
		send(Sharp, displayed, @off),
		send(Ruler, displayed, @off)
	    )
	;   send(RS, kind, dark),
	    send(Sharp, displayed, @off),
	    send(Ruler, displayed, @off)
	).

compute_picture(Window, PX, SX, Enlargement, DotSize) :-
	scene_parms(Window, Lenses, scale(ScaleX, _), _),
	SPX is PX * ScaleX,
	SSX is SX * ScaleX,
	lenses_in_range(Lenses, SPX, SSX, LensesInRange),
	beam_y(beam(SPX, 0.1,  0), LensesInRange, SSX, YC0, _),
	Enlargement is YC0/0.1,
	beam_y(beam(SPX, 0.1,  1), LensesInRange, SSX, YC1, _),
	beam_y(beam(SPX, 0.1, -1), LensesInRange, SSX, YC2, _),
	list_min_max([YC0, YC1, YC2], Min, Max),
	DotSize is (Max - Min)*15.

list_min_max([H|T], Min, Max) :-
	list_min_max(T, H, H, Min, Max).

list_min_max([], Min, Max, Min, Max).
list_min_max([H|T], Min0, Max0, Min, Max) :-
	Min1 is min(H, Min0),
	Max1 is max(H, Max0),
	list_min_max(T, Min1, Max1, Min, Max).

lenses_in_range([], _, _, []).
lenses_in_range([L|T0], XF, XT, [L|T]) :-
	arg(1, L, X),
	X >= XF, X =< XT, !,
	lenses_in_range(T0, XF, XT, T).
lenses_in_range([_|T0], XF, XT, T) :-
	lenses_in_range(T0, XF, XT, T).

beam_y(beam(X, Y, Grads), LensesInRange, XR, YR, Alpha) :-
	Rads is (Grads * pi) / 180,
	beam(beam(X, Y, Rads),
	     LensesInRange, [large_lenses(true)],
	     Beams),			% may be optimised!
	last(beam(XL, YL, Alpha), Beams),
	YR is YL + (XR - XL) * tan(Alpha).

:- pce_end_class.

:- pce_begin_class(eye, optical_instrument, "Eye looking into lenses").

initialise(S) :->
	send(S, send_super, initialise),
	new(EyeImage, image('eye.xpm')),
	get(EyeImage, hot_spot, point(HX, HY)),
	send(S, display, bitmap(EyeImage), point(-HX, -HY)),
	send(S, display, new(centerline)).

:- instrument_state([pos_x]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ pos_x(label(image('xeye.lbl')),
			   type(on_bar))
		   ]).

dragged(S) :->
	send(S?window, update, @off).


event(S, Ev:event) :->
	(   send(S, send_super, event, Ev)
	;   send(@bench_instrument_recogniser, event, Ev)
	).

adjust(S) :->
	send(S, adjust_to_bench).


image(E, EI:eye_image) :<-
	"Fetch of create the related (virtual) image"::
	(   get(E, hypered, image, EI)
	->  true
	;   new(EI, eye_image),
	    new(_, depto_hyper(E, EI, image, eye))
	).


update(E) :->
	"Compute (virtual) image"::
	get(E, device, Window),
	get(E, x, MyX),
	get(Window, graphicals, Graphicals),
	get(E, image, EI),
	(   get(Graphicals, find,
		and(message(@arg1, instance_of, biglamp),
		    @arg1?x < MyX),
		BigLamp),
	    get(BigLamp, switch, @on),
	    scene_parms(Window, _, _, _) % validate the scene
	->  (   get(Graphicals, find_all,
		    and(@arg1?class_name == shield,
			@arg1?x < MyX),
		    Patterns),
		get(Patterns, size, 1),
		get(Patterns, head, Pattern),
		get(Pattern, x, PX),
		catch(compute_image(Window, PX, MyX, IX, Enlargement, DotSize),
		      _,
		      fail)
	    ->  get(EI, member, rotated_shield, RS),
		get(EI, member, sharpness_indicator, Sharp),
		send(RS, kind, picture),
		get(Pattern, unit, Unit),
		send(RS, unit, Unit),
		send(EI, x, IX),
		send(Sharp, value, DotSize),
		send(RS, enlargement, Enlargement),
		send(RS, dotsize, DotSize),
		send(EI, update_dotruler),
		send(Window, display, EI)
	    ;   send(EI, displayed, @off)
	    )
	;   send(EI, displayed, @off)
	).

compute_image(Window, PX, EX, IX, Enlargement, DotSize) :-
	scene_parms(Window, Lenses, scale(ScaleX, _), _),
	SPX is PX * ScaleX,
	SEX is EX * ScaleX,
	lenses_in_range(Lenses, SPX, SEX, LensesInRange),
	H0 = 1,
	beam_y(beam(SPX, H0,  2), LensesInRange, SEX, YE1, A1),
	beam_y(beam(SPX, H0, -2), LensesInRange, SEX, YE2, A2),
	A2 - A1 < 0.0000001,
	SIX is SEX - (YE1 - YE2) / (tan(A1)-tan(A2)),
	SIX > -100,
	SIY is YE1 + (SIX-SEX) * tan(A1),
	IX is round(SIX/ScaleX),
	Enlargement = SIY / H0,
	DotSize = 0.

:- pce_end_class.

:- pce_begin_class(eye_image, shield,
		   "(Virtual) image of the eye").

initialise(SH) :->
	send(SH, send_super, initialise),
	scale(SH, ScaleX, _ScaleY),
	get(SH, member, rotated_shield, RS),
	get(RS, area, area(AX, AY, _AW, AH)),
	new(S, sharpness_indicator),
	get(S, height, Sh),
	D is 0.25/ScaleX,
	SY is AY + AH - Sh - D,
	send(SH, display, S, point(AX+D, SY)),
	get(RS?area, center, point(CX, CY)),
	Diameter is sqrt((CX-AX)**2 + (CY-AY)**2) * 2,
	send(SH, display, new(C, circle(Diameter))),
	send(C, center, point(CX, CY)),
	send(C, fill_pattern, colour(midnight_blue)),
	send(C, hide).

update(_) :->
	true.				% client of the eye

update_dotruler(S) :->
	send(S, send_super, update_dotruler),
	get(S, member, gauge_text, T),
	(   get(S, dotruler, @on),
	    get(S, member, sharpness_indicator, SI),
	    get(SI, displayed, @on)
	->  send(T, displayed, @on)
	;   send(T, displayed, @off)
	).

event(S, Ev:event) :->
	get(Ev?receiver?frame, instrument, I),
	(   I == dotruler
	;   I == tool
	;   I == ruler
	),
	send(S, send_super, event, Ev).

:- pce_end_class.

:- pce_begin_class(sharpness_indicator, device, "Indicate sharpness").

initialise(S) :->
	send(S, send_super, initialise),
	scale(S, ScaleX, ScaleY),
	W is max(5, round(1/ScaleX)),
	H is max(5, round(abs(1/ScaleY))),
	W2 is -(W+1)//2,
	H2 is (H+1)//2,
	H1 is H - 1,
	send(S, display, new(B, box(W,H)), point(W2, 0)),
	send(B, fill_pattern, colour(light_cyan)),
	send(S, display, line(0, 0, 0, H2)),
	send(S, display, new(L1, line(0, H2, 0, H1))),
	send(S, display, new(L2, line(0, H2, 0, H1))),
	send(L1, name, left),
	send(L2, name, right).

value(S, Val:real) :->
	scale(S, ScaleX, _),
	DX is round(Val / ScaleX),
	(   abs(DX) > 10
	->  send(S, displayed, @off)
	;   send(S, displayed, @on),
	    get(S, member, left, L1),
	    get(S, member, right, L2),
	    send(L1, x, -DX),
	    send(L2, x, DX)
	).

:- pce_end_class.


:- pce_begin_class(biglamp, optical_instrument, "Big strong light").

variable(switch, bool := @on,		get, "Switched on or off").

initialise(S) :->
	send(S, send_super, initialise),
	scale(S, ScaleX, ScaleY),
	send(S, display, new(P, path)),
	send_list(P, append,
		  [ point(-1, -100),
		    point(-1, 100),
		    point(-3, 100),
		    point(-15, 20),
		    point(-50, 20),
		    point(-50, -20),
		    point(-15, -20),
		    point(-3, -100)
		  ]),
	send(P, closed, @on),
	send(P, fill_pattern, colour(lime_green)),
	send(S, display, line(-15, 20, -15, -20)),
	send(S, display, line(-7, -35,  -7,  35)),
	send(S, display, line(-18, -7, -45,  -7)),
	send(S, display, line(-18,  7, -45,   7)),
	send(S, display, new(B, box(5, 2*100)), point(0, -100)),
	XFactor is 0.05 / ScaleX,
	YFactor is -0.05 / ScaleY,
	send(S, resize, XFactor, YFactor),
	send(B, pen, 0),
	send(B, fill_pattern, @grey50_image),
	send(B, colour, yellow).

scale_point(scale(ScaleX, ScaleY), point(X,Y), point(SX, SY)) :-
	SX is round(X/ScaleX),
	SY is round(Y/ScaleY).

switch(BL, Val:bool) :->
	"Switch the light-source and update shields"::
	(   get(BL, switch, Val)
	->  true
	;   send(BL, slot, switch, Val),
	    get(BL, window, Window),
	    send(Window?graphicals, for_all,
		 if(message(@arg1, instance_of, shield),
		    message(@arg1, update)))
	).
		    
:- instrument_state([]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L, []).

adjust(L) :->
	send(L, move, point(0,0)),
	send(L, hide).

:- pce_global(@biglamp_recogniser, make_biglamp_recogniser).

make_biglamp_recogniser(G) :-
	new(G, click_gesture(left, '', single,
			     message(@receiver, clicked))),
	send(G, condition,
	     or(@event?window?frame?instrument == delete,
		@event?window?frame?instrument == tool)).

event(S, Ev:event) :->
	(   send(S, send_super, event, Ev)
	;   send(@biglamp_recogniser, event, Ev)
	).

:- pce_end_class.
