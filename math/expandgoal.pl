/*  $Id: expandgoal.pl,v 1.1.1.1 1999/11/17 16:33:38 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(goal_expansion,
	  [ expand_goals/2		% +BodyIn, -ExpandedBody
	  ]).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
This module installs a user:term_expansion/2 hook   into the system that
breaks the body of clauses into `goals' and then calls the new hook

	goal_expansion(+GoalIn, -GoalOut)

which serves a similar goal as   term_expansion/2,  but for goals rather
then for complete  clauses.  It  is   designed  to  cooperate  with XPCE
(ProWindows-3) as well as plain Prolog. It has been developed to support
the expandmath library for rewriting math calls.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- multifile
	user:term_expansion/2,
	user:pce_pre_expansion_hook/2.
:- dynamic
	user:term_expansion/2,
	user:pce_pre_expansion_hook/2.

expand_goals(A, B) :-
	do_expand_goals(A, B0),
	tidy(B0, B),
	\+ A = B.
%	portray_clause((expanding :- A)),
%	portray_clause((expanded :- B)).

do_expand_goals(G, G) :-
	var(G), !.
do_expand_goals((A,B), (EA,EB)) :- !,
	do_expand_goals(A, EA),
	do_expand_goals(B, EB).
do_expand_goals((A;B), (EA;EB)) :- !,
	do_expand_goals(A, EA),
	do_expand_goals(B, EB).
do_expand_goals((A->B), (EA->EB)) :- !,
	do_expand_goals(A, EA),
	do_expand_goals(B, EB).
do_expand_goals((\+A), (\+EA)) :- !,
	do_expand_goals(A, EA).
do_expand_goals(A, B) :-
	expansion_module(M),
	current_predicate(_, M:goal_expansion(_,_)),
	M:goal_expansion(A, B), !.
do_expand_goals(A, A).

expansion_module(M) :-
	prolog_load_context(module, M),
	M \== user.
expansion_module(user).

tidy(A, A) :-
	var(A), !.
tidy((A,B), (A, TB)) :-
	var(A), !,
	tidy(B, TB).
tidy((A,B), (TA, B)) :-
	var(B), !,
	tidy(A, TA).
tidy(((A,B),C), R) :- !,
     tidy((A,B,C), R).
tidy((true,A), R) :- !,
	tidy(A, R).
tidy((A,true), R) :- !,
	tidy(A, R).
tidy((A,B), (TA, TB)) :- !,
	tidy(A, TA),
	tidy(B, TB).
tidy((A;B), (TA; TB)) :- !,
	tidy(A, TA),
	tidy(B, TB).
tidy((A->B), (TA->TB)) :- !,
	tidy(A, TA),
	tidy(B, TB).
tidy(A, A).

user:term_expansion((Head :- Body), (Head :- ExpandedBody)) :-
	goal_expansion:expand_goals(Body, ExpandedBody).


		 /*******************************
		 *	 XPCE RELATED HOOKS	*
		 *******************************/

pce_expand_body(::(Doc, Body0), ::(Doc, Body)) :- !,
	expand_goals(Body0, Body).
pce_expand_body(Body0, Body) :-
	expand_goals(Body0, Body).

user:pce_pre_expansion_hook(:->(Head, Body0), :->(Head, Body)) :-
	goal_expansion:pce_expand_body(Body0, Body).
user:pce_pre_expansion_hook(:<-(Head, Body0), :<-(Head, Body)) :-
	goal_expansion:pce_expand_body(Body0, Body).
