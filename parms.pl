/*  $Id: parms.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(optica_parameters, []).
:- use_module(library(pce)).
:- require([ absolute_file_name/3
	   , file_directory_name/2
	   , pce_image_directory/1
	   ]).

:- dynamic
	user:file_search_path/2.
:- multifile
	user:file_search_path/2.

pce_ifhostproperty(prolog(swi),
icon_candidate_directory(swi('optica/icons'))).
icon_candidate_directory(icons).

:- initialization
	icon_candidate_directory(D),
	absolute_file_name(D,
			   [ file_type(directory),
			     access(read),
			     file_errors(fail)
			   ], Dir), !,
	pce_image_directory(Dir),
	file_directory_name(Dir, Parent),
	asserta(user:file_search_path(optica, Parent)).

user:file_search_path(test,       optica(.)).
user:file_search_path(local,	  optica(.)).
