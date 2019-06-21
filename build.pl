/*  $Id: build.pl,v 1.1 2000/02/07 10:29:34 jan Exp $

    Part of OPTICA
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 2000 University of Amsterdam. All rights reserved.
*/

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
This file is meant to create an executable for optica.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- [login].				% load base system

		 /*******************************
		 *	     TOPLEVEL		*
		 *******************************/

%	optica -config
%	optica [ConfigFile]

%run_optica :-				% For debugging
%	true.
run_optica :-
	(   send(@pce, has_send_method, max_goal_depth)
	->  send(@pce, max_goal_depth, 10000)
	;   true
	),
	pce_loop(run_optica),
	halt.

run_optica(_Argv) :-
	ignore(get(new(optica_login), confirm_centered, _)).


		 /*******************************
		 *	     SAVING		*
		 *******************************/

save_optica(Exe) :-
	current_prolog_flag(unix, true),
	file_name_extension(Base, exe, Exe), !,
        format('**** Generating Cross platform saved-state ****~n', []),
	pce_autoload_all,
	pce_autoload_all,
	qsave_program(Base, [goal(run_optica)]),
	sformat(Cmd, 'cat ~w ~w > ~w',
		[ '/staff/jan/einstein/src/pl/bin/plwin.exe',
		  Base,
		  Exe
		]),
	shell(Cmd),
	delete_file(Base).
save_optica(X) :-
	pce_autoload_all,
	pce_autoload_all,
	qsave_program(X,
		      [ stand_alone(true),
			goal(run_optica)
		      ]).

save_optica :-
	current_prolog_flag(argv, Av),
	append(_, [--, Exe], Av), !,
	save_optica(Exe).
save_optica :-
	save_optica(optica).

:- save_optica.				% write executable
:- halt.				% and halt
