/*  $Id: snap.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(snapper, []).
:- use_module(library(pce)).
:- use_module(hyper).

:- pce_begin_class(snapper, bitmap).

variable(timer,		timer, get, "Timer for shifting target").

initialise(S) :->
	send(S, send_super, initialise, 'snap.xpm'),
	send(S, slot, timer, timer(0.02, message(S, step_out))).

unlink(S) :->
	get(S, timer, T),
	free(T),
	send(S, send_super, unlink).

delete(S, Gr:graphical) :->
	"Delete the given graphical"::
	(   get(Gr, hypered, snap, _Old)
	->  /*format(user_error, 'Attempt to snap twice: ~p~n', [Gr]),*/
	    free(S)
	;   get(S, hot_spot, point(HX, _)),
	    get(Gr, window, W),
	    get(W, visible, area(_, AY, _, AH)),
	    (   send(Gr, instance_of, device)
	    ->  get(Gr, x, X0),
		get(Gr?area, x, X1),
		get(Gr, absolute_x, AX),
		X is AX + X0 - X1
	    ;   get(Gr, absolute_x, AX),
		get(Gr, width, GrW),
		X is AX + GrW//2
	    ),
	    send(W, display, S, point(X-HX, AY+AH-S?height)),
	    new(_, depto_hyper(Gr, S, snap, client)),
	    send(S?timer, start)
	).

step_out(S) :->
	get(S, hypered, client, OI),
	send(OI, relative_move, point(0, 10)),
	get(OI, absolute_y, OY),
	get(S, y, SY),
	(   OY > SY
	->  get(OI, window, Window),
	    autoswitch_on_delete(OI, AutoSwitch),
	    send(OI, destroy),
	    send(Window, update, @on, AutoSwitch)
	;   true
	).

autoswitch_on_delete(OI, @off) :-
	send(OI, instance_of, construction_line), !.
autoswitch_on_delete(OI, @off) :-
	send(OI, instance_of, beam_extender), !.
autoswitch_on_delete(_, @on). 


:- pce_end_class.
