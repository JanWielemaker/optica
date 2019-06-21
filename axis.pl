/*  $Id: axis.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1994 University of Amsterdam. All rights reserved.
*/

:- module(plot_axis, []).
:- use_module(library(pce)).
:- require([ ceiling/2
	   , forall/2
	   , round/2
	   ]).

:- pce_begin_class(plot_axis(type, low, high), line, "Coordinate system axis").

resource(tag_font, font, normal, "Font for values").

:- pce_group(attributes).
variable(origin,	point,		get,  "Location of the origin").
variable(low,		'int|real',	get,  "Low end of the range").
variable(high,		'int|real',	get,  "High end of the range").
variable(step,		'int|real',	get,  "Indication steps").
variable(small_step,	'int|real*',	get,  "Unnumbered indication steps").
variable(length,	int,		get,  "Total length").
variable(type,		{x,y},		get,  "Horizontal/vertical").
variable(format,	[name],		get,  "Value format specification").
variable(label,		graphical*,	get,  "Label along the axis").
:- pce_group(internal).
variable(support,	chain,		none, "Supporting graphicals").


:- pce_group(@default).

initialise(A, 
	   Type:'type={x,y}',
	   Low:'low=int|real', High:'high=int|real', Step:'step=int|real',
	   Lenght:'length=int',
	   O:'origin=[point]') :->
	"Create from low, high, step, length and type"::
	send(A, send_super, initialise),

	send(A, slot, origin,  new(P, point)),
	(   O \== @default
	->  send(P, copy, O)
	;   true
	),
	send(A, slot, low,     Low),
	send(A, slot, high,    High),
	send(A, slot, length,  Lenght),
	send(A, slot, step,    Step),
	send(A, slot, type,    Type),
	send(A, slot, support, new(chain)),
	send(A, slot, format,  @default),
	send(A, request_compute).


unlink(A) :->
	"Delete all <-support objects"::
	get(A, slot, support, Support),
	send(Support, for_all, message(@arg1, free)),
	send(A, send_super, unlink).


device(A, Dev:device*) :->
	"Trap device changes"::
	send(A, send_super, device, Dev),
	get(A, slot, support, Support),
	send(Support, for_all, message(@arg1, device, Dev)),
	(   get(A, label, Label),
	    Label \== @nil
	->  send(Label, device, Dev)
	;   true
	).


		 /*******************************
		 *	  USER COMPUTATION      *
		 *******************************/

:- pce_group(compute).

location(A, Val:'int|real', Loc:int) :<-
	"Location for value"::
	loc(A, Val, Loc).

value_from_coordinate(A, Loc:int, Val:'int|real') :<-
	"Translate location into value"::
	loc(A, Val, Loc).
       

		 /*******************************
		 *	    SLOT CHANGES        *
		 *******************************/

:- pce_group(update).

changed(A) :->
	"A has changed: force update"::
	send(A, request_compute).

:- pce_group(@default).

origin(A, P:point) :->
	send(A?origin, copy, P),
	send(A, changed).


label(A, L:graphical*) :->
	send(A, slot, label, L),
	send(A, changed).


low(A, L:'int|real') :->
	send(A, slot, low, L),
	send(A, changed).


high(A, L:'int|real') :->
	send(A, slot, high, L),
	send(A, changed).


step(A, L:'int|real') :->
	send(A, slot, step, L),
	send(A, changed).


small_step(A, L:'int|real') :->
	send(A, slot, small_step, L),
	send(A, changed).


length(A, Length:int) :->
	send(A, slot, length, Length),
	send(A, changed).


type(A, T:{x,y}) :->
	send(A, slot, type, T),
	send(A, changed).


format(A, Fmt:[name]) :->
	send(A, slot, format, Fmt),
	send(A, changed).


geometry(A, X:[int], Y:[int], W:[int], H:[int]) :->
	"Trap geometry changes"::
	(   get(A, request_compute, computing)
	->  send(A, send_super, geometry, X, Y, W, H)
	;   (   get(A, type, x)
	    ->  send(A, send_super, geometry, X, Y, W, @default),
		send(A, length, A?width)
	    ;   send(A, send_super, geometry, X, Y, @default, H),
		send(A, length, -A?height)
	    )
	).


		 /*******************************
		 *	    COMPUTING		*
		 *******************************/

loc(A, V, X) :-
	get(A, origin, O),
	get(A, type, T),
	get(O, T, Origin),
	get(A, low, Low),
	get(A, high, High),
	get(A, length, Length),
	(   T == x
	->  (   nonvar(V)
	    ->  X is round(Origin + ((V-Low) * Length) / (High - Low))
	    ;	V is Low + (X-Origin) * (High-Low)/Length 
	    )
	;   (	nonvar(V)
	    ->	X is round(Origin - ((V-Low) * Length) / (High - Low))
	    ;	V is Low + (Origin-X) * (High-Low)/Length % not tested
	    )
	).


tick(Low, High, Step, Tick) :-
	TheLow is Low - Step / 10000,
	TheHigh is High + Step / 10000,	% avoid floating point rounding
	L0 is ceil(TheLow/Step) * Step,
	tick_(L0, TheHigh, Step, Tick).

tick_(L, _, _, L).
tick_(L, H, S, V) :-
	L1 is L + S,
	L1 =< H,
	tick_(L1, H, S, V).


format(A, Fmt:[char_array]) :<-
	"Compute format to use"::
	(   get(A, slot, format, SlotValue),
	    SlotValue \== @default
	->  Fmt = SlotValue
	;   get(A, step, Step),
	    integer(Step), !,
	    Fmt = '%d'
	;   get(A, step, Step),
	    new(S, string('%f', Step)),
	    new(Re, regex('\\..*[^0]')),
	    send(Re, search, S),
	    get(Re, register_end, End),
	    get(Re, register_start, Start),
	    send(Re, done),
	    AfterDot is End - Start - 1,	% 1 for the dot
	    new(Fmt, string('%%.%df', AfterDot))
	).


compute_small_steps(A) :->
	get(A, small_step, SmallStep),
	(   SmallStep \== @nil
	->  
	get(A, low, Low),
	    get(A, high, High),
	    get(A, step, Step),
	    get(A, device, Dev),
	    get(A, origin, point(OX, OY)),
	    get(A, slot, support, Support),
	    (   get(A, type, x)
	    ->  forall(tick(Low, High, SmallStep, TV),
		       (   A is TV / Step, integer(A)
		       ->  true
		       ;   loc(A, TV, TX),
			   send(Dev, display, new(L, line(TX, OY, TX, OY+3))),
			   send(Support, append, L)
		       ))
	    ;   forall(tick(Low, High, SmallStep, TV),
		       (   A is TV / Step, integer(A)
		       ->  true
		       ;   loc(A, TV, TY),
			   send(Dev, display, new(L, line(OX-3, TY, OX, TY))),
			   send(Support, append, L)
		       ))
	    )
	;   true
	).

place_label(_, @nil, _, _, _) :- !.
place_label(Dev, Label, Dir, X, Y) :-
	get(Label, size, size(W, H)),
	(   Dir == x
	->  send(Label, do_set, X-W, Y-H-3)
	;   send(Label, do_set, X+3, Y)
	),
	send(Dev, display, Label).


compute(A) :->
	send(A, slot, request_compute, computing),
	get(A, low, Low),
	get(A, high, High),
	get(A, step, Step),
	get(A, format, Fmt),
	get(A, origin, point(OX, OY)),
	get(A, slot, support, Support),
	get(A, resource_value, tag_font, Font),
	get(A, label, Label),
	send(Support, for_all, message(@arg1, free)),
	send(Support, clear),

	loc(A, Low, Start),
	loc(A, High, End),
	get(A, device, Dev),
	(   get(A, type, x)
	->  send(A, points, Start, OY, End, OY),
	    place_label(Dev, Label, x, End, OY),
	    forall(tick(Low, High, Step, TV),
		   (   loc(A, TV, TX),
		       send(Dev, display,
			    new(L, line(TX, OY, TX, OY+5))),
		       send(Dev, display,
			    new(T, text(string(Fmt, TV), font := Font)),
			    point(TX-3, OY+5)),
		       send(Support, append, L),
		       send(Support, append, T)
		   ))
	;   send(A, points, OX, Start, OX, End),
	    place_label(Dev, Label, y, OX, End),
	    forall(tick(Low, High, Step, TV),
		   (   loc(A, TV, TY),
		       send(Dev, display,
			    new(L, line(OX-5, TY, OX, TY))),
		       new(T, text(string(Fmt, TV), font := Font)),
		       get(T, width, TW),
		       get(T, height, TH),
		       send(T, set, OX-5-TW, TY-TH+3),
		       send(Dev, display, T),
		       send(Support, append, L),
		       send(Support, append, T)
		   ))
	),
	send(A, compute_small_steps),
	(   send(Dev, has_send_method, modified_plot_axis)
	->  send(Dev, modified_plot_axis, A)
	;   true
	),
	send(A, send_super, compute).

:- pce_end_class.
