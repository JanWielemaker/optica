/*  $Id: hyper.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(hypers, []).
:- use_module(library(pce)).

:- pce_begin_class(depto_hyper, hyper, "Hyper where to depends on from").

unlink_from(H) :->
	get(H, to, To),
	free(To),
	free(H).

:- pce_end_class.
