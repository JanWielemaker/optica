/*  $Id: gesture.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(optica_gesture, []).
:- use_module(library(pce)).

:- pce_begin_class(reorder_icon_gesture, gesture,
		   "Restack icons").

resource(button,	button_name,	left).
resource(cursor,	cursor,		sb_h_double_arrow).

initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(G, resource_value, cursor, C),
	send(G, cursor, C).

drag(_, Ev:event) :->
	get(Ev, receiver, Gr),
	get(Gr, device, Dev),
	get(Dev, find, Ev, @arg1?device == Dev, Gr2),
	Gr2 \== Gr,
	get(Ev, x, Dev, X),
	get(Gr2, left_side, LS),
	get(Gr2, right_side, RS),
	(   abs(X-LS) < abs(X-RS)
	->  send(Gr, hide, Gr2)
	;   send(Gr, expose, Gr2)
	).

:- pce_end_class.
