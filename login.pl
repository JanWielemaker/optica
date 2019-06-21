/*  $Id: login.pl,v 1.3 1999/11/18 16:20:45 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(optica_login,
	  [ optica/0,			% Unconstrained emnvironment
	    optica/1,			% Configured environment
	    login/0,			% Entry through login
	    run_optica/0,		% Toplevel runtime entry
	    save_optica/1		% +Executable
	  ]).
:- use_module(user:library('compatibility/resource')).
:- use_module(library(pce)).
:- use_module(lens).
:- use_module(configdb).
:- use_module(log).
:- use_module(util).
:- use_module(language).
:- use_module(save).
:- use_module(test).
:- use_module(rplay).
:- require([ absolute_file_name/3
	   , chain_list/2
	   , concat/3
	   , concat_atom/2
	   , concat_atom/3
	   , file_base_name/2
	   , file_name_extension/3
	   , maplist/3
	   , member/2
	   , send_list/3
	   ]).

optica_version('2.5').

login :-
	send(new(optica_login), open_centered).

:- pce_begin_class(optica_login, dialog,
		   "Login window").

initialise(D) :->
	optica_version(Version),
	message(optica_login(Version), Msg),
	send(D, send_super, initialise, Msg),
	send(D, append, new(Config, menu(configuration, choice))),
	configfiles(Configurations),
	send_list(Config, append, Configurations),
	length(Configurations, L),
	Cols is max(1, L // 5),
	send(Config, columns, Cols),
	     
	send(D, append, identifier_item(student, '')),
	send(D, append, new(Ok, button(ok))),
	send(D, append, button(settings)),
	send(D, append, button(replay)),
	send(D, append, button(cancel)),
	send(Ok, active, @off),
	send(Ok, default_button, @on).

ok(D) :->
	get_part(D/configuration, selection, Config),
	load_config_base(Config),
	check_configuration,
	(   config(window(Status))
	->  true
	;   Status = window
	),
	(   config(log(true))
	->  (   get_part(D/student, selection, Name)
	    ->  session_id(Name, Session),
		set_fact(user(Name)),
		set_fact(session(Session)),
		make_answer_directories,
		(   Session == 1,
		    config(pretest(TestName)),
		    config(test_sets(Tests))
		->  (   member(Test, Tests),
		        Term =.. [Test, TestName],
			run_test(Term),
			fail
		    ;	true
		    )
		;   true
		),
		new(O, optica),
		send(O, attach_experiment_menu),
		send(O, status, Status),
		start_log(O, Name, Session, State),
		(   Session == 1
		->  send(O, show_open_texts)
		;   State = state(Exp, _StateTerm),
		    send(O, restore_experiment, Exp)
		)
	    ;   send(D, error, no_student_name),
		fail
	    )
	;   new(O, optica),
	    send(O, attach_experiment_menu),
	    send(O, status, Status)
	),
	send(D, destroy).
	
cancel(D) :->
	send(D, destroy).

settings(D) :->
	get_part(D/configuration, selection, Config),
	load_config_base(Config),
	send(new(O, optica), open),
	send(O, wait),
	send(O, configure).
	
replay(D) :->
	get_part(D/configuration, selection, Config),
	load_config_base(Config),
	send(new(player), open).
	
:- pce_end_class.

check_configuration :-
	config(log(true)),
	config(log_directory(LogDir)), !,
	(   send(directory(LogDir), exists) % access: write?  Dos/Unix?
	->  true
	;   send(@nil, error, no_log_directory, LogDir),
	    fail
	).
check_configuration.

make_answer_directories :-
	config(log_directory(LogDir)),
	fact(user(User)),
	config(test_sets(Sets)),
	member(Set, Sets),
	concat_atom([LogDir, User, Set], /, SetDir),
	new(Dir, directory(SetDir)),
	(   send(Dir, exists)
	->  true
	;   send(Dir, make)
	),
	fail.
make_answer_directories.


%	session_id(+Name, -SessionNumber)
%
%	See which session this is.

session_id(Name, Session) :-
	config(log_directory(LogDir)),
	concat_atom([LogDir, /, Name], PPDir),
	new(Dir, directory(PPDir)),
	set_fact(ppdir(PPDir)),
	(   send(Dir, exists)
	->  get(Dir, files, 'session.*\\.olg', LogFileChain),
	    send(LogFileChain, sort),
	    (	get(LogFileChain, tail, F)
	    ->	file_name_extension(LogBase, _, F),
		concat(session, NumberAtom, LogBase),
		atom_codes(NumberAtom, NumberChars),
		number_codes(Number, NumberChars),
		Session is Number + 1
	    ;	Session = 1
	    )
	;   send(Dir, make),
	    Session = 1
	).
	    

		 /*******************************
		 *	      LOG UTIL		*
		 *******************************/

:- pce_begin_class(log_window, view).

initialise(V) :->
	send(V, send_super, initialise, 'Setup log', size := size(80,20)),
	send(V, kind, popup),
	send(V, font, normal),
	send(new(D, dialog), below, V),
	send(D, append, button(ok, message(V, destroy))).

noshow_type(status).
noshow_type(progress).
noshow_type(done).

report(V, Kind:name, Fmt:[char_array], Args:any ...) :->
	(   noshow_type(Kind)
	->  true
	;   send(V, format, '[%s: ', Kind)
	),
	(   Kind == done
	->  send(V, format, 'ok\n')
	;   send(V, send_vector, format, Fmt, Args),
	    (	Kind \== progress
	    ->  send(V, format, '\n')
	    ;	true
	    )
	),
	send(V, synchronise).

log_done(V) :->
	"Done, wait for user"::
	repeat,
	    (	object(V)
	    ->	send(@display, dispatch),
		fail
	    ;	true
	    ), !.

:- pce_end_class.

start_log(Optica, Name, Session, State) :-
	new(Progress, log_window),
	send(Progress, open_centered),
	send(Progress, wait),
	(   fact(ppdir(PPDir))
	->  new(Dir, directory(PPDir)),
	    get(Dir, files, 'session.*\\.olg', LogFileChain),
	    chain_list(LogFileChain, LogFiles0),
	    sort(LogFiles0, LogFiles),
	    free(@notes),
	    default_state(Optica, State0),
	    restore_logs(LogFiles, Optica, PPDir, Progress, State0, State),
	    fact(session(Session)),
	    get(string('%s/session%03d.olg', PPDir, Session), value, LogFile),
	    send(Progress, report, progress,
		 'Opening new log file %s ...', LogFile),
	    close_log,
	    open_log(LogFile, Name),
	    send(Progress, report, done)
	;   true
	),
	send(Progress, report, status,
	     'Initialisation successful'),
	send(Progress, log_done).

default_state(Optica, state(Exp, [])) :-
	get(Optica, experiment, Exp).

restore_logs([], _, _, _, State, State).
restore_logs([H|T], Optica, Dir, Progress, State0, State) :-
	restore_log(H, Optica, Dir, Progress, State0, State1),
	restore_logs(T, Optica, Dir, Progress, State1, State).

restore_log(F, Optica, PPDir, Progress, State0, State) :-
	send(Progress, report, progress, 'Reading log file %s ... ', F),
	concat_atom([PPDir, /, F], OldLog),
	read_log(Optica, OldLog, State0, State),
	send(Progress, report, done).


		 /*******************************
		 *          CONFIG UTIL		*
		 *******************************/

load_config_base(Base) :-
	absolute_file_name(optica(Base),
			   [ extensions([opa]),
			     access(read)
			   ], ConfigFile),
	load_config(ConfigFile).


configfiles(Files) :-
	absolute_file_name(optica(.),
			   [ file_type(directory),
			     access(read)
			   ],
			   Home),
	get(directory(Home), files, '.opa$', Chain),
	chain_list(Chain, Opas),
	maplist(file_base, Opas, Files).

file_base(Path, Base) :-
	file_base_name(Path, File),
	file_name_extension(Base, _, File).
