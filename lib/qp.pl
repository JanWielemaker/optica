/*  $Id: qp.pl,v 1.1.1.1 1999/11/17 16:33:38 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(quintus_optica_support,
	  [ msort/2,			% Merge sort
	    atom_char/2,		% ?Atom, ?Char
	    get_time/1			% -Time
	  ]).

:- use_module(library(samsort)).

msort(List, Sorted) :-
	samsort(List, Sorted).

atom_char(Atom, Char) :-
	atom_chars(Atom, [Char]).

foreign(get_time, get_time([-float])).
foreign_file(library(qp), [get_time]).
:- load_foreign_executable(library(qp)).
