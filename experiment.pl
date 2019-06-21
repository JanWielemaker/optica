/*  $Id: experiment.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(experiment, []).
:- use_module(library(pce)).
:- use_module(configdb).
:- use_module(language).
:- use_module(save).
:- use_module(util).
:- use_module(log).
:- use_module(test).
:- require([ chain_list/2
	   , get_chain/3
	   , memberchk/2
	   ]).

:- pce_begin_class(experiment, object, "Holder of an experiment").

variable(name,		name,		get,  "Name (Id) of the experiment").
variable(state,		scene_state*,	both, "State (when not active)").
variable(time,		int := 0,	both, "Used time (seconds)").
variable(open_time,	date*,		get,  "Time it was opened").
variable(manager,	experiments,	both, "Manager of the experiments").

initialise(E, Name:name) :->
	send(E, send_super, initialise),
	send(E, slot, name, Name).


open(E, Optica:optica, State:state=[scene_state]*) :->
	"(Re) open the experiment (with state)"::
	get(E, name, Name),
	(   State == @default
	->  (   get(E, state, SavedState), SavedState \== @nil
	    ->  send(Optica, state, SavedState),
		state_to_term(SavedState, StateTerm)
	    ;   config(experiment(Name, Options)),
		memberchk(initial_state(StateTerm), Options)
	    ->  state_to_term(InitialState, StateTerm),
		send(Optica, state, InitialState)
	    ;   send(Optica, state, @nil),
		StateTerm = []
	    )
	;   send(Optica, state, State),
	    state_to_term(State, StateTerm)
	),
	send(E, slot, open_time, new(date)),
	log(experiment(open(Name, StateTerm))).

show_open_texts(E, Optica:optica) :->
	"Show the obligatory introduction text"::
	(   get(E, time, 0)
	->  get(E, name, Name),
	    show_open_text(Optica, theory, Name),
	    show_open_text(Optica, assignment, Name),
	    show_open_text(Optica, help, Name)
	;   true
	).

show_open_text(Optica, Type, Id) :-
	config(text(Type, Id, _, Options)),
	memberchk(show_at_open(true), Options), !,
	send(Optica, text_viewer, Type, @on).
show_open_text(_, _, _).


previous(E, Prev:experiment) :<-
	"Fetch the experiment before me"::
	get(E, manager, Exps),
	get(Exps, attribute_names, Names),
	get(Names, index, E?name, Index),
	PrevIndex is Index - 1,
	PrevIndex >= 1,
	get(Names, nth1, PrevIndex, PrevName),
	get(Exps, value, PrevName, Prev).
	

test_experiment_before(E) :->
	"Test previous experiment if this one is opened for the first time"::
	(   config(test_moment(experiment)),
	    get(E, time, 0),
	    get(E, previous, Prev)
	->  send(Prev, run_post_tests)
	;   true
	).


close(E, Tool:frame) :->
	"Terminate a state"::
	get(Tool, state, State),
	send(E, slot, state, State),
	get(E, slot, open_time, Open),
	get(new(date), difference, Open, second, Spent),
	get(E, time, Time0),
	Time1 is Time0 + Spent,
	send(E, slot, time, Time1),
	send(E, slot, open_time, @nil),
	get(E, name, Name),
	state_to_term(State, StateTerm),
	log(experiment(close(Name, Spent, Time1, StateTerm))).

time_used(E, Used:int) :<-
	get(E, time, Time0),
	(   get(E, open_time, OT), OT \== @nil
	->  get(new(date), difference, OT, second, Spent),
	    Used is Time0 + Spent
	;   Used is Time0
	).

satisfied(E, Warn:[bool]) :->
	"Test of sufficiently done"::
	get(E, name, Name),
	get(E, time_used, Used),
	UsedMin is Used / 60,
	(   config(experiment(Name, Options)),
	    memberchk(minimum_time(MinMinutes), Options)
	->  true
	;   MinMinutes = 0
	),
	(   UsedMin > MinMinutes
	->  true
	;   (   Warn == @on
	    ->	send(E, error, insufficiently_experimented,
		     MinMinutes, Name, UsedMin)
	    ),
	    fail
	).

run_post_tests(E) :->
	"Run all registered post-tests"::
	config(test_sets(Sets)),
	forall(member(Set, Sets),
	       send(E, run_test, Set)).

run_test(E, Set:[name]) :->
	"Run the test of this experiment (if present)"::
	get(E, name, Name),
	test_file_name(Name, TestName),
	make_test_spec(Set, TestName, Test),
	run_test(Test).

has_test(E, Set:[name]) :->
	"Check if there is a test"::
	get(E, name, Name),
	test_file_name(Name, TestName),
	make_test_spec(Set, TestName, Test),
	current_test(Test).

make_test_spec(@default, TestName, TestName) :- !.
make_test_spec(Set, TestName, Test) :-
	Test =.. [Set, TestName].

test_file_name(ExpName, TestName) :-
	new(S, string('%s', ExpName)),
	send(S, strip),
	send(S, translate, ' ', '_'),
	get(S, value, TestName).

report_to(E, Mgr:experiments) :<-
	get(E, manager, Mgr).

:- pce_end_class.


:- pce_begin_class(experiments, sheet,
		   "Database for experiments").

initialise(S, O:frame) :->
	send(S, send_super, initialise),
	send(S, tool, O).

tool(S, Tool:frame) :->
	send(S, delete_hypers, tool),
	send(Tool, delete_hypers, experiments),
	new(_, hyper(S, Tool, tool, experiments)).
tool(S, Tool:frame) :<-
	get(S, hypered, tool, Tool).

report_to(S, Tool:frame) :<-
	get(S, tool, Tool).

current(EL, Exp:experiment) :<-
	"Get currently opened experiment"::
	get(EL, hypered, current, Exp).

open(EL, Name:name, State:[scene_state]*) :->
	"Set the selected experiment"::
	get(EL, tool, Tool),
	(   get(EL, current, Old)
	->  send(Old, close, Tool)
	;   true
	),
	get(EL, value, Name, New),
	send(New, open, Tool, State),
	new(_, hyper(EL, New, current, experiments)).

restore(EL, Name:name) :->
	"Restore a saved state"::
	get(EL, tool, Tool),
	get(EL, value, Name, New),
	send(New, open, Tool),
	new(_, hyper(EL, New, current, experiments)).

append(S, Exp:'name|experiment') :->
	"Append an experiment"::
	(   atom(Exp)
	->  send(S, value, Exp, new(ExpObj, experiment(Exp)))
	;   get(Exp, name, Name),
	    send(S, value, Name, Exp),
	    ExpObj = Exp
	),
	send(ExpObj, manager, S).


allowed_to_switch_to(S, Exp:name) :->
	"Test if we are allowed to switch to the given experiment"::
	(   (	get(S, tool, Tool),
		get(Tool, attribute, test_version, @on)
	    ;	config(test_mode(true))
	    )
	->  true
	;   get_chain(S, attribute_names, Names),
	    allowed_in_experiment(Exp, S, Names)
	).

allowed_in_experiment(Exp, _, [Exp|_]) :- !.
allowed_in_experiment(_, S, [Pre|_]) :-
	get(S, value, Pre, ExpObj),
	\+ send(ExpObj, satisfied, @on), !,
	fail.
allowed_in_experiment(Exp, S, [_|T]) :-
	allowed_in_experiment(Exp, S, T).
	
ready_for_test(S, Set:[name], Exps:chain) :<-
	"Return chain of experiments ready_for_test"::
	get_chain(S, attribute_names, Names),
	ready_for_test(Names, S, Set, Done),
	chain_list(Exps, Done).

ready_for_test([], _, _, []).
ready_for_test([H|T0], S, Set, [ExpObj|T]) :-
	get(S, value, H, ExpObj),
	send(ExpObj, satisfied),
	send(ExpObj, has_test, Set), !,
	ready_for_test(T0, S, Set, T).
ready_for_test(_, _, _, []).


last_ready_for_test(S, Exp:experiment) :<-
	"Return last experiment if this is ready for test"::
	get(S, members, Members),
	get(Members?tail, value, Exp),
	send(Exp, satisfied).


run_tests(S, Set:[name]) :->
	"Run experiment tests"::
	(   Set == @default
	->  message(start_test, Msg)
	;   message(start_named_test(Set), Msg)
	),
	send(@display, inform, Msg),
	get(S, ready_for_test, Set, Ready),
	send(Ready, for_all, message(@arg1, run_test, Set)).

:- pce_end_class.


