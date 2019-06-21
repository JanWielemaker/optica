/*  $Id: plotter.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1994 University of Amsterdam. All rights reserved.
*/

:- module(plotter, []).
:- use_module(axis, []).
:- use_module(library(pce)).
:- require([ default/3
	   ]).

:- pce_begin_class(plotter, device, "A plot").

initialise(P) :->
	send(P, send_super, initialise).

axis(P, Axe:plot_axis) :->
	"Associate an axis with the plotter"::
	get(Axe, type, Type),
	(   get(P, member, Type, Old)
	->  free(Old)
	;   true
	),
	send(P, display, Axe),
	send(Axe, name, Type).

x_axis(P, Axe:plot_axis) :<-
	"Find the X-axis"::
	get(P, member, x, Axe).

y_axis(P, Axe:plot_axis) :<-
	"Find the Y-axis"::
	get(P, member, y, Axe).

translate(P, X:'int|real', Y:'int|real', Point) :<-
	"Translate a coordinate"::
	get(P, member, x, XAxe),
	get(P, member, y, YAxe),
	get(XAxe, location, X, PX),
	get(YAxe, location, Y, PY),
	new(Point, point(PX, PY)).

translate_plot_point(P, PP:plot_point, Pt:point) :<-
	"Translate plot-point to physical point"::
	get(PP, x, X),
	get(PP, y, Y),
	get(P, translate, X, Y, Pt).

graph(P, Gr:plot_graph) :->
	"Display a graph on the plotter"::
	send(P, display, Gr).

clear(P) :->
	"Remove all graphs"::
	send(P?graphicals, for_all,
	     if(message(@arg1, instance_of, plot_graph),
		message(@arg1, free))).

modified_plot_axis(P, _A:plot_axis) :->
	"Trap changed axis parameters"::
	send(P?graphicals, for_all,
	     if(message(@arg1, instance_of, plot_graph),
		message(@arg1, request_compute))).

:- pce_end_class.

		 /*******************************
		 *	    PLOT-POINT		*
		 *******************************/

:- pce_begin_class(plot_point(x, y), object, "Plotter point").

variable(x,	'int|real',	both,	"X-value").
variable(y,	'int|real',	both,	"Y-value").

initialise(P, X:'x=int|real', Y:'y=int|real') :->
	"Create from X and Y"::
	send(P, send_super, initialise),
	send(P, x, X),
	send(P, y, Y).

:- pce_end_class.

		 /*******************************
		 *	    PLOT-GRAPH		*
		 *******************************/

:- pce_begin_class(plot_graph, path, "A graph for the plotter").

variable(values,	chain,	get,	"Chain with X-Y pairs").

initialise(PG,
	   Kind:'type=[{poly,smooth,points_only}]',
	   Mark:'mark=[image]*') :->
	"Create from visualisation and mark"::
	default(Kind, poly, K),
	default(Mark, @nil, M),
	send(PG, send_super, initialise),
	send(PG, slot, values, new(chain)),
	send(PG, kind, K),
	send(PG, mark, M).


kind(PG, T:{poly,smooth,points_only}) :->
	(   T == points_only
	->  send(PG, pen, 0)
	;   send(PG, pen, 1),
	    send(PG, send_super, kind, T)
	).


append(PG, X:'x=int|real', Y:'y=int|real') :->
	"Append a plot_point to <-values"::
	send(PG?values, append, plot_point(X, Y)),
	send(PG, request_compute).

super_append(PG, P:point) :->
	send_super(PG, append, P).

compute(PG) :->
	"Update points"::
	send(PG, clear),
	get(PG, device, Dev),
	(   get(PG?values, size, Size),
	    Size > 100
	->  send(PG, report, progress, 'Translating %d points ...'),
	    Report = true
	;   Report = fail
	),
	send(PG?values, for_all,
	     message(PG, super_append,
		     ?(Dev, translate_plot_point, @arg1))),
	(   Report
	->  send(PG, report, done)
	;   true
	),
	send(PG, send_super, compute).

:- pce_end_class.
