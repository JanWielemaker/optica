/*  $Id: hourglass.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1998 University of Amsterdam. All rights reserved.
*/

:- module(hourglass, []).
:- use_module(library(pce)).
:- require([ concat_atom/2
	   , default/3
	   ]).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Class hourglass

	Defines a subclass of class bitmap (and therefore a graphical)
	for animating an hourglass.  The principal methods are:

	->wait: Time:real, Filled:[0..9]
		Wait for the indicated time.  Filled is the initial
		status (default 9).  Events are normally processed
		while the hourglass is waiting.

	->abort:
		Abort as quickly as possible.	Currently at the next
	        time the timer fires.

See test/0 at the end of this file for an example, including abort.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */


:- pce_begin_class(hourglass, bitmap,
		   "Animated hourglass").

variable(timer,		timer,	get, "Timer for count-down").
variable(filled,	'0..9',	get, "Current level").

initialise(HG, Filled:'[0..9]') :->
	default(Filled, 9, N),
	send(HG, slot, timer, timer(0, message(HG, step))),
	send(HG, slot, filled, N),
	image(N, Image),
	send(HG, send_super, initialise, Image).

unlink(HG) :->
	"Make sure to kill the timer"::
	(   get(HG, timer, Timer),
	    Timer \== @nil
	->  send(Timer, stop)
	;   true
	),
	send(HG, send_super, unlink).
	
filled(HG, N:'0..9') :->
	"Fill to the indicated level"::
	send(HG, slot, filled, N),
	image(N, Image),
	send(HG, image, Image).

abort(HG) :->
	"Make it return as quickly as possible"::
	send(HG, filled, 0).

wait(HG, Time:real, Filled0:'[1..9]') :->
	"Wait the indicated time, starting at the given level"::
	default(Filled0, 9, Filled),
	send(HG, filled, Filled),
	Step is Time/Filled,
	get(HG, timer, T),
	send(T, interval, Step),
	send(T, start),
	repeat,
	    (   get(HG, filled, 0)
	    ->  !
	    ;   send(@display, dispatch),
		fail
	    ).

step(HG) :->
	"Step one down (fails if empty"::
	get(HG, filled, Filled),
	(   Filled > 0
	->  NewFilled is Filled - 1,
	    send(HG, filled, NewFilled)
	).

image(N, Img) :-
	N1 is 10 - N,
	concat_atom([hourgl, N1, '.bm'], File),
	new(Img, image(File)).

:- pce_end_class.

/*

test :-
	new(D, dialog('HourGlass Text')),
	send(D, append, new(HG, hourglass)),
	send(D, append, new(IV, slider(initial_value, 0, 9, 9, @nil))),
	send(D, append, new(TV, slider(time, 0, 100, 10, @nil))),
	send(D, append, button(go,
			       and(message(D?frame, busy_cursor, @nil),
				   message(D, focus, @nil),
				   message(HG, wait,
					   TV?selection, IV?selection)))),
	send(D, append, button(abort,
			       message(HG, abort))),
	send(D, append, button(quit,
			       message(D, destroy))),
	send(D, open).

*/
