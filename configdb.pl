/*  $Id: configdb.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(config_db,
	  [ add_config/1,		% +Term
	    del_config/1,		% +Term (pattern)
	    save_config/1,		% +File
	    load_config/1,		% +File
	    config/1,			% -Term
	    check_config/0,
	    instrument_config/2,	% +Name, ?Term
	    experiments/1,		% -Experiments (Names)

	    set_fact/1,			% +Term
	    fact/1			% ?Term
	  ]).
:- use_module(library(pce)).
:- use_module(pretty_print).
:- use_module(util).
:- use_module(language).
:- require([ ignore/1
	   , member/2
	   , memberchk/2
	   , msort/2
	   ]).

:- dynamic
	config/1,
	fact/1.

set_fact(Term) :-
	functor(Term, Name, Arity),
	functor(Pattern, Name, Arity),
	retractall(fact(Pattern)),
	asserta(fact(Term)).

add_config(Term) :-
	asserta(config(Term)).

del_config(Pattern) :-
	retractall(config(Pattern)).

save_config(File) :-
	ignore(send(file(File), backup)),
	open(File, write, Fd),
	get(@pce?date, value, Date),
	format(Fd, '/*  Saved optica configurations~n', []),
	format(Fd, '    Saved at ~w~n', [Date]),
	format(Fd, '*/~n~n', []),
	save_config_terms(Fd),
	close(Fd).

save_config_terms(Fd) :-
	findall(Term, config(Term), Terms0),
	msort(Terms0, Terms),
	member(Term, Terms),
	\+ Term = config_file(_),
	pretty_print(Fd, Term),
	nl(Fd),
	fail.
save_config_terms(_).

load_config(File) :-
	with_long_atoms(with_strings(do_load_config(File))).
do_load_config(File) :-
	open(File, read, Fd),
	retractall(config(_)),
	do_read(Fd, Term),
	load_config(Term, Fd),
	close(Fd),
	time_file(File, Time),
	add_config(config_file(File)),
	add_config(config_file_time_stamp(Time)),
	(   config(language(Lan))
	->  set_language(Lan)
	;   true
	).


load_config(end_of_file, _) :- !.
load_config(Term, Fd) :-
	assert(config(Term)),		% keep the order
	do_read(Fd, Term2),
	load_config(Term2, Fd).

do_read(Fd, Term) :-
	catch(read_term(Fd, Term, [singletons(L),module(pce)]), Error, true),
	(   nonvar(Error)
	->  message_to_string(Error, Msg)
	;   L \== []
	->  maplist(varname, L, Names),
	    concat_atom(Names, ', ', Msg0),
	    sformat(Msg, 'The following words should be quoted: ~w', [Msg0])
	;   true
	),
	(   nonvar(Msg)
	->  source_location(File, Line),
	    send(@display, inform,
		 string('Syntax error in config file\n%s:%s\n\n%s',
			File, Line, Msg)),
	    fail
	;   !
	).
do_read(Fd, Term) :-
	do_read(Fd, Term).

varname(Name=_, Name).

check_config :-
	config(config_file(File)),
	config(config_file_time_stamp(Time0)),
	time_file(File, TimeNow), !,
	(   TimeNow > Time0
	->  message(config_file_changed, Title),
	    new(D, dialog(Title)),
	    send(D, append,
		 button(reload, message(D, return, reload))),
	    send(D, append,
		 button(no_reload, message(D, return, no))),
	    get(D, confirm_centered, RVal),
	    send(D, destroy),
	    (	RVal == reload
	    ->	load_config(File)
	    ;	retractall(config(config_file_time_stamp(_))),
		add_config(config_file_time_stamp(TimeNow))
	    )
	;   true
	).
check_config.


		 /*******************************
		 *        ACCESS UTILITY	*
		 *******************************/

instrument_config(Instrument, Term) :-
	config(instrument(Instrument, Options, _)),
	member(Term, Options).

experiments(Names) :-
	findall(I-Name, current_experiment(Name, I), Pairs),
	keysort(Pairs, Sorted),
	unkey(Sorted, Names).

unkey([], []).
unkey([_-X|TK], [X|T]) :-
	unkey(TK, T).

current_experiment(Name, Index) :-
	config(experiment(Name, Options)),
	memberchk(index(Index), Options).
