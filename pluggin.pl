/*  $Id: pluggin.pl,v 1.2 2002/01/22 20:11:50 jan Exp $

    Part of OPTICA
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 2000 University of Amsterdam. All rights reserved.
*/

:- module(optica_pluggins,
	  [
	  ]).

:- print_message(informational, format('    Loading pluggins ...', [])).

		 /*******************************
		 *	     STRESS		*
		 *******************************/

:- multifile
	user:file_search_path/2.

user:file_search_path(stress, optica(stress)).

:- [ %user:stress(stress)		% load pluggins
   ].

:- print_message(informational, format('    Pluggins loaded', [])).
