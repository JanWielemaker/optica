/*  $Id: parts.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of Optica
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(pce_parts,
	  [ send_parts/2,		% +Spec, +Message
	    send_part/2,		% +Spec, +Message
	    get_part/3,			% +Spec, +Message, -Result
	    find_graphical/2		% +Spec, -Graphical
	  ]).


		 /*******************************
		 *	     SEND-PARTS		*
		 *******************************/

send_parts(Spec, Message) :-
	Message =.. List,
	Goal =.. [send, Gr|List],
	forall(find_graphical(Spec, Gr), Goal).

send_part(Spec, Message) :-
	Message =.. List,
	Goal =.. [send, Gr|List],
	find_graphical(Spec, Gr), !,
	Goal.

get_part(Spec, Message, Result) :-
	Message =.. List0,
	append(List0, [Result], List),
	Goal =.. [get, Gr|List],
	find_graphical(Spec, Gr),
	Goal.

find_graphical(Gr0, Gr) :-
	object(Gr0),
	send(Gr0, instance_of, visual), !,
	Gr = Gr0.
find_graphical(P0/(P1/Name), Gr) :- !,
	find_graphical(P0/P1, Gr0),
	find_graphical(Gr0/Name, Gr).
find_graphical(ParentSpec/Name, Gr) :-
	find_graphical(ParentSpec, Parent),
	send(Parent, has_get_method, member),
	find_sub_graphical(Name, Parent, Gr).

find_sub_graphical(Name, Parent, Gr) :-
	var(Name), !,
	get_chain(Parent, graphicals, Grs),
	member(Gr, Grs),
	get(Gr, name, Name).
find_sub_graphical(class(Class), Parent, Gr) :- !,
	get(Parent?graphicals, find_all,
	    message(@arg1, instance_of, Class),
	    Chain),
	chain_list(Chain, Grs),
	member(Gr, Grs).
find_sub_graphical(Name, Parent, Gr) :-
	atomic(Name), !,
	get(Parent, member, Name, Gr).
find_sub_graphical(List, Parent, Gr) :-
	member(E, List),
	find_sub_graphical(E, Parent, Gr).

