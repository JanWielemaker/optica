/*  $Id: log.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(log,
	  [ open_log/2,
	    open_log/3,
	    close_log/0,
	    log/1,
	    logging/1,
	    read_log/4			% +Optica, +File, +State0, -State
	  ]).
:- use_module(library(pce)).
:- use_module(pretty_print).
:- use_module(local(save)).
:- use_module(util).
:- require([ absolute_file_name/3
	   , append/3
	   , atan2/3
	   , get_time/1
	   , memberchk/2
	   , round/2
	   ]).


:- dynamic
	log_stream/3,		% File, Stream, Start
	flush_timer/1.

open_log(File, PP) :-
	open_log(File, 'Optica simulation', PP).

open_log(File, Creator, PP) :-
	absolute_file_name(File, Path),
	open(Path, append, Fd),		% play safe
	get_time(Time0),
	asserta(log_stream(Path, Fd, Time0)),
	get(@pce?date, value, Date),
	format(Fd, '/*  Log file created by ~w~n', [Creator]),
	format(Fd, '    Date: ~w~n', [Date]),
	format(Fd, '*/~n~n', []),
	format(Fd, '%% Header~n', []),
	format(Fd, 'pp(~q).~n', [PP]),
	format(Fd, 'epoch(~1f).~n', [Time0]),
	format(Fd, '%% End Header~n~n', []),
	flush_output(Fd).

log(Term) :-
	log_stream(_, Fd, Time0),
	current_stream(_, _, Fd), !,
	get_time(Time),
	T is Time - Time0,
	log(Term, Fd, time(T)),
	flush_output(Fd).
log(Term) :-				% reopen after an abort
	retract(log_stream(Path, _, Time0)), !,
	(   open(Path, append, Fd)
	->  asserta(log_stream(Path, Fd, Time0)),
	    log(Term)
	;   send(@display, inform, 'Failed to reopen log file %s', Path)
	).
log(_).

:- dynamic
	loggroup/2.

%	logging(+Term)
%	See whether there is a begin(Term) active.

logging(Term) :-
	loggroup(begin(Begin), _Time), !,
	functor(Term, Name, A),
	functor(Begin, Name, A).

log(begin(Term), _, T) :- !,
	asserta(loggroup(begin(Term), T)).
log(end(EndTerm), Fd, T) :- !,
	collect_group(Term, OpenT),
	(   functor(Term, Name, A),
	    functor(EndTerm, Name, EA),
	    A =:= EA + 1
	->  true
	;   format('Begin/end log group mismatch: ~w/~w~n', [Term, EndTerm])
	),
	(   loggroup(_, _)
	->  asserta(loggroup(Term, OpenT-T))
	;   pretty_print(Fd, @(OpenT-T, Term))
	).
log(end, Fd, T) :- !,
	collect_group(Term, OpenT),
	(   loggroup(_, _)
	->  trace,
	    asserta(loggroup(Term, OpenT-T))
	;   pretty_print(Fd, @(OpenT-T, Term))
	).
log(add(term(Gr)), Fd, T) :- !,
	new(Scene, scene_state(log)),
	get(Scene, save_state, Gr, _),
	state_to_term(Scene, state(_, _, [Obj])),
	log(add(Obj), Fd, T).
log(Term, _, T) :-
	loggroup(_, _), !,
	asserta(loggroup(Term, T)).
log(Term, Fd, T) :-
	pretty_print(Fd, @(T, Term)).

collect_group(Term, OpenT) :-
	collect_group(Begin, OpenT, [], Members0),
	OpenT = time(Time0),
	time_relative(Members0, Time0, Members),
	Begin =.. List,
	append(List, [Members], L2),
	Term =.. L2.

%	time_relative(-Events, Time0, -RelativeEvents)
%
%	relate all times in a group to the time the group started.

time_relative([], _, []).
time_relative([@(time(Time), Term)|T0], Time0, [@(time(RTime), Term)|T]) :- !,
	RTime is Time - Time0,
	time_relative(T0, Time0, T).
time_relative([@(time(Time1)-time(Time2),   Term)|T0], Time0,
	      [@(time(RTime1)-time(RTime2), Term)|T]) :- !,
	RTime1 is Time1 - Time0,
	RTime2 is Time2 - Time0,
	time_relative(T0, Time0, T).
time_relative([H|T0], Time0, [H|T]) :-
	time_relative(T0, Time0, T).
	

%	collect_group(-Begin, -Time0, +Members0, -Members)
%
%	Collect the members from a group.  Begin is the begin(Begin) term,
%	Time0 is the start-time of the group.  Members0 is normally [],
%	Members is a list of events.  Drag events are collided if they
%	are within 1 second, and going in the same direction, or at
%	the same location.

collect_group(Begin, OpenT, Members0, Members) :-
	retract(loggroup(Term, T)), !,
	(   Term = begin(Begin)
	->  OpenT = T,
	    collide_drag_events(Members0, 1, _, Members)
	;   collect_group(Begin, OpenT, [@(T, Term)|Members0], Members)
	).

collide_drag_events([], _, _, []).
collide_drag_events([E1, E2|T0], TD, Dir, L) :-
	collide_events(E1, E2, TD, Dir), !,
	collide_drag_events([E2|T0], TD, Dir, L).
collide_drag_events([E1, E2|T0], TD, _, [E1|L]) :-
	dir_events(E1, E2, Dir), !,
	collide_drag_events([E2|T0], TD, Dir, L).
collide_drag_events([E1|T0], TD, Dir, [E1|T]) :-
	collide_drag_events(T0, TD, Dir, T).


collide_events(@(_,drag(V)), @(_, drag(V)), _, _) :- !.
collide_events(@(_,drag(VX,VY)), @(_, drag(VX,VY)), _, _) :- !.
collide_events(@(time(T1),drag(V1)), @(time(T2), drag(V2)), TD, D) :-
	compare(D, V1, V2),
	T2 - T1 < TD.
collide_events(@(time(T1),drag(Vx1,Vy1)), @(time(T2), drag(Vx2,Vy2)), TD, D) :-
	D is round(atan(Vy2-Vy1, Vx2-Vx1) * 2/pi),
	T2 - T1 < TD.

dir_events(@(_,drag(V1)), @(_, drag(V2)), D) :-
	compare(D, V1, V2).
dir_events(@(_,drag(Vx1,Vy1)), @(_, drag(Vx2,Vy2)), D) :-
	D is round(atan(Vy2-Vy1, Vx2-Vx1) * 2/pi).

close_log :-
	(   retract(log_stream(_, Fd, _))
	->  close(Fd)
	;   true
	).

flush_log :-
	(   log_stream(_, Fd, _)
	->  flush_output(Fd)
	;   true
	).


		 /*******************************
		 *	       READ-LOG		*
		 *******************************/

:- dynamic
	open_time/2.

end_time_log(@(_-Time, _), Time) :- !.
end_time_log(@(Time, _), Time).

read_log(Optica, File, State0, State) :-
	retractall(open_time(_, _)),
	(   State0 = state(Exp0, _)
	->  asserta(open_time(Exp0, 0))
	;   true
	),
	absolute_file_name(File, [access(read)], LogFile),
	open(LogFile, read, Fd),
	with_long_atoms((read(Fd, Term0),
			 read_log(Term0, Fd, Optica, State0, State))),
	close(Fd).

read_log(end_of_file, _, _, State, State) :- !.
read_log(Term, Fd, Optica, State0, State) :-
	(   handle_log_term(Term, Optica, State0, State1)
	->  true
	;   State1 = State0
	),
	read(Fd, Term1),
	fix_no_quit(Term1, Term, Optica, State1),
	read_log(Term1, Fd, Optica, State1, State).

fix_no_quit(end_of_file, Last, Optica, state(ExpName, _)) :-
	\+ Last = @(_, quit(_,_)),
	end_time_log(Last, EndTime),
	open_time(Exp, Open),
	get(Optica, experiments, ExpMgr),
	get(ExpMgr, value, ExpName, Exp), !,
	get(Exp, time, Time0),
	Time is Time0 + EndTime - Open,
	send(Exp, time, Time).
fix_no_quit(_, _, _, _).

handle_log_term(@(_, notebook(NoteActions)), _,
		_, state(Experiment, StateTerm)) :-
	memberchk(@(_, note(Id, Label, Experiment, Text, StateTerm)),
		  NoteActions),
	new(Note, note(Id, Label, Text)),
	send(Note, experiment, Experiment),
	state_to_term(State, StateTerm),
	send(Note, state, State),
	send(@notes, append, Note).
handle_log_term(@(Time, reopen(Exp, State)), _, _, state(Exp, State)) :-
	retractall(open_time(_, _)),
	asserta(open_time(Exp, Time)).
handle_log_term(@(Time, experiment(open(ExpName))), _, _, state(ExpName, [])) :-
	retractall(open_time(_, _)),
	asserta(open_time(ExpName, Time)).
handle_log_term(@(_, experiment(close(ExpName, _, TotalTime, StateTerm))),
		Optica, _, state(ExpName, StateTerm)) :-
	get(Optica, experiments, ExpMgr),
	get(ExpMgr, value, ExpName, Exp),
	send(Exp, time, TotalTime),
	state_to_term(State, StateTerm),
	send(Exp, state, State).
handle_log_term(@(EndTime, quit(ExpName, StateTerm)), Optica,
		_, state(ExpName, StateTerm)) :-
	get(Optica, experiments, ExpMgr),
	get(ExpMgr, value, ExpName, Exp),
	(   open_time(ExpName, Open)
	->  get(Exp, time, Time0),
	    Time is Time0 + EndTime - Open,
	    send(Exp, time, Time)
	;   true
	),
	state_to_term(State, StateTerm),
	send(Exp, state, State).
	
%	Bubbles logterms: no multiple experiments (to be moved)

handle_log_term(@(_, notebook(NoteActions)), _,
		_, StateTerm) :-
	memberchk(@(_, note(Id, Label, Text, StateTerm)),
		  NoteActions),
	new(Note, note(Id, Label, Text)),
	state_to_term(State, StateTerm),
	send(Note, state, State),
	send(@notes, append, Note).
handle_log_term(@(_, quit(StateTerm)), _,
		_, StateTerm).


