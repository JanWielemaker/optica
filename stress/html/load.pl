/*  $Id: load.pl,v 1.1 2000/03/03 13:54:17 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 2000 University of Amsterdam. All rights reserved.
*/

:- module(doc_load, []).
:- use_module(library(pce)).

		 /*******************************
		 *	       PATHS		*
		 *******************************/

:- multifile
	user:file_search_path/2.

user:file_search_path(doc, stress(html)).


		 /*******************************
		 *	OBLIGATORY PARTS	*
		 *******************************/

:- use_module(doc(util)).		% generic stuff
:- use_module(doc(objects)).		% global reusable objects
:- use_module(doc(emit)).		% basic conversion library


		 /*******************************
		 *	     CLASSES		*
		 *******************************/

:- pce_autoload(doc_table,	 doc(table)).

:- pce_autoload(doc_mode,	 doc(layout)).
:- pce_autoload(pbox,		 doc(layout)).
:- pce_autoload(bullet_list,	 doc(layout)).
:- pce_autoload(enum_list,	 doc(layout)).
:- pce_autoload(definition_list, doc(layout)).
:- pce_autoload(button_box,	 doc(layout)).
:- pce_autoload(anchor_box,	 doc(layout)).

:- pce_autoload(doc_window,	 doc(window)).
:- pce_autoload(doc_browser,	 doc(browser)).
