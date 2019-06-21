/*  $Id: rplay.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of Optica
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1998 University of Amsterdam. All rights reserved.
*/

:- module(rplay,
	  [ rplay/0
	  ]).
:- use_module(library(pce)).
:- use_module(save).
:- use_module(pretty_print).
:- use_module(configdb).
:- use_module(toolbar).
:- use_module(hourglass).
:- use_module(parts).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Replay optica logfiles.  Design:

	* Load a logfile, storing it as the predicates

		log_header(HeaderTerm).
		log_event(N, Time, Event).

	  Multiple logfiles can be concatenated this way.

	* Create a `player'.  This displays general info, a browser holding
	  the events, settings for speed, etc.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

		 /*******************************
		 *	      DATABASE		*
		 *******************************/

:- dynamic
	log_event/3,
	log_header/1.

clear_log_database :-
	retractall(log_event(_,_,_)),
	retractall(log_header(_)),
	flag(log_last, _, 1).

%	log_end_time(-Time)
%
%	Find the end of the current log

log_end_time(Time) :-
	flag(log_last, N, N),
	Last is N - 1,
	log_event(Last, Stamp, _Event), !,
	(   Stamp = _From-To
	->  Time = To
	;   Time = Stamp
	).
log_end_time(0).

add_time_stamp(Time, 0, Time) :- !.
add_time_stamp(From0-To0, Offset, From-To) :- !,
	From is From0 + Offset,
	To is To0 + Offset.
add_time_stamp(Time0, Offset, Time) :- !,
	Time is Time0 + Offset.

%	time_of_event(+Id, -StartTime)

time_of_event(Id, Time) :-
	log_event(Id, Stamp, _Event),
	(   Stamp = From-_To
	->  Time = From
	;   Time = Stamp
	).

%	log_event_id(Id)
%
%	Enumaret the event-id's of the current log.

log_event_id(Id) :-
	flag(log_last, N, N),
	Last is N-1,
	between(1, Last, Id).

%	event_before(+Id0, -Id)
%
%	Generate events before this one

event_before(Id, Id).
event_before(1, _) :- !,
	fail.
event_before(Id0, Id) :-
	Id1 is Id0 - 1,
	event_before(Id1, Id).

%	experiment_open_event(+Id, -ExperimentOpenId)
%
%

experiment_open_event(Id, ExperimentOpenId) :-
	event_before(Id, ExperimentOpenId),
	log_event(ExperimentOpenId, _Time, experiment(open(_,_))), !.

%	read_logfile(+File)
%
%	Read facts from the given logfile and assert them into the database.

read_logfile(File) :-
	open(File, read, Fd),
	log_end_time(Offset),
	read(Fd, Term),
	read_logfile(Term, Fd, Offset),
	close(Fd).

read_logfile(end_of_file, _, _) :- !.
read_logfile(@(Time0, Event), Fd, Offset) :- !,
	flag(log_last, N, N+1),
	add_time_stamp(Time0, Offset, Time),
	assert(log_event(N, Time, Event)),
	read(Fd, Next),
	read_logfile(Next, Fd, Offset).
read_logfile(Term, Fd, Offset) :-
	assert(log_header(Term)),
	read(Fd, Next),
	read_logfile(Next, Fd, Offset).


		 /*******************************
		 *	     FIXING LOG		*
		 *******************************/

initial_state(Name, StateTerm) :-
	config(experiment(Name, ExpOptions)),
	memberchk(initial_state(StateTerm), ExpOptions), !.
initial_state(_, []).


fix_log_facts :-
	fix_experiment_open,
	fix_mode_switches.

fix_experiment_open :-
	log_event_id(N),
	(   log_event(N, T, experiment(open(Name)))
	->  (   event_before(N, N2),
	        log_event(N2, _, experiment(close(Name, _, _, StateTerm)))
	    ->	retractall(log_event(N, _, _)),
		assert(log_event(N, T, experiment(open(Name, StateTerm))))
	    ;	retractall(log_event(N, _, _)),
		initial_state(Name, StateTerm),
		assert(log_event(N, T, experiment(open(Name, StateTerm))))
	    )
	),
	fail.
fix_experiment_open.

fix_mode_switches :-
	(   log_event_id(N0),
	    (   log_event(N0,  T0, mode(_)),
		N1 is N0+1,
		log_event(N1, T1, experiment(close(_,_,_,_))),
		N2 is N0+2,
		log_event(N2, T2, experiment(open(_, _)))
	    ->  retract(log_event(N0, T0)),
		retract(log_event(N1, T1)),
		retract(log_event(N2, T2)),
		assert(log_event(N0, T1)),
		assert(log_event(N1, T2)),
		assert(log_event(N2, T0))
	    ),
	    fail
	;   true
	).


		 /*******************************
		 *	      SHOW_LOG		*
		 *******************************/

:- pce_begin_class(log_browser, browser,
		   "Browse log events").

variable(experiment,	name*,	get, "Current experiment id").

initialise(LB) :->
	send(LB, send_super, initialise),
	send(LB?image, tab_stops, vector(130)),
	send(LB, select_message,
	     message(LB?frame, select_event, @arg1?key, @on)),
	send(LB, open_message,
	     message(LB?frame, show_status_at, @arg1?key)),
	send(LB, update).


enter(LB) :->
	get(LB, frame, Player),
	(   get(Player, play_status, idle)
	->  (   get(LB?list_browser, slot, search_string, SS),
	        SS \== @nil
	    ->  send(LB, send_super, enter)
	    ;   get(LB, selection, DI),
		get(DI, key, Id0),
		(   get(Player, current_id, Id0)
		->  Id is Id0+1,
		    time_of_event(Id, Time0),
		    send(Player, select_event, Id, @on),
		    get(LB, member, Id, DI2),
		    send(LB, normalise, DI2),
		    get_time(Epoch),
		    send(Player, slot, epoch, Epoch),
		    send(Player, slot, time_skipped, Time0),
		    send(Player, slot, skipping, @off),
		    play_to(Player, Id)
		;   send(Player, show_status_at, Id0)
		)
	    )
	;   send(Player, schedule, message(LB, enter))
	).


/*
normalise(LB, DI:dict_item) :->
	get(DI, index, Index),
	get(LB?image, lines, LinesVisible),
	StartLine is max(0, Index-LinesVisible//2),
	send(LB, scroll_to, StartLine).
*/


update(LB) :->
	"Reload a the log facts"::
	send(LB, clear),
	(   log_event_id(Id),
		(   log_event(Id, Stamp, Event),
		    update_experiment(Event, LB, Exp),
		    event_icon(Event, Exp, IconName, Comment)
		->  send(LB, register_icon, IconName),
		    event_label(Stamp, Comment, Label),
		    send(LB, append, dict_item(Id, Label, Exp, IconName))
		),
	    fail
	;   true
	).

update_experiment(experiment(open(Exp, _)), LB, Exp) :- !,
	send(LB, slot, experiment, Exp).
update_experiment(_, LB, Exp) :-
	get(LB, experiment, Exp).

register_icon(LB, IconName:name) :->
	(   get(LB, styles, StyleSheet),
	    get(StyleSheet, value, IconName, _)
	->  true
	;   new(I, image(IconName)),
	    (	get(I, size, size(16,16))
	    ->	Img = I
	    ;	get(I, scale, size(16,16), Img),
		send(Img, lock_object, @on)
	    ),
	    send(LB, style, IconName, style(Img))
	).

event_label(From-To, Comment, String) :- !,
	MinF is round(From)//60,
	SecF is	round(From) mod 60,
	MinT is round(To)//60,
	SecT is	round(To) mod 60,
	new(String, string(' [%02d:%02d-%02d:%02d]\t%s',
			   MinF, SecF, MinT, SecT, Comment)).
event_label(Time, Comment, String) :-
	Min is round(Time)//60,
	Sec is	round(Time) mod 60,
	new(String, string(' [%02d:%02d]\t%s', Min, Sec, Comment)).

event_icon(view(theory,     _), _, 'theory.xpm',	'').
event_icon(view(assignment, _), _, 'assignment.xpm',	'').
event_icon(view(help, _),	_, 'winhelp.xpm',	'').
event_icon(add(Name=Term),	_, Icon,		Name) :-
	arg(_, Term, instrument_name(InstrumentName)),
	config(instrument(InstrumentName, Attrs, _)),
	memberchk(icon(Icon), Attrs), !.
event_icon(add(Name=Term),	_, Icon,		Name) :-
	functor(Term, Functor, _),
	instrument_icon(Functor, Term, Icon).
event_icon(mode(Mode),		_, Icon,		'') :-
	config(instrument(Mode, Attrs, _)),
	memberchk(icon(Icon), Attrs), !.
event_icon(mode(Tool),		_, ToolIcon,		'') :-
	instrument:tool(Tool, Attributes),		% HACK
	memberchk(image(ToolIcon), Attributes), !.
event_icon(action(Tool),	_, ToolIcon,		'') :-
	instrument:tool(Tool, Attributes),		% HACK
	memberchk(image(ToolIcon), Attributes), !.
event_icon(action(Tool),	_, ToolIcon,		'') :-
	instrument:tool(_, Attributes),			% HACK
	memberchk(action(Tool), Attributes),
	memberchk(image(ToolIcon), Attributes), !.
event_icon(rotate(Name, _),	_, 'rotlamp.xpm',	Name).
event_icon(move(Name, x, _),	_, 'xmove.xpm',		Name).
event_icon(move(Name, y, _),	_, 'ymove.xpm',		Name).
event_icon(move(Name, x, _, _),	_, 'xmove.xpm',		Name).
event_icon(move(Name, y, _, _),	_, 'ymove.xpm',		Name).
event_icon(tool(Name, _),	_, 'tool.xpm',		Name).
event_icon(delete(Name),	_, 'snapr.xpm',		Name).
event_icon(notebook(_),		_, 'idea.xpm',		'').
event_icon(measured(List),	_, 'gauge.xpm',		Comment) :-
	maplist(functor, List, Names),
	concat_atom(Names, ', ', Comment).
event_icon(experiment(open(Name, _)), _, 'take.xpm',	Name).
event_icon(experiment(close(Name, _, _ ,_)), _, 'exit.xpm', Name).
event_icon(quit(Name, _),	_, 'exit.xpm',		Name).
event_icon(_,			_, 'mini-question.xpm',	'').

instrument_icon(lens,		   _, 'poslens.xpm').
instrument_icon(ruler,		   _, 'ruler.xpm').
instrument_icon(protractor,	   _, 'protractor.xpm').
instrument_icon(beam_extender,	   _, 'extbeam.xpm').
instrument_icon(construction_line, T, 'hconsline.xpm') :-
	arg(_, T, orientation(horizontal)).
instrument_icon(construction_line, _, 'consline.xpm').
instrument_icon(calculator,	   _, 'calc.xpm').
instrument_icon(_,		   _, 'mini-question.xpm').

functor(Term, Name) :-
	functor(Term, Name, _Arity).

:- pce_end_class.

		 /*******************************
		 *	       PLAYER		*
		 *******************************/

:- pce_begin_class(player, frame,
		   "Replayer of Optica logfiles").


variable(current_id,	int*,		get, "Currently simulated Id").
variable(play_status,	{idle,playing} := idle, get, "Status").
variable(epoch,		real*,		get, "Wall-clock for T=0").
variable(time_skipped,	real*,		get, "Amount of time skipped").
variable(time_scale,	real,		get, "Time scaling").
variable(pauze_limit,	real,		get, "Max pause").
variable(skipping,	bool := @off,	get, "Don't show states").
variable(msg_queue,	chain,		get, "Queued messages").

initialise(P) :->
	send(P, send_super, initialise, 'Optica Logfile Player'),
	send(P, slot, time_scale, 1),
	send(P, slot, pauze_limit, 3),
	send(P, slot, msg_queue, new(chain)),
	send(P, append, new(D, dialog)),
	send(D, append, new(TB, tool_bar(P))),
	send(D, append, new(HG, hourglass), right),
	send(D, gap, size(0, 5)),
	send(HG, alignment, right),
	send(TB, attribute, reference, point(0,0)),
	send(HG, attribute, reference, point(0,0)),
	send(D, resize_message, message(D, layout, @arg2)),
	send_list(TB, append,
		  [ tool_button(load,
				'restore.xpm',
				'Load Optica Logfile')
		  ]),
	send(new(V, view), right, new(log_browser)),
	send(V, size, size(50, 10)),
	send(V, below, D).

schedule(P, Msg:code) :->
	send(P?msg_queue, append, Msg),
	get(P, member, dialog, Dialog),
	get(Dialog, member, hourglass, HG),
	send(HG, abort),
	send(P, slot, skipping, @on).

load(P) :->
	"Load an Optica logfile"::
	get(@finder, file, @on, olg, File),
	clear_log_database,
	read_logfile(File),
	fix_log_facts,
	send(P, update).

update(P) :->
	get(P, member, log_browser, LB),
	send(LB, update).

select_event(P, Id:int, ShowDetails:[bool]) :->
	"Show event of given id"::
	get(P, member, log_browser, LB),
	send(LB, selection, Id),
	(   ShowDetails \== @off
	->  get(P, member, view, View),
	    send(View, clear),
	    log_event(Id, _Time, Term),
	    pce_open(View, write, Fd),
	    pretty_print(Fd, Term),
	    close(Fd),
	    send(View, caret, 0),
	    send(View, scroll_to, 0),
	    send(View, editable, @off)
	;   true
	).

:- pce_group(optica).

optica(P, Optica:optica) :<-
	"Get an instance of optica suitable for playing"::
	(   get(P, hypered, optica, Optica)
	->  true
	;   new(Optica, optica),
	    send(Optica, attach_experiment_menu),
	    send(Optica, open),
	    send_part(Optica/optical_workspace, auto_switch_off(@off)),
	    new(_, hyper(P, Optica, optica, player))
	).

goto_start_of_experiment(P, Id:int) :->
	"Goto the start of the experiment holding event-id"::
	get(P, optica, Optica),
	(   experiment_open_event(Id, OpenId)
	->  log_event(OpenId, Time0, experiment(open(Exp, StateTerm))),
	    state_to_term(State, StateTerm)
	;   get(Optica, experiments, ExpMgr),
	    get(ExpMgr?members?head, name, Exp),
	    initial_state(Exp, StateTerm),
	    state_to_term(State, StateTerm),
	    OpenId = 0,
	    Time0 = 0
	),
	send(Optica, experiment, Exp, State),
	get_time(Epoch),
	send(P, slot, epoch, Epoch),
	send(P, slot, time_skipped, Time0),
	send(P, slot, current_id, OpenId).


show_status_at(P, Id:int) :->
	"Show status at indicated location"::
	(   get(P, current_id, Current),
	    integer(Current),
	    Id >= Current,
	    Id - Current < 10
	->  true
	;   send(P, goto_start_of_experiment, Id)
	),
	send(P, slot, skipping, @on),
	play_to(P, Id).


play_to(P, Id:int) :->
	"Simulate upto the given event-id"::
	send(P, goto_start_of_experiment, Id),
	send(P, slot, skipping, @off),
	play_to(P, Id).


play_to(P, Id) :-
	send(P, slot, play_status, playing),
	do_play_to(P, Id),
	send(P, slot, play_status, idle),
	get(P, msg_queue, Queue),
	repeat,
	    (	send(Queue, empty)
	    ->	!
	    ;	get(Queue, delete_head, Msg),
		send(Msg, forward, P),
		fail
	    ).


do_play_to(P, Id) :-
	get(P, current_id, Current),
	Current >= Id, !.
do_play_to(P, Id) :-
	get(P, current_id, CurrentId),
	NextId is CurrentId+1,
	send(P, slot, current_id, NextId),
	send(P, select_event, NextId, @off),
	log_event(NextId, Time, Term),
	rplay(Time, Term, P),
	(   get(P, skipping, @on)
	->  true
	;   send(P, synchronise)
	),
	do_play_to(P, Id).


delay_to(P, Time:real) :->
	"Wait upto the specified time"::
	(   get(P, skipping, @on)
	->  true
	;   get(P, epoch, Epoch),
	    get(P, time_skipped, Skipped),
	    get(P, time_scale, Scale),
	    get_time(Now),
	    RealDelay is Epoch+Time-Skipped-Now,
	    Delay is RealDelay * Scale,
	    (   Delay =< 0.01
	    ->  true
	    ;   get(P, pauze_limit, Limit),
		Delay > Limit
	    ->  NewSkip is Skipped + (Delay-Limit)/Scale,
		send(P, slot, time_skipped, NewSkip),
		send(P, delay, Limit)
	    ;   send(P, delay, Delay)
	    )
	).

delay(P, Time:real) :->
	"Do the real delay"::
	get(P, member, dialog, D),
	get(D, member, hourglass, HG),
	send(HG, displayed, @on),
	Initial is max(2, min(9, integer(Time/0.3))),
	send(HG, wait, Time, Initial),
	send(HG, displayed, @off).

:- pce_end_class.

rplay :-
	load_config('test.opa'),
	send(new(player), open).


		 /*******************************
		 *	    SIMULATING		*
		 *******************************/


rplay(From-To, view(Text, _), Player) :- !,
	(   get(Player, skipping, @on)
	->  true
	;   send(Player, delay_to, From),
	    get(Player, optica, Optica),
	    send(Optica, text_viewer, Text, @off),
	    send(Player, delay_to, To),
	    get(Optica, transients, Frames),
	    get(Frames, find, message(@arg1, instance_of, textviewer), TV),
	    send(TV, show, @off),		% Why do we need this?
	    send(TV, destroy)
	).
rplay(From-To, notebook(Actions), Player) :- !,
	send(Player, delay_to, From),
	get(Player, optica, O),
	new(E, notebook(O)),
	send(E, transient_for, O),
	send(E, modal, transient),
	send(E, open_centered, O?area?center),
	drag_actions(Actions, From, Player,
		     Action, notebook_action(Action, E)),
	send(Player, delay_to, To),
	send(E, destroy).
rplay(From-_, rotate(Name, Points), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	drag_actions(Points, From, Player, drag(X), send(Object, angle, X)).
rplay(From-_, move(Name, x, Points), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	drag_actions(Points, From, Player, drag(X), send(Object, pos_x, X)).
rplay(From-_, move(Name, y, Points), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	drag_actions(Points, From, Player, drag(Y), send(Object, pos_y, Y)).
rplay(From-_, move(Name, x, _, Points), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	drag_actions(Points, From, Player, drag(X), send(Object, pos_x, X)).
rplay(From-_, move(Name, y, _, Points), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	drag_actions(Points, From, Player, drag(Y), send(Object, pos_y, Y)).
rplay(From-_, tool(Name, Actions), Player) :- !,
	get(Player, optica, Optica),
	get(Optica, find_object, Name, Object),
	all_actions(Actions, From, Player, tool(N, V), send(Object, N, V)).
rplay(From-_To, Action, Player) :- !,
	send(Player, delay_to, From),
	get(Player, optica, Optica),
	rdo(Action, Optica).
rplay(Time, Action, Player) :-
	send(Player, delay_to, Time),
	get(Player, optica, Optica),
	rdo(Action, Optica).

rdo(add(Term), Optica) :-
	get(Optica, member, optical_workspace, WS),
	send(@optical_workspace, assign, WS), % must be scoped!
	state_to_term(State, state('$add', 'Dummy State', [Term])),
	get(State?head, restore, Object),
	get(Optica, member, optical_workspace, WS),
	send(WS, display, Object),
	send(WS, update),
	(   send(Object, has_send_method, show_value)
	->  send(Object, show_value, @on)	% dubious
	;   true
	).
rdo(add(_Term), _Optica) :-
	trace, fail.
rdo(mode(Name), Optica) :-
	send(Optica, instrument, Name).
rdo(delete(Name), Optica) :-
	get(Optica, find_object, Name, Object),
	get(Optica, hypered, player, Player),
	(   get(Player, skipping, @on)
	->  send(Object, destroy)
	;   send(Object, delete)
	).
rdo(action(delete_all), Optica) :- !,
	get(Optica, hypered, player, Player),
	get(Player, skipping, Quick),
	send(Optica, delete_all, @off, Quick),
	(   get(Optica, experiment, Exp),
	    Exp \== @nil,
	    initial_state(Exp, StateTerm)
	->  state_to_term(State, StateTerm),
	    send(Optica, experiment, Exp, State)
	;   true
	).
rdo(action(calculator), _) :- !.	% just catch the add operation
rdo(action(Action), Optica) :-
	send(Optica, Action).
rdo(measured(_Values), _Optica) :-
	true.
rdo(experiment(close(_Name, _Spent, _TotalSpent, _State)), _Optica) :-
	true.
rdo(experiment(open(Name, StateTerm)), Optica) :-
	state_to_term(State, StateTerm),
	send(Optica, experiment, Name, State).
rdo(quit(_Experiment, _State), _Optica) :-
	true.
rdo(Term, _) :-
	format('*** Replay: Failed to interpret action:~n', []),
	pretty_print(Term).

%	drag_actions(Actions, T0, Player, Pattern, Goal)
%
%	Simulate the user a dragging.  TBD: interpolate!

drag_actions([], _, _, _, _).
drag_actions(List, _, Player, Pattern, Goal) :-
	get(Player, skipping, @on), !,
	last(@(_, Term), List),
	copy_term(Pattern-Goal, Term-CopiedGoal),
	CopiedGoal.
drag_actions([@(TD, Term)|Actions], T0, Player, Pattern, Goal) :-
	copy_term(Pattern-Goal, Term-CopiedGoal),	% avoid instantiation
	Time is TD+T0,
	send(Player, delay_to, Time),
	CopiedGoal,
	send(@display, synchronise),
	drag_actions(Actions, T0, Player, Pattern, Goal).

all_actions([], _, _, _, _).
all_actions([@(TD, Term)|Actions], T0, Player, Pattern, Goal) :-
	copy_term(Pattern-Goal, Term-CopiedGoal),	% avoid instantiation
	Time is TD+T0,
	send(Player, delay_to, Time),
	CopiedGoal,
	(   get(Player, skipping, @on)
	->  true
	;   send(@display, synchronise)
	),
	all_actions(Actions, T0, Player, Pattern, Goal).

notebook_action(action(notebook), _) :- !.
notebook_action(note(Id, Label, Experiment, Text, StateTerm), NoteBook) :- !,
	repeat,
	(   get(@notes, member, Id, DI)
	->  send(@notes, delete, DI),
	    fail
	;   !
	),
	new(Note, note(Id, Label, Text)),
	send(Note, experiment, Experiment),
	state_to_term(State, StateTerm),
	send(Note, state, State),
	send(@notes, append, Note),
	notebook_action(view(Id), NoteBook).
notebook_action(view(Id), NoteBook) :-
	send(NoteBook, view, Id).
