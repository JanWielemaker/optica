/*  $Id: pretty_print.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1994 University of Amsterdam. All rights reserved.
*/

:- module(pretty_print,
	  [ pretty_print/1,
	    pretty_print/2
	  ]).
:- use_module(library(pce)).
:- require([ atom_length/2
	   , between/3
	   , forall/2
	   , is_list/1
	   , member/2
	   , memberchk/2
	   , sformat/3
	   ]).

:- require([ atom_length/2
	   , between/3
	   , forall/2
	   , is_list/1
	   , member/2
	   , memberchk/2
	   ]).


pretty_print(Stream, Term) :-
	current_output(Old),
	set_output(Stream),
	pretty_print(Term),
	set_output(Old).

pretty_print(Term) :-
	numbervars(Term, 0, _),
	pp(Term, 0),
	write('.'), nl, fail.
pretty_print(_).


current_line_position(Pos) :-
	current_output(Stream),
	line_position(Stream, Pos).

pp(Term) :-
	current_line_position(Indent),
	pp(Term, Indent).

pp(Term, _Indent) :-
	atomic(Term), !,
	writeq(Term).
pp(Var, _Indent) :-
	var(Var), !,
	write(Var).
pp(Var, _Indent) :-
	Var = '$VAR'(_), !,
	print(Var).
pp(time(T), _Indent) :- !,
	format('~1f', T).
pp(@Ref, _Indent) :- !,
	write(@), writeq(Ref).
pp(Module:Term, Indent) :-
	atomic(Module), !,
	writeq(Module), write(:),
	pp(Term, Indent).
pp(A?B, Indent) :- !,
	pp(A, Indent), write(?), pp(B, Indent).
pp([A1 = V1|ArgList], Indent) :-	% [] is done by `atomic'!
	is_list(ArgList),
	forall(member(A, ArgList), A = (_ = _)), !,
	longest_attribute([A1 = V1|ArgList], 0, L),
	NewIndent is Indent + 2,
	(   L > 9, Indent < 25, length(ArgList, Args), Args > 1
	->  ArgIndent is Indent + 3,
	    ValGoal = (nl, indent(ArgIndent))
	;   ArgIndent is Indent + 5 + L,
	    ValGoal = write(' ')
	),
	write('[ '),
	pp(A1, Indent), term_length(A1, L1),
	tab(L-L1), write(' ='), ValGoal,
	pp(V1, ArgIndent),
	forall(member(A = V, ArgList),
	       (write(','), nl,
		indent(NewIndent),
		pp(A, Indent), term_length(A, LA), tab(L-LA),
		write(' ='), ValGoal, pp(V, ArgIndent))),
	nl,
	indent(Indent),
	write(']').
pp([H|T], Indent) :-
	is_list(T), !,
	write('[ '),
	NewIndent is Indent + 2,
	pp(H, NewIndent),
	forall(member(E, T),
	       (write(','), nl,
		indent(NewIndent),
		pp(E, NewIndent))),
	nl,
	indent(Indent),
	write(']').
pp(A?B, Indent) :- !,
	pp(A, Indent), write('?'), pp(B, Indent).
pp(Term, Indent) :-
	functor(Term, Name, 2),
	current_op(_, Type, Name),
	memberchk(Type, [xfx, yfx]), !,
	arg(1, Term, A1),
	arg(2, Term, A2),
	pp(A1, Indent), format(' ~q ', [Name]), pp(A2).
pp(Term, Indent) :-
	functor(Term, Name, _Arity),
	atom_length(Name, L),
	NewIndent is Indent + L + 1,
	format('~q(', Name),
	(   Limit is 72 - NewIndent,
	    term_length_in_limit(Term, Limit, _)
	->  forall(generate_arg(I, Term, Arg),
		   (   I == 1
		   ->  pp(Arg, NewIndent)
		   ;   write(', '),
		       pp(Arg, NewIndent)
		   ))
	;   forall(generate_arg(I, Term, Arg),
		   (   I == 1
		   ->  pp(Arg, NewIndent)
		   ;   write(','),
		       pp_arg(Arg, NewIndent)
		   ))
	),
	write(')').

pp_arg(Arg, _) :-
	term_length(Arg, L),
	current_line_position(P),
	P + L + 1 < 72, !,
	write(' '),
	NP is P + 1,
	pp(Arg, NP).
pp_arg(Arg, Indent) :-
	nl, indent(Indent),
	pp(Arg, Indent).


generate_arg(ArgN, Term, Arg) :-
	functor(Term, _, Arity),
	between(1, Arity, ArgN),
	arg(ArgN, Term, Arg).

longest_attribute([], L, L).
longest_attribute([A = _|T], L0, L) :-
	term_length(A, AL),
	L1 is max(L0, AL),
	longest_attribute(T, L1, L).

term_length(A, AL) :-
	atomic(A), !,
	atom_length(A, AL).
term_length(Var, AL) :-
	var(Var), !,
	AL = 1.
term_length('$VAR'(N), AL) :-
	varname(N, L),
	length(L, AL).
term_length(@Ref, L) :-
	term_length(Ref, L0),
	L is L0 + 1.
term_length(A?B, L) :-
	term_length(A, L0),
	term_length(B, L1),
	L is L0 + L1+ 1.
term_length(time(T), L) :-
	sformat(S, '~1f', T),
	atom_length(S, L).

term_length_in_limit(T, Limit, Len) :-
	term_length(T, Len), !,
	Len < Limit.
term_length_in_limit([_|_], _, _) :- !,
	fail.
term_length_in_limit(T, Limit, Len) :-
	functor(T, Name, Arity),
	atom_length(Name, NameLen),
	term_length_in_limit(1, Arity, T, Limit, Len0),
	Len is Len0 + NameLen + 3,
	Len < Limit.


term_length_in_limit(N, N, Term, Limit, Len) :- !,
	arg(N, Term, Arg),
	term_length_in_limit(Arg, Limit, Len).
term_length_in_limit(N, A, Term, Limit, Len) :-
	arg(N, Term, Arg),
	term_length_in_limit(Arg, Limit, ALen),
	RLimit is Limit - ALen - 2,
	NN is N + 1,
	term_length_in_limit(NN, A, Term, RLimit, RLen),
	Len is ALen + RLen.
	

varname(N, [C]) :-
	N < 26, !, 
	C is N + 0'A.
varname(N, [C1, C2]) :-
	C1 is N // 26 + 0'A, 
	C2 is N mod 26 + 0'A.

indent(I) :-
	Tabs is I // 8,
	forall(between(1, Tabs, _), put(9)),
	Spaces is I mod 8,
	tab(Spaces).
