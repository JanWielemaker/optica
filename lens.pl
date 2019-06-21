/*  $Id: lens.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1996 University of Amsterdam. All rights reserved.
*/


:- module(lens,
	  [ config/0,
	    optica/0,
	    optica/1,			% +ConfigFile
	    run_optica/0,
	    save_optica/1		% +ExecFile
	  ]).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(parms).
:- use_module(ruler).
:- use_module(local(instrument)).
:- use_module(toolbutton).
:- use_module(hypothesis).
:- use_module(hyper).
:- use_module(shield).
:- use_module(model).
:- use_module(protractor).
:- use_module(save).
:- use_module(tool).
:- use_module(snap).
:- use_module(log).
:- use_module(util).
:- use_module(gauge).
:- use_module(notebook).
:- use_module(configdb).
:- use_module(experiment).
:- use_module(language).
:- use_module(messages).
:- use_module(calc).
:- require([ absolute_file_name/3
	   , atan2/3
	   , chain_list/2
	   , concat/3
	   , default/3
	   , file_directory_name/2
	   , file_name_extension/3
	   , forall/2
	   , get_chain/3
	   , ignore/1
	   , maplist/3
	   , member/2
	   , memberchk/2
	   , pce_image_directory/1
	   , pce_loop/1
	   , round/2
	   , send_list/2
	   , send_list/3
	   , sign/2
	   , subset/2
	   ]).


:- pce_autoload(question_author, test).
:- pce_autoload(optica_configure, config).
:- pce_autoload(textviewer, text).

pce_resource(Class, Name, Value) :-
	get(class(Class), resource, Name, Resource),
	send(Resource, value, Value).

:- initialization pce_resource(line, event_tolerance, 10).


		 /*******************************
		 *	      TOPLEVEL		*
		 *******************************/

config :-
	send(@optica_states, read_default_states),
	send(new(optica), open),
	open_log(optica('conf.log'), myself).

optica :-
	send(new(optica), open).

optica(ConfigBase) :-
	send(@optica_states, read_default_states),
	(   absolute_file_name(optica(ConfigBase),
			       [ extensions([opa]),
				 access(read),
				 file_errors(fail)
			       ], ConfigFile)
	->  load_config(ConfigFile),
	    new(O, optica),
	    send(O, attach_experiment_menu),
	    send(O, open)
	;   send(new(optica), open)
	).
%	open_log(optica(log), myself).		% test

%	optica -config
%	optica [ConfigFile]

run_optica :-
	(   send(@pce, has_send_method, max_goal_depth)
	->  send(@pce, max_goal_depth, 10000)
	;   true
	),
	pce_loop(run_optica),
	halt.

run_optica(_Argv) :-
	ignore(get(new(optica_login), confirm_centered, _)).


pce_ifhostproperty(prolog(swi),
[(   save_optica(Exe) :-
	feature(unix, true),
	file_name_extension(Base, exe, Exe), !,
        format('**** Generating Cross platform saved-state ****~n', []),
	pce_autoload_all,
	pce_autoload_all,
	qsave_program(Base, [goal(run_optica)]),
	sformat(Cmd, 'cat ~w ~w > ~w',
		[ '/D/Development/pl/bin/plwin.exe',
		  Base,
		  Exe
		]),
	shell(Cmd),
	delete_file(Base)),
 (   save_optica(X) :-
	(   feature(windows, true)
	->  file_name_extension(X, exe, Exe)
	;   Exe = X
	),
	pce_autoload_all,
	pce_autoload_all,
	qsave_program(Exe, [stand_alone(true), goal(run_optica)]))
]).



		 /*******************************
		 *	       TOOL		*
		 *******************************/

:- pce_begin_class(optica, frame,
		   "The optica environment").

variable(instrument,	name*,	get, 'Currently selected instrument').
variable(experiment,	name*,	get, 'Current experiment environment').

initialise(O) :->
	message(optica_simulation_environment, Title),
	send(O, send_super, initialise, Title),
	send(O, done_message, message(O, quit)),
	send(O, append, new(IH, tool_dialog)),
	send(new(WS, optical_workspace), below, IH),
	send(new(D2, dialog), below, WS),
	send(D2, gap, size(5, 5)),
	send(D2, append, label(reporter)),
	send(O, fill_instruments),
	send(O, instrument, lens).


report(O, Kind:name, Fmt:char_array, Args:any ...) :->
	(   (   Kind == error
	    ;	send(@vmi_send, parent_goal, O, report)
	    )
	->  send(O?display, send_vector, report, Kind, Fmt, Args)
	;   send(O, send_super, send_vector, report, Kind, Fmt, Args)
	).


experiments(O, ExpMgr:experiments) :<-
	get(O, hypered, experiments, ExpMgr).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
There are three reasons to switch  to   an  experiment.  One is from the
menu, this is represented by ->switch_to_experiment.   The other is from
the notebook. This uses ->experiment: Name, State, and the last is after
restoring a session.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

switch_experiment_mode(O, Exp:name*) :->
	(   get(O, experiment, Exp)
	->  true
	;   get(O, member, tool_dialog, IH),
	    send(O, slot, experiment, Exp),
	    send(IH, clear),
	    send(O, fill_instruments),
	    send(IH, layout),
	    (	Exp \== @nil,
		get_part(O/dialog/experiments, self, ExpMenu),
		get(ExpMenu, member, Exp, ExpMI)
	    ->	send(ExpMenu, selection, ExpMI)
	    ;	true			% warn!?
	    ),
	    get(IH?graphicals, head, Menu),
	    get(Menu?members, head, MI),
	    send(O, instrument, MI?value)
	).

experiment(O, Exp:name*, State:[scene_state]*) :->
	get(O, experiment, Old),
	send(O, switch_experiment_mode, Exp),
	(   Old == Exp,
	    State == @default
	->  true
	;   send_part(O/optical_workspace, wait_delete), % more generic?
	    get(O, experiments, ExpMgr),
	    send(ExpMgr, open, Exp, State)
	).


restore_state(O, State:scene_state) :->
	"Restore state (from notebook)"::
	send(O, experiment, State?experiment, State).


restore_experiment(O, Exp:name) :->
	"Restore state.  Do not save state of old experiment"::
	send(O, switch_experiment_mode, Exp),
	(   get(O, experiments, ExpMgr)
	->  send(ExpMgr, restore, Exp)
	;   true
	).


switch_to_experiment(O, Exp:name) :->
	"Switch to the named experiment"::
	(   get(O, experiment, Exp)
	->  true			% no change
	;   get(O, experiments, ExpMgr),
	    ExpMgr \== @nil,
	    (   send(ExpMgr, allowed_to_switch_to, Exp)
	    ->  get(ExpMgr, value, Exp, ExpObj),
		send(ExpObj, test_experiment_before), % if applicable
	        send(O, experiment, Exp),
		send(O, show_open_texts)
	    ;   get(O, experiment, Old),
		ignore(send_part(O/dialog/experiments, selection(Old)))
	    )
	).


show_open_texts(O) :->
	"Show opening text of current experiment"::
	(   get(O, experiments, ExpMgr),
	    ExpMgr \== @nil
	->  get(ExpMgr, current, Exp),
	    send(Exp, show_open_texts, O)
	;   true
	).


attach_experiment_menu(O, Exps:[chain]) :->
	"Attach the menu for switching experiments"::
	get(O, member, dialog, D),
	send(D, display,
	     new(M, menu(experiments, choice,
			 message(O, switch_to_experiment, @arg1)))),
	send(M, show_label, @off),
	new(ExpMgr, experiments(O)),
	(   Exps == @default
	->  experiments(Names)
	;   chain_list(Exps, Names)
	),
	send_list(ExpMgr, append, Names),
	send_list(M, append, Names),
	send(D, resize_message,
	     and(message(M, x, D?visible?right_side - M?width),
		 message(M, center_y, D?visible?center?y))),
	get(M?members, head, MI),
	get(MI, value, First),
	send(O, experiment, First).


fill_instruments(O) :->
	"Add the default instruments"::
	get(O, member, optical_workspace, OW),
	get(O, member, tool_dialog, IH),
	findall(Name, instrument(O, Name, _), Names),
	(   memberchk(show_gauges, Names)
	->  send(OW, auto_hide_gauges, @on)
	;   send(OW, auto_hide_gauges, @off)
	),
	(   (   memberchk(switch, Names)
	    ;	config(auto_switch_off(true))
	    )
	->  send(OW, auto_switch_off, @on)
	;   send(OW, auto_switch_off, @off)
	),
	length(Names, L),
	(   L * 35 > 640
	->  (   instrument(O, Name, Atts),
	        (   Name == separator,
		    memberchk(next_row, Atts)
		->  send(IH, add_tool, next_row)
		;   send(IH, add_tool, Name)
		),
		fail
	    ;	true
	    )
	;   send_list(IH, add_tool, Names)
	).

test_editor(Tool) :->
	"Start the test editor"::
	send(new(Q, question_author(Tool)), open),
	new(_, hyper(Tool, Q, configure, tool)).

configure(Tool) :->
	"Start configuration editor"::
	new(C, optica_configure),
	send(C, transient_for, Tool),
	send(C, open_centered, Tool?area?center).

instrument(O, Instrument:name) :->
	"Set the current instrument"::
	get(O, member, tool_dialog, IH),
	(   current_instrument(O, Instrument, [action(Action)])
	->  send(O, Action),
	    get(O, instrument, Old),
	    send(IH, instrument, Old),
	    log(action(Action))
	;   send(O, slot, instrument, Instrument),
	    send(IH, instrument, Instrument),
	    current_instrument(O, Instrument, [cursor(Cursor)]),
	    get(O, member, optical_workspace, WS),
	    send(WS, cursor, Cursor),
	    log(mode(Instrument))
	).


show_gauges(O) :->
	"Show the gauge values"::
	send_part(O/optical_workspace, show_gauges).


switch_on(O) :->
	"Switch lamps on"::
	send_part(O/optical_workspace, switch(@on)).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
This is a tricky example. It would be   much  more natural to return the
typed text, and build the formula after the <-confirm_centered, but this
would relate error messages from  our  formula   to  our  caller, as the
context of the event triggering  the   return  has  already finished. As
there is not yet a  formula,  we   cannot  use  <-report_to  to fix this
problem. Therefore we will have to do  the translation in the message of
the button. One of the few  examples  where   we  use  a function (?) on
@prolog. The alternative would be to create   a  class, but to my humble
opinion this is too much. Classes use more memory, but most importantly,
they require a name in the flat class name-space.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

calculator(O) :->
	"Create a formula"::
	new(D, transient_dialog(O, 'Enter formula')),
	message(enter_formula, Purpose),
	send(D, append, label(purpose, Purpose)),
	send(D, append, new(F, text_item(formula, ''))),
	send(D, append,
	     button(ok, message(D, return,
				?(@prolog, make_calculator, F?selection)))),
	send(D, append,
	     button(cancel, message(D, return, @nil))),
	send(D, default_button, ok),
	get(D, confirm_centered, Answer),
	(   Answer == @nil
	->  true
	;   get(O, member, optical_workspace, WS),
	    send(WS, calculator, Answer)
	),
	send(D, destroy).

make_calculator(Text, Calculator) :-
	new(S, string('%s', Text)),
	send(S, strip),
	get(S, value, Value),
	(   Value == ''
	->  Calculator = @nil
	;   new(Calculator, calculator(Text))
	).

hypothesis_editor(O) :->
	"Open/expose the hypothesis editor"::
	(   get(O, hypered, hypothesis_editor, E)
	->  send(E, expose)
	;   new(E, hypothesis_editor),
	    new(_, depto_hyper(O, E, hypothesis_editor, simulator)),
	    send(E, open)
	).

notebook(O) :->
	"Open the notebook"::
	new(E, notebook(O)),
	send(E, transient_for, O),
	send(E, modal, transient),
	send(E, open_centered, O?area?center),
	log(begin(notebook)).


theory_viewer(O) :->
	"View the theory"::
	send(O, text_viewer, theory).


assignment_viewer(O) :->
	"View the assignment"::
	send(O, text_viewer, assignment).

help_viewer(O) :->
	"View the help text"::
	send(O, text_viewer, help).


text_viewer(O, What:name, Wait:wait=[bool]) :->
	"View associated text"::
	send(O, wait),			% ensure it is displayed
	get(O, experiment, Exp),
	(   Exp == @nil
	->  send(O, report, error, 'No experiment')
	;   new(TV, textviewer(What, Exp)),
	    send(TV, transient_for, O),
	    send(TV, modal, transient),
	    send(TV, open_centered, O?area?center),
	    log(begin(view(What))),
	    (	Wait == @on,
		repeat,
		    (	object(TV)
		    ->  send(@display, dispatch),
			fail
		    ;	true
		    )
	    ->	true
	    ;	true
	    )
	).


delete_all(O, Confirm:confirm=[bool], Quick:quick=[bool]) :->
	"Remove all objects"::
	(   Confirm \== @off
	->  message(confirm_delete_all, Message),
	    send(@display, confirm, Message)
	;   true
	),
	(   get(O, hypered, hypothesis_editor, E)
	->  send(E, destroy)
	;   true
	),
	get(O, member, optical_workspace, WS),
	send(WS, clear, @default, Quick).


save(O) :->
	"Save state for later retrieval"::
	new(D, dialog('Save state')),
	send(D, transient_for, O),
	send(D, modal, transient),
	send(D, append, new(TI, text_item(name, ''))),
	send(D, append, new(E,  editor(@default, 40, 10))),
	send(E, label, description?label_name),
	send(D, append,
	     new(OK, button(ok,
			    and(message(O, do_save, TI?selection, E?contents),
				message(D, destroy))))),
	send(D, append, button(cancel, message(D, destroy))),
	send(OK, active, @off),
	send(OK, default_button),
	send(D, open_centered, O?area?center).


state(O, Name:[name], State:scene_state) :<-
	"Fetch the current state"::
	get(O, member, optical_workspace, WS),
	get(WS, state, Name, State).
state(O, State:scene_state*) :->
	"Restore given state"::
	get(O, member, optical_workspace, WS),
	(   State == @nil
	->  send(WS, clear, @on)
	;   send(State, restore, WS)
	).


do_save(O, Name:name, Description:string) :->
	(   Name == ''
	->  send(O, report, error, 'No name'),
	    fail
	;   get(O, state, Name, State),
	    (   send(Description, strip),
		get(Description, size, 0)
	    ->  true
	    ;   send(State, description, Description)
	    ),
	    send(@optica_states, append, State)
	).


restore(O) :->
	"Restore named state"::
	new(B, browser),
	send(new(D, dialog), below, B),
	send(D, append, new(OK, button(ok))),
	send(OK, active, @off),
	send(D, append, button(cancel, message(B, free))),
	send(B, transient_for, O),
	send(B, modal, transient),
	send(B, dict, @optica_states),
	get(O, member, optical_workspace, WS),
	send(B, select_message,	message(OK, active, @on)),
	send(B, open_message, message(OK, execute)),
	send(OK, message,
	     and(message(B?selection?object, restore, WS),
		 message(B, free))),
	send(B, open_centered, O?area?center).
	     

find_object(O, Name:name, Object:graphical) :<-
	"Find named object on workspace"::
	get(O, member, optical_workspace, WS),
	get(WS, member, Name, Object).


quit(O) :->
	(   config(test_moment(experiment)),
	    get(O, experiments, ExpMgr),
	    ExpMgr \== @nil,
	    get(ExpMgr, last_ready_for_test, Exp)
	->  message(quit_and_run_tests, Msg),
	    send(@display, confirm, Msg),
	    send(O, log_quit),
	    send(O, show, @off),
	    send(Exp, run_post_tests),
	    send(O, destroy)
	;   config(test_moment(logout)),
	    get(O, experiments, ExpMgr),
	    ExpMgr \== @nil,
	    config(test_sets(Sets)),
	    member(Set, Sets),
	    get(ExpMgr, ready_for_test, Set, Ready),
	    \+ get(Ready, size, 0)
	->  message(quit_and_run_tests, Msg),
	    (	send(@display, confirm, Msg)
	    ->	send(O, log_quit),
		send(O, show, @off),
		forall(member(S, Sets), send(ExpMgr, run_tests, S)),
		send(O, destroy)
	    ;	true
	    )
	;   message(quit_optica, Msg),
	    (	send(@display, confirm, Msg)
	    ->	send(O, log_quit),
		send(O, destroy)
	    ;   true
	    )
	).
	    
log_quit(O) :->
	get(O, state, State),
	get(O, experiment, Exp),
	state_to_term(State, Term),
	log(quit(Exp, Term)).

:- pce_group(measure).

gauges(O, G:chain) :<-
	"Find the available gauges"::
	get(O, member, optical_workspace, WS),
	get(WS, gauges, G).

gauge(O, Id:name, Var:name, G:object) :<-
	"Find named gauge"::
	get(O, member, optical_workspace, WS),
	get(WS, gauge, Id, Var, G).

:- pce_end_class.


:- pce_begin_class(state_editor, optica, "Used for test editor").
:- pce_end_class.



		 /*******************************
		 *	      WORKSPACE		*
		 *******************************/

:- pce_begin_class(optical_workspace, window,
		   "The real work area").

variable(scale_x,	real,	    get, "1 pixel is 0.05 cm").
variable(scale_y,	real,	    get, "1 pixel is 0.05 cm").
variable(scene_id,	int := 0,   get, "Id for caching Prolog description").
variable(current_ids,	sheet,	    get, "Id for next object").
variable(auto_hide_gauges, bool := @off, both,
					 "Automatically hide the gauges").
variable(auto_switch_off, bool := @off, both,
					 "Automatically switch off lamps").

initialise(P) :->
	send(P, send_super, initialise, size := size(600, 300)),
	send(P, slot, scale_x, 0.05),
	send(P, slot, scale_y, -0.05),
	send(P, slot, current_ids, new(sheet)),
	send(P, display, new(L, line(0, 0, 200, 0))),
	send(P, scroll_to, point(-30, 0)),
	send(L, pen, 3),
	send(L, colour, green),
	send(L, name, bench),
	send(P, resize_message, message(P, resized)),
	send(P, recogniser,
	     click_gesture(left, '', single,
			   message(P, clicked, @event?position))).

bench_y(P, Y:int) :<-
	"Y-coordinate of the bench"::
	get(P, member, bench, B),
	get(B, y, Y).
bench_right(P, R:int) :<-
	"Right-most point of the bench"::
	get(P, member, bench, B),
	get(B, right_side, R).


resized(P) :->
	"Update the line representing the optical workbench"::
	get(P, visible, area(_X, _Y, W, H)),
	get(P, member, bench, Line),
	send(Line, points, 0, 0, W-30, 0),
	send(P, scroll_to, point(-30, -H/2)),
	send(P?graphicals, for_all,
	     if(message(@arg1, has_send_method, window_resized),
		message(@arg1, window_resized))),
	send(P, update).


clear(WS, Force:[bool], Quick:[bool]) :->
	"Clear, but don't touch the optical bench"::
	(   (   Quick == @on
	    ;	get(WS, displayed, @off)
	    )
	->  send(WS?graphicals, for_some,
		 if(message(@arg1, instance_of, optical_instrument),
		    message(@arg1, destroy)))
	;   send(WS?graphicals, for_some,
		 if(message(@arg1, instance_of, optical_instrument),
		    message(@arg1, delete, Force))),
	    send(WS, wait_delete)
	).

wait_delete(WS) :->
	"Wait till deletion is finished"::
	(   get(WS, displayed, @on),
	    get(WS, frame, Frame)
	->  send(Frame, busy_cursor, block_input := @on),
	    repeat,
	    (   get(WS, find, @default,
		    message(@arg1, instance_of, snapper), _)
	    ->  send(@display, dispatch),
		fail
	    ;   send(Frame, busy_cursor, @nil)
	    )
	;   true
	).

state(P, Name:[name], Scene:scene_state) :<-
	"Describe the entire scene into the given object"::
	default(Name, state, TheName),
	new(Scene, scene_state(TheName)),
	send(Scene, snap, P).


clicked(P, Pos:point) :->
	"User has clicked at point"::
	get(P, frame, Tool),
	get(Tool, instrument, Instrument),
	(   instrument_config(Instrument, cardinality(_Low, High)),
	    High \== inf
	->  get(P?graphicals, find_all,
		and(message(@arg1, instance_of, optical_instrument),
		    @arg1?instrument_name == Instrument),
		Instances),
	    get(Instances, size, Count),
	    (	Count + 1 =< High
	    ->  true
	    ;   send(P, error, max_instruments, High),
		fail
	    )
	;   true
	),
	(   config(instrument(Instrument, IOptions, _)),
	    memberchk(class(Class), IOptions),
	    send(class(Class), is_a, lens),
	    get(Tool, experiment, Exp),
	    config(experiment(Exp, ExpOptions)),
	    memberchk(max_lenses(ML), ExpOptions)
	->  get(P?graphicals, find_all,
		message(@arg1, instance_of, lens),
		Lenses),
	    get(Lenses, size, LCount),
	    (	LCount + 1 =< ML
	    ->  true
	    ;   send(P, error, max_instruments, ML),
		fail
	    )
	;   true
	),
	send(@optical_workspace, assign, P),
	new_instrument(Instrument, Type, Gr),
	get(P, next_id, Type, Id),
	send(Gr, name, Id),
	send(Gr, position, Pos),
	send(P, display, Gr),
	send(Gr, adjust),
	(   config(auto_switch_on(true))
	->  SwitchOff = @off
	;   type_to_auto_switch(Type, SwitchOff)
	),
	send(P, update, @on, SwitchOff),
	(   send(Gr, has_send_method, show_value)
	->  send(Gr, show_value, @on)
	;   true
	),
	log(add(term(Gr))).

new_instrument(Name, Type, Instrument) :-
	config(instrument(Name, Options, Attributes)), !,
	memberchk(class(Class), Options),
	defaults(Attributes, Defaults),
	make_instrument(Class, Defaults, Instrument),
	class_to_type(Class, Type),
	send(Instrument, slot, instrument_name, Name).
new_instrument(Name, Type, Instrument) :-
	generic_instrument(Name, NewTerm),
	new(Instrument, NewTerm),
	functor(NewTerm, Class, _),
	class_to_type(Class, Type),
	send(Instrument, slot, instrument_name, Name).
	
defaults([], []).
defaults([attribute(Name, Options)|TA], [Name=Value|TD]) :-
	memberchk(default(Value), Options), !,
	defaults(TA, TD).
defaults([_|TA], D) :-
	defaults(TA, D).

generic_instrument(lens,       lens(5, 5, 0.1)).
generic_instrument(lamp1,      lamp1).
generic_instrument(biglamp,    biglamp).
generic_instrument(lamp3,      lamp3).
generic_instrument(parlamp,    parlamp).
generic_instrument(consline,   construction_line).
generic_instrument(hconsline,  construction_line(horizontal)).
generic_instrument(shield,     shield).
generic_instrument(shield2,    shield2).
generic_instrument(eye,	       eye).

type_id(lens,              m).
type_id(lamp1,             l).
type_id(biglamp,	   l).
type_id(construction_line, c).
type_id(shield,            s).
type_id(eye,               e).

type_to_auto_switch(c, @off) :- !.
type_to_auto_switch(e, @off) :- !.
type_to_auto_switch(_, @on).

class_to_type(ClassName, Type) :-
	type_id(ClassName, Type), !.
class_to_type(ClassName, Type) :-
	get(class(ClassName), super_class_name, Super),
	class_to_type(Super, Type).

next_scene(P) :->
	"Increment the scene id"::
	get(P, scene_id, Id),
	NId is Id + 1,
	send(P, slot, scene_id, NId).


next_id(P, Type:name, Id:name) :<-
	"Generate an identifier for a type"::
	get(P, current_ids, Sheet),
	(   get(Sheet, value, Type, Current)
	->  IDN is Current + 1
	;   IDN is 1
	),
	send(Sheet, value, Type, IDN),
	atom_concat(Type, IDN, Id).
	

update(P, SceneModified:[bool], CheckAutoSwitchOff:[bool]) :->
	"Update objects that can be updated"::
	(   SceneModified \== @off
	->  send(P, next_scene)
	;   true
	),
	(   CheckAutoSwitchOff \== @off,
	    get(P, auto_switch_off, @on)
	->  send(P, switch, @off)
	;   true
	),
	send(P?graphicals, for_some,
	     if(message(@arg1, has_send_method, update),
		message(@arg1, update))).

switch(P, Val:bool) :->
	"Switch the light-sources on/off"::
	send(P?graphicals, for_all,
	     if(message(@arg1, has_send_method, switch),
		message(@arg1, switch, Val))).

auto_switch_on(P) :->
	"->switch: @on if configured"::
	(   config(auto_switch_on(true))
	->  send(P, switch, @on)
	;   true
	).

:- pce_group(measure).

restore_gauges(P, Val:[bool]) :->
	"Activate all gauges"::
	default(Val, @on, Show),
	\+ get(P, find, @default,
	       and(message(@arg1, instance_of, gauge_text),
		   message(@arg1, show_value, Show),
		   new(or)),
	       _).

show_gauges(P) :->
	"User pressed the show-gauges button"::
	send(P, restore_gauges, @on),
	get_chain(P, gauges, Gauges),
	gauge_values(Gauges, Values),
	log(measured(Values)).

gauge_values([], []).
gauge_values([H|T0], [G|T]) :-
	get(H, value, V),
	get(H, name, Id), !,
	G =.. [Id,V],
	gauge_values(T0, T).
gauge_values([_|T0], T) :-
	gauge_values(T0, T).

gauges(P, G:chain) :<-
	"Find all gauges"::
	get(P?graphicals, find_all,
	    and(message(@arg1, has_send_method, is_variable),
		message(@arg1, is_variable)),
	    G).

gauge(P, Id:[name], Var:name, G:object) :<-
	"Find gauge from id and name"::
	HasVarname = message(@arg1, has_get_method, varname),
	(   Id == @default
	->  get(P, find, @default, and(HasVarname, @arg1?varname == Var), G)
	;   member(C, [and(HasVarname, @arg1?name == Id, @arg1?varname == Var),
		       and(HasVarname, @arg1?varname == Var)
		      ]),
	    get(P, find, @default, C, G)
	).

renamed_gauge(P, Gauge:object) :->
	"Gauge has been assigned a name"::
	(   get(P?frame, hypered, hypothesis_editor, HE)
	->  send(HE, renamed_gauge, Gauge)
	;   true
	).

calculator(P, Calc:graphical) :->
	"Display a formula at a sensible location"::
	(   get(P?graphicals, find_all,
		message(@arg1, instance_of, calculator),
		Old),
	    \+ get(Old, size, 0)	% align below old
	->  chain_list(Old, OldChain),
	    lowest(OldChain, C, Y),
	    get(C, height, CH),
	    get(C, reference_x, X),
	    send(Calc, reference_x, X),
	    send(Calc, y, Y+CH)
	;   get(P, visible, area(X,Y,W,_)),
	    get(Calc, size, size(CW, _)),
	    send(Calc, set, X+W-CW-20, Y)
	),
	get(P, next_id, h, Name),
	send(Calc, name, Name),
	send(P, display, Calc),
	send(Calc, update),
	send(Calc, show_value, @on),
	log(add(term(Calc))).

lowest([C], C, Y) :- !,
	get(C, y, Y).
lowest([C1|T], C, Y) :-
	lowest(T, C0, Y0),
	get(C1, y, Y1),
	(   Y1 > Y0
	->  C = C1, Y = Y1
	;   C = C0, Y = Y0
	).

:- pce_end_class.

		 /*******************************
		 *	     NOTE STATE		*
		 *******************************/

:- pce_begin_class(note_state, optical_workspace,
		   "Window for in a note").

initialise(NS) :->
	send(NS, send_super, initialise),
	send(NS, size, size(500, 150)),
	send(NS, slot, scale_x, 0.1),
	send(NS, slot, scale_y, -0.1).

:- pce_end_class.

:- pce_begin_class(test_state, optical_workspace,
		   "Window for in test").

initialise(TS) :->
	send(TS, send_super, initialise),
	(   config(test_scale(Scale))
	->  true
	;   Scale = 0.75
	),
	ScaleX is 0.05 / Scale,
	ScaleY is -ScaleX,
	WinW is round(800 * Scale),
	WinH is round(300 * Scale),
	send(TS, slot, scale_x, ScaleX),
	send(TS, slot, scale_y, ScaleY),
	send(TS, size, size(WinW, WinH)).

:- pce_end_class.

:- pce_begin_class(test_thumb, optical_workspace,
		   "Window as thumbnail for test editor").

initialise(TS, Size:[size]) :->
	send(TS, send_super, initialise),
	send(TS, slot, scale_x, 0.3),
	send(TS, slot, scale_y, -0.3),
	(   Size \== @default
	->  send(TS, size, Size)
	;   true
	).

:- pce_end_class.


		 /*******************************
		 *	      GESTURES		*
		 *******************************/

:- pce_begin_class(move_on_bench_gesture, move_gesture,
		   "Move, keep bench and notify").

variable(min_x,		int := 0,	get,	"Minumum X-value").
variable(max_x,		int := 1000,	get,	"Maximum Y-value").

verify(G, Ev:event) :->
	send(G, send_super, verify, Ev),
	get(Ev, receiver, Gr),
	get(Gr, read_only, @off),
	get(Ev?window?frame, instrument, I),
	(   I == move
	;   I == xmove
	).

initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(Ev?window, visible, area(X, _, W, _)),
	send(G, slot, min_x, X),
	send(G, slot, max_x, X+W),
	get(Ev, receiver, Gr),
	get(Gr, name, Id),
	log(begin(move(Id, x))).

drag(G, Ev:event) :->
	"Move along bench, and report position"::
	get(Ev, receiver, Gr),
	get(Gr, device, Dev),
	get(Ev, x, Dev, X),
	get(G?offset, x, OX),
	get(Gr, x, GrX),
	get(Gr?area, x, AreaX),    
	NX0 is max(X - OX, AreaX-GrX),
	get(Gr, width, W),
	get(G, min_x, MinX),
	get(G, max_x, MaxX),
	NX is min(max(MinX, NX0), MaxX-W),
	send(Gr, set, NX),
	(   send(Gr, instance_of, collidable_optical_instrument)
	->  send(Gr, check_collision)
	;   true
	),
	send(Gr, dragged),
	get(Gr, pos_x, PosX),
	log(drag(PosX)).

terminate(_, Ev:event) :->
	get(Ev, receiver, Gr),
	(   send(Gr, has_send_method, move_to_valid_place)
	->  send(Gr, move_to_valid_place)
	;   true
	),
	send(Gr, notify_moved),
	log(end),
	send(Gr?window, auto_switch_on).

:- pce_end_class.

:- pce_begin_class(move_y_gesture, move_gesture,
		   "Keep X and notify").

variable(domain,		tuple*,	get, 	"Range we can move").

verify(G, Ev:event) :->
	send(G, send_super, verify, Ev),
	get(Ev, receiver, Gr),
	get(Gr, read_only, @off),
	get(Ev?window?frame, instrument, I),
	(   I == move
	;   I == ymove
	),
	(   send(Gr, has_get_method, y_domain),
	    get(Gr, y_domain, Domain),
	    \+ object(Domain, tuple(Y,Y))
	->  send(G, slot, domain, Domain)
	;   send(G, slot, domain, @nil)
	).


initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(Ev, receiver, Gr),
	get(Gr, name, Id),
	log(begin(move(Id, y))).


drag(G, Ev:event) :->
	"Move along bench, and report position"::
	get(Ev, receiver, Gr),
	get(Gr, device, Dev),
	get(Ev, y, Dev, Y),
	get(G?offset, y, OY),
	NY0 is Y - OY,
	(   get(G, domain, tuple(Ya, Yz)),
	    scale(Gr, _, ScaleY),
	    PYa is round(Ya/ScaleY),	% move to ->verify?
	    PYz is round(Yz/ScaleY),
	    NY is min(max(NY0, PYa), PYz)
	;   NY is NY0
	),
	send(Gr, set, y := NY),
	send(Gr, dragged),
	get(Gr, pos_y, PosY),
	log(drag(PosY)).


terminate(_, Ev:event) :->
	get(Ev, receiver, Gr),
	send(Gr, notify_moved),
	log(end),
	send(Gr?window, auto_switch_on).

:- pce_end_class.


:- pce_begin_class(move_xy_gesture, move_gesture,
		   "Move both/x/y and notify").

variable(mode,	{x,y,xy} := xy,	get, "Current mode of operation").
variable(area,	area,		get, "Contained area").

verify(G, Ev:event) :->
	send(G, send_super, verify, Ev),
	get(Ev, receiver, Gr),
	get(Gr, read_only, @off),
	get(Ev?window?frame, instrument, I),
	xy_mode(I, Mode),
	send(G, slot, mode, Mode).

xy_mode(move, xy).
xy_mode(xmove, x).
xy_mode(ymove, y).

restrict(G, OI:graphical) :->
	"Restrict area according to config"::
	(   send(OI, instance_of, optical_instrument),
	    get(OI, instrument_name, I),
	    config(instrument(I, _Options, Attributes))
	->  get(G, area, Area),
	    scale(OI, ScaleX, ScaleY),
	    restrict_domain(ScaleX, pos_x, Attributes, Xa, Xz),
	    restrict_domain(ScaleY, pos_y, Attributes, Ya, Yz),
	    get(OI, position, point(PX, PY)),
	    get(OI?area, position, point(APX, APY)),
	    DX is PX-APX,
	    DY is PY-APY,
	    send(Area, intersection, area(Xa-DX, Ya-DY, Xz-Xa, Yz-Ya))
	;   true
	).

restrict_domain(Scale, PosXY, Attributes, A, Z) :-
	memberchk(attribute(PosXY, Props), Attributes),
	(   memberchk(edit(range(A0-Z0)), Props)
	;   memberchk(range(A0-Z0), Props)
	;   memberchk(default(A0), Props), 	% i.e. no range/edit!
	    Z0 = A0
	), !,
	A is round(A0/Scale),
	Z is round(Z0/Scale).
restrict_domain(_, _, _, -1000000, 1000000).    % HACK!
	
initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(Ev, receiver, Gr),
	get(Ev, window, Window),
	get(Window, visible, area(VX, VY, VW, VH)),
	get(Gr, size, size(GrW, GrH)),
	send(G, slot, area, area(VX, VY, VW-GrW, VH-GrH)),
	send(G, restrict, Gr),
	get(Gr, name, Id),
	get(G, mode, Mode),
	(   Mode == x
	->  get(Gr, pos_x, P0)
	;   Mode == y
	->  get(Gr, pos_y, P0)
	;   get(Gr, pos_x, Px0),
	    get(Gr, pos_y, Py0),
	    P0 = point(Px0, Py0)
	),
	log(begin(move(Id, Mode, P0))).

drag(G, Ev:event) :->
	"Move along bench, and report position"::
	get(Ev, receiver, Gr),
	get(Gr, device, Dev),
	get(G, mode, Mode),
	get(G, area, area(AX, AY, AW, AH)),
	(   Mode == y
	->  get(Ev, y, Dev, Y),
	    get(G?offset, y, OY),
	    NY0 is Y - OY,
	    NY is max(AY, min(AY+AH, NY0)),
	    send(Gr, set, y := NY),
	    send(Gr, dragged),
	    get(Gr, pos_y, PosY),
	    log(drag(PosY))
	;   Mode == x
	->  get(Ev, x, Dev, X),
	    get(G?offset, x, OX),
	    NX0 is X - OX,
	    NX is max(AX, min(AX+AW, NX0)),
	    send(Gr, set, NX),
	    send(Gr, dragged),
	    get(Gr, pos_x, PosX),
	    log(drag(PosX))
	;   get(Ev, x, Dev, X),
	    get(Ev, y, Dev, Y),
	    get(G, offset, point(OX, OY)),
	    NX0 is X - OX,
	    NY0 is Y - OY,
	    NX is max(AX, min(AX+AW, NX0)),
	    NY is max(AY, min(AY+AH, NY0)),
	    send(Gr, set, NX, NY),
	    send(Gr, dragged),
	    get(Gr, pos_x, PosX),
	    get(Gr, pos_y, PosY),
	    log(drag(PosX, PosY))
	).

terminate(_, Ev:event) :->
	get(Ev, receiver, Gr),
	send(Gr, notify_moved),
	log(end),
	send(Gr?window, auto_switch_on).

:- pce_end_class.


		 /*******************************
		 *	    CENTERLINE		*
		 *******************************/

:- pce_begin_class(centerline, line,
		   "Line for measuring distances").

:- pce_global(@rule_gesture,
	      new(ruler_gesture(left, '', @rule_link))).

variable(orientation,	{horizontal,vertical},	get, "Direction").

initialise(CL, Orientation:[{horizontal,vertical}]) :->
	default(Orientation, vertical, O),
	send(CL, slot, orientation, O),
	send(CL, send_super, initialise),
	send(CL, texture, dashdotted),
	send(CL, colour, steel_blue),
	send(CL, stretch).

stretch(CL) :->
	"Update start/length"::
	scale(CL, _ScaleX, ScaleY),
	(   get(CL, orientation, vertical)
	->  H is round(10/ScaleY),
	    X = 0,
	    send(CL, points, X, H, X, -H)
	;   (   get(CL?window, visible, V)
	    ->	L = 0, % get(V, x, L),
		get(V, width, R)
	    ;	L = 0,
		R = 500
	    ),
	    Y = 0,
	    send(CL, points, L, Y, R, Y)
	).

event(_CL, Ev:event) :->
	send(@rule_gesture, event, Ev).

:- pce_end_class.


		 /*******************************
		 *	CONSTRUCTION-LINE	*
		 *******************************/

:- pce_begin_class(construction_line(orientation, value), optical_instrument,
		   "Line to help measure distances").

:- instrument_state([orientation, value]).

initialise(CL, Orientation:[{horizontal,vertical}], Value:[real]) :->
	send(CL, send_super, initialise),
	send(CL, display, centerline(Orientation)),
	(   Value \== @default
	->  send(CL, value, Value)
	;   true
	).

orientation(CL, O:{horizontal,vertical}) :<-
	"Horizontal/vertical orientation of the line"::
	get(CL, member, centerline, L),
	get(L, orientation, O).

state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

value(L, Value:real) :->
	(   get(L, orientation, vertical)
	->  send(L, pos_x, Value)
	;   send(L, pos_y, Value)
	).
value(L, Value:real) :<-
	(   get(L, orientation, vertical)
	->  get(L, pos_x, Value)
	;   get(L, pos_y, Value)
	).

tool(L) :->
	"Edit using toolset"::
	(   get(L, orientation, vertical)
	->  Range = type(on_bar)
	;   Range = type(real_range(-10, 10, cm, '%.2f'))
	),
	apply_tool(L,
		   [ value(Range)
		   ]).

adjust(L) :->
	"Position the graphical on the bench"::
	(   get(L, orientation, vertical)
	->  (   get(L, x, X),
	        X < 0
	    ->  send(L, x, 0)
	    ;   true
	    ),
	    send(L, adjust_to_bench)
	;   (   get(L?window, visible, V)
	    ->	Left = 0, %get(V, left_side, Left),
		get(V, right_side, Right)
	    ;	Left = 0,
		Right = 500
	    ),
	    send(L, x, Left),
	    get(L, member, centerline, CL),
	    send(CL, points, 0, @default, Right-Left, @default)
	).

window_resized(L) :->
	"Called if window has resized"::
	get(L, member, centerline, CL),
	send(CL, stretch).


:- pce_global(@construction_line_recogniser,
	      make_construction_line_recogniser).

make_construction_line_recogniser(R) :-
	new(MY, move_y_gesture(left)),
	new(MX, move_on_bench_gesture(left)),
	send(MX, condition, @event?receiver?orientation == vertical),
	send(MY, condition, @event?receiver?orientation == horizontal),
	new(R, handler_group(@optical_instrument_click_recogniser,
			     MX, MY)).

event(L, Ev:event) :->
	(   send(L, send_super, event, Ev)
	;   send(@construction_line_recogniser, event, Ev)
	).

dragged(L) :->
	send(L?window, update, @off, @off).

:- pce_end_class.


		 /*******************************
		 *	   OPTICAL DEVICE	*
		 *******************************/

:- pce_global(@optical_instrument_click_recogniser,
	      make_optical_instrument_click_recogniser).

make_optical_instrument_click_recogniser(G) :-
	new(C1, click_gesture(left, '', single,
			      message(@receiver, clicked))),
	new(C2, click_gesture(left, '', double,
			      message(@receiver, tool))),
	new(Cond, ?(@event?receiver, find, @event) \== @event?receiver),
	send_list([C1,C2], condition, Cond),
	new(G, handler_group(C1, C2)).

:- pce_global(@bench_instrument_recogniser,
	      make_bench_instrument_recogniser).

make_bench_instrument_recogniser(G) :-
	new(M, move_on_bench_gesture(left)),
	new(Cond, ?(@event?receiver, find, @event) \== @event?receiver),
	send(M, condition, Cond),
	new(G, handler_group(@optical_instrument_click_recogniser, M)).

:- pce_begin_class(optical_instrument, device,
		   "Generic movable optical device").

variable(valid,		  bool := @on,  get,  "Valid/invalid position").
variable(instrument_name, name,         get,  "Name of the instrument").
variable(read_only,	  bool := @off, both, "May be modified").


y_domain(OI, Range:tuple) :<-
	"Get min/maximal Y according to config"::
	get(OI, instrument_name, I),
	config(instrument(I, _Options, Attributes)), !,
	memberchk(attribute(pos_x, Props), Attributes),
	(   memberchk(edit(range(Xa-Xz)), Props)
	;   memberchk(range(Xa-Xz), Props)
	;   memberchk(default(Xa), Props), 	% i.e. no range/edit!
	    Xz = Xa
	), !,
	new(Range, tuple(Xa, Xz)).

adjust_to_bench(OI) :->
	(   get(OI, device, D), D \== @nil,
	    get(D, bench_y, Y)
	->  send(OI, y, Y)
	;   true
	),
	(   get(OI, x, X),
	    X < 0
	->  send(OI, x, 0)
	;   true
	).

adjust_location(OI) :->
	"Adjust to fit within configured location range"::
	get(OI, instrument_name, I),
	config(instrument(I, _Options, Attributes)), !,
	ensure_pos_in_range(OI, pos_x, Attributes),
	ensure_pos_in_range(OI, pos_y, Attributes).

ensure_pos_in_range(OI, XY, Attributes) :-
	(   memberchk(attribute(XY, Props), Attributes)
	->  (   (   memberchk(edit(range(Xa, Xz)), Props)
		;   memberchk(range(Xa, Xz), Props)
		;   memberchk(default(Xa), Props), 	% i.e. no range/edit!
		    Xz = Xa
		)
	    ->	get(OI, XY, X0),
		X1 is min(max(X0, Xa), Xz),
		(   X1 =\= X0
		->  send(OI, XY, X1)
		;   true
		)
	    ;	true
	    )
	;   true
	).

adjust(OI) :->
	"Adjust instrument to satisfy conditions after it has been added"::
	send(OI, adjust_location).

notify_moved(_OI) :-> true.
dragged(_OI) :-> true.
tool(_OI) :-> fail.

report_current_x(OI) :->
	"Report the current X-location"::
	get(OI, window, Window),
	get(Window, scale_x, Scale),
	get(OI, x, GrX),
	RealX is GrX * Scale,
	send(Window, report, status, 'X = %.1f cm', RealX).


clicked(OI) :->
	get(OI, read_only, @off),
	get(OI, name, Id),
	(   get(OI?frame, instrument, delete)
	->  send(OI, delete),
	    log(delete(Id))
	;   get(OI?frame, instrument, tool)
	->  send(OI, tool)
	).

delete(OI, Forced:[bool]) :->
	"Just drop from the window"::
	(   get(OI, read_only, @off)
	;   Forced == @on
	),
	send(new(snapper), delete, OI).

pos_x(OI, X:real) :->
	scale(OI, ScaleX, _),
	PX is round(X/ScaleX),
	send(OI, x, PX),
	(   get(OI, window, Window)
	->  send(Window, update)
	;   true
	).
pos_x(OI, X:real) :<-
	scale(OI, ScaleX, _),
	get(OI, x, PX),
	X is float(PX*ScaleX).

pos_y(OI, Y:real) :->
	scale(OI, _, ScaleY),
	PY is round(Y/ScaleY),
	send(OI, y, PY),
	(   get(OI, window, Window)
	->  send(Window, update)
	;   true
	).
pos_y(OI, Y:real) :<-
	scale(OI, _, ScaleY),
	get(OI, y, PY),
	Y is float(PY*ScaleY).

:- pce_end_class.


:- pce_begin_class(collidable_optical_instrument, optical_instrument,
		   "Optical instruments that cannot be at the same place").

adjust(Gr) :->
	send(Gr, adjust_to_bench),	% place on bench
	send(Gr, adjust_location),	% ensure within range
	(   get(Gr?device?graphicals, find, message(Gr, collide, @arg1), _)
	->  send(Gr, slot, valid, @off),
	    send(Gr, move_to_valid_place)
	;   true
	).

collide(L, L2:graphical) :->
	"Succeeds if two instruments occupy the same space"::
	\+ send(L2, same_reference, L),
	send(L2, instance_of, collidable_optical_instrument),
	send(L, overlap, L2),
	get(L, left_side, LL1),
	get(L, right_side, RL1),
	get(L2, left_side, LL2),
	get(L2, right_side, RL2),
	\+ (LL2 >= RL1 ; LL1 >= RL2).

check_collision(L) :->
	"(In)validate object if it collides with another"::
	get(L, device, Dev),
	(   get(Dev?graphicals, find, message(L, collide, @arg1), _)
	->  send(L, valid, @off)
	;   send(L, valid, @on)
	).

move_to_valid_place(Gr) :->
	"Move graphical to a place where there is room"::
	move_to_valid_place(Gr).

%	move_to_valid_place(Gr)
%
%	Move to a place where we do not collide with any other graphical.

move_to_valid_place(Gr) :-
	get(Gr, valid, @on), !.
move_to_valid_place(Gr) :-
	move_required(Gr, right, DRight),
	move_required(Gr, left,  DLeft),
	(   DRight > -DLeft,
	    get(Gr, x, X),
	    X + DLeft > 0
	->  send(Gr, relative_move, point(DLeft, 0))
	;   send(Gr, relative_move, point(DRight, 0))
	),
	send(Gr, valid, @on),
	send(Gr, dragged),
	get(Gr, pos_x, PosX),
	log(repositioned(PosX)).

move_required(Gr, Dir, Distance) :-
	get(Gr, x, X0),
	move_required(Gr, Dir, 0, Distance),
	send(Gr, x, X0).

move_required(Gr, Dir, Moved, Distance) :-
	get(Gr?device?graphicals, find, message(Gr, collide, @arg1), Gr2), !,
	(   Dir == right
	->  get(Gr2, right_side, RS),
	    get(Gr, left_side, LS)
	;   get(Gr2, left_side, RS),
	    get(Gr, right_side, LS)
	),
	Move is RS - LS,
	send(Gr, relative_move, point(Move, 0)),
	Moved1 is Moved + Move,
	move_required(Gr, Dir, Moved1, Distance).
move_required(_, _, Distance, Distance).

:- pce_end_class.


		 /*******************************
		 *		LENS		*
		 *******************************/

focal_distance_to_sfere(@default, _Radius, 5) :- !.
focal_distance_to_sfere(FD, _Radius, Sfere) :-
	Sfere is 1.0/FD.

:- pce_begin_class(lens(focal_distance, radius, thickness, pos_x),
		   collidable_optical_instrument,
		   "The usual lens").
:- use_class_template(gauge).

variable(radius,	 real,		    get, "Size of the lens").
variable(thickness,	 real,   	    get, "Thickness at the edge").
variable(focal_distance, [real], 	    get, "Focal distance of lens").
variable(sfere_left,	 '[-100.0..100.0]', get, "Sfere at the left side").
variable(sfere_right,	 '[-100.0..100.0]', get, "Sfere at the right side").
variable(breaking_index, real,   	    get, "The breaking index").
variable(show_gauge,	 bool := @on,	    get, "Show/unshow the gauge").

initialise(L, FocalD:[real], Radius:[real], Thickness:[real], PosX:[real]) :->
	"Initialise the lens"::
	default(Radius, 5, TheRadius),
	default(Thickness, 0, TheThickness),
	send(L, send_super, initialise),
	send(L, name, f),
	send(L, slot, breaking_index, 1.51),
	send(L, slot, sfere_left, @default),
	send(L, slot, sfere_right, @default),
	send(L, slot, radius, TheRadius),
	send(L, slot, thickness, TheThickness),
	send(L, display, new(L1, line)),
	send(L, display, new(L2, line)),
	send(L, display, new(A1, arc)),
	send(L, display, new(A2, arc)),
	send(L, display, new(centerline)),
	send(L, display, new(T, gauge_text)),
	send(T, sensitive, @on),
	send(T, center_x, 0),
	send(T, unit, cm),
	send(L1, name, top),
	send(L2, name, bottom),
	send(A1, name, left),
	send(A2, name, right),
	set_parameter(L, focal_distance, FocalD, false),
	send(L, request_compute),
	(   PosX == @default
	->  true
	;   send(L, pos_x, PosX)
	).

:- instrument_state([ label,
		      radius,
		      thickness,
		      focal_distance,
		      sfere_left,
		      sfere_right,
		      breaking_index,
		      pos_x,
		      show_gauge,
		      varname
		    ]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	apply_tool(L,
		   [ label(type(label)),
		     radius(type(real_range(0.5, 10, cm, '%.1f'))),
		     sfere_left(label(image('lsfere.lbl')),
				type(real_range([-100, 100],
						'%', '%g'))),
		     sfere_right(label(image('rsfere.lbl')),
				 type(real_range([-100, 100],
						 '%', '%g'))),
		     thickness(type(real_range(0, 5, cm, '%.1f'))),
		     breaking_index(label(image('breakidx.lbl')),
				    type(real_range(0.5, 5, '', '%.2f'))),
		     focal_distance(type(real_range([-20,20], cm, '%.1f'))),
		     show_gauge(label(image('fdgauge.lbl')),
				type(bool)),
		     pos_x(type(on_bar))
		   ]).

set_if_default(Obj, Att, V) :-
	get(Obj, Att, @default), !,
	send(Obj, Att, V).
set_if_default(_, _, _).


focal_distance(L, FD:[real]) :->
	(   get(L, focal_distance, FD)
	->  true
	;   (   FD == @default
	    ->  set_if_default(L, sfere_left, 10),
		set_if_default(L, sfere_right, 10)
	    ;	(   abs(FD) < 1
		->  send(L, error, min_focal_distance, 1),
		    fail
		;   true
		)
	    ),
	    set_parameter(L, focal_distance, FD, true)
	).


set_parameter(Obj, Parm, Value, _) :-
	get(Obj, Parm, Value).
set_parameter(Obj, Parm, Value, true) :- !,
	send(Obj, slot, Parm, Value),
	send(Obj, request_compute),
	(   get(Obj, device, Dev), Dev \== @nil
	->  send(Dev, update)
	;   true
	).
set_parameter(Obj, Parm, Value, _) :-
	send(Obj, slot, Parm, Value),
	send(Obj, request_compute).

radius(L, Radius:real) :->
	set_parameter(L, radius, Radius, true).
thickness(L, Thickness:real) :->
	set_parameter(L, thickness, Thickness, true).
name(L, Name:name) :->
	set_parameter(L, name, Name, false).
breaking_index(L, BI:real) :->
	set_parameter(L, breaking_index, BI, true).
sfere_left(L, SL:[real]) :->
	set_parameter(L, sfere_left, SL, true).
sfere_right(L, SR:[real]) :->
	set_parameter(L, sfere_right, SR, true).
valid(L, V:bool) :->
	set_parameter(L, valid, V, false).
show_gauge(L, V:bool) :->
	set_parameter(L, show_gauge, V, false).
	

left_side(L, Left:int) :<-
	"Left-side of sfere"::
	get(L, x, X),
	get(L, member, left, LeftSfere),
	get(LeftSfere, left_side, LX),
	Left is X + LX.
right_side(L, Right:int) :<-
	"Right-side of sfere"::
	get(L, x, X),
	get(L, member, right, RightSfere),
	get(RightSfere, right_side, RX),
	Right is X + RX.

place_arc(L, Which, X, Y1, Y2, DX) :-
	DX =\= 0, !,
	get(L, member, Which, Arc0),
	(   send(Arc0, instance_of, arc)
	->  Arc = Arc0
	;   free(Arc0),
	    send(L, display, new(Arc, arc)),
	    send(Arc, name, Which)
	),
	send(Arc, points, X, Y1, X, Y2, DX).
place_arc(L, Which, X, Y1, Y2, _) :-
	get(L, member, Which, Line0),
	(   send(Line0, instance_of, line)
	->  Line = Line0
	;   free(Line0),
	    send(L, display, new(Line, line)),
	    send(Line, name, Which)
	),
	send(Line, points, X, Y1, X, Y2).

fix_valid_appearance(L) :-
	(   get(L, valid, @on)
	->  send(L, colour, @default)
	;   send(L, colour, red)
	).

compute(L) :->
	"Update the size and places of all parts"::
	fix_valid_appearance(L),
	scale(L, ScaleX, ScaleY),
	get(L, radius, R),
	PR is round(R/ScaleY),
	get(L, focal_distance, FD),
	(   get(L, sfere_left,  RSLP), number(RSLP),
	    get(L, sfere_right, RSRP), number(RSRP)
	->  RSL is RSLP * R / 100,
	    RSR is RSRP * R / 100
	;   focal_distance_to_sfere(FD, R, RSR),
	    RSL is RSR
	),
	get(L, thickness, T0),
	SL is round(-RSL/ScaleX),
	SR is round(RSR/ScaleX),
	T1 is round(T0/ScaleX),
	(   DT is SR-SL,		% amount middle is thicker
	    DT < 0
	->  T is T1 - DT
	;   T = T1
	),
	LLX is -T//2, LRX is -LLX,	% line-left-x, line-right-x
	L1Y is PR, L2Y is -L1Y,
	get(L, member, top,    L1),
	get(L, member, bottom, L2),
	get(L, member, gauge_text, Text),
	send(L1, points, LLX, L1Y, LRX, L1Y), % place the lines
	send(L2, points, LLX, L2Y, LRX, L2Y),
	place_arc(L, left,  LLX, L1Y, L2Y, SL),
	place_arc(L, right, LRX, L1Y, L2Y, SR),
	(   FD \== @default,
	    get(L, show_gauge, @on)
	->  send(Text, value, FD),
	    send(Text, y, L2Y + 5),
	    send(Text, displayed, @on)
	;   send(Text, displayed, @off)
	),
	(   get(L, member, name_text, Txt)
	->  get(Txt, height, H),
	    TxtY is L1Y - H - 2,
	    send(Txt, y, TxtY)
	;   true
	),
	send(L, send_super, compute).
/*	causes recursive behaviour from scene_parms on <-x.  Why is this
	needed anyway?
	(   get(L, device, Dev),
	    Dev \== @nil
	->  send(Dev, update)
	;   true
	).
*/


label(L, Name:name) :->
	"Name of the lens"::
	(   Name == ''
	->  (   get(L, member, name_text, T)
	    ->	free(T)
	    ;	true
	    )
	;   (   get(L, member, name_text, T)
	    ->	send(T, string, Name)
	    ;	send(L, display, new(T, text(Name, center, huge))),
		send(T, name, name_text),
		send(T, center_x, 0)
	    )
	),
	send(L, request_compute).
label(L, Name:name) :<-
	"Name of the lens"::
	(   get(L, member, name_text, T)
	->  get(T, string, S),
	    get(S, value, Name)
	;   Name = ''
	).

circle(L, Which:{left,right}, Parms:tuple) :<-
	"Find center and radius of one of the sferes"::
	(   get(L, request_compute, @nil)
	->  true
	;   send(L, compute)
	),
	(   Which == left
	->  get(L, member, left, A)
	;   get(L, member, right, A)
	),
	send(A, instance_of, arc),
	get(L, position, PL),
	get(A, position, PA),
	get(A, size, size(R, _)),
	get(PA, plus, PL, Center),
	new(Parms, tuple(Center, R)).


dragged(L) :->
	"User is dragging the lens"::
	send(L?window, update).


event(L, Ev:event) :->
	(   send(L, send_super, event, Ev)
	;   send(@bench_instrument_recogniser, event, Ev)
	).


:- pce_group(gauge).

value(L, FD:real) :<-
	get(L, focal_distance, FD).

:- pce_end_class.

		 /*******************************
		 *	    LIGHT BEAM		*
		 *******************************/

:- pce_begin_class(beam, path, "A light beam").

variable(segment_angles,	chain,	get, "Chain holding the angles").

initialise(B) :->
	send(B, send_super, initialise),
	send(B, slot, segment_angles, new(chain)).

clear(B) :->
	"Clear points and segment angles"::
	send(B, send_super, clear),
	get(B, segment_angles, Chain),
	send(Chain, clear).

append(B, Pt:point, Angle:[real]) :->
	send(B, send_super, append, Pt),
	(   Angle \== @default
	->  get(B, segment_angles, Angles),
	    send(Angles, append, Angle)
	;   true
	).

angle(B, Segment:'1..', Angle:real) :<-
	get(B, segment_angles, Angles),
	get(Angles, nth1, Segment, Angle).

:- pce_end_class.

		 /*******************************
		 *	       LAMP1		*
		 *******************************/

:- pce_begin_class(lamp1, optical_instrument,
		   "Strong small bundled lamp").

:- pce_global(@lamp_rotator, new(rotate_lamp_gesture)).
:- pce_global(@lamp_mover, new(move_lamp_gesture)).
:- pce_global(@lamp1_recogniser,
	      new(handler_group(@optical_instrument_click_recogniser,
				move_xy_gesture(left),
				move_lamp_gesture(left)))).

variable(beam,	 beam,		get, "Emitted beam").
variable(switch, bool := @on,	get, "Switched on or off").
variable(angle,  '-80.0..80.0',	get, "Start angle for the beam").

:- pce_global(@beam_recogniser,
	      make_beam_recogniser_gesture).

make_beam_recogniser_gesture(G) :-
	new(AP, attach_protractor_gesture),
	send(AP, condition, @event?window?frame?instrument == protractor),
	new(EB, attach_beam_extender_gesture),
	send(EB, condition, @event?window?frame?instrument == extend_beam),
	new(G, handler_group(AP, EB)).


initialise(L, Image:[image]) :->
	send(L, send_super, initialise),
	send(L, slot, angle, 0.0),
	(   Image == @default
	->  new(I, image('lamp1out.xpm'))
	;   I = Image
	),
	get(I, hot_spot, point(HX, HY)),
	send(L, display, new(B, bitmap(I))),
	send(L, slot, beam, new(P, beam)),
	send(P, recogniser,
	     handler_group(@beam_recogniser,
			   handler(ms_left_down, message(@event, post, L)))),
	send(B, set, -HX, -HY).

unlink(L) :->
	get(L, beam, B),
	free(B),
	send(L, send_super, unlink).

name(L, Name:name) :->
	send(L, send_super, name, Name),
	get(L, beam, B),
	atom_concat(Name, '-beam', BName),
	send(B, name, BName).

:- instrument_state([switch, angle, pos_y, pos_x]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).


tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ switch(label(image('switch.lbl')),
			    type(bool)),
		     pos_x(type(on_bar)),
		     pos_y(type(real_range(-10, 10, cm, '%.2f'))),
		     angle(type(real_range(-80, 80, degrees, '%.2f')))
		   ]).


device(L, D:device*) :->
	send(L, send_super, device, D),
	(   D \== @nil
	->  send(L, update)
	;   true
	).


event(L, Ev:event) :->
	(   send(Ev, inside, L)
	->  (   send(L, send_super, event, Ev)
	    ;   send(@lamp1_recogniser, event, Ev)
	    )
	;   get(L?frame, instrument, rotlamp),
	    send(@lamp_rotator, event, Ev)
	).

/*
adjust(L) :->
	"Adjust to the start of the bench"::
	get(L, y, Y),
	send(L, position, point(0, Y)).
*/

delete(L, Forced:[bool]) :->
	(   get(L, read_only, @off)
	;   Forced == @on
	),
	send(L, switch, @off),
	send(L, send_super, delete, @on).


switch(L, Val:bool) :->
	send(L, slot, switch, Val),
	send(L, update).


angle(L, A:'-80.0..80.0') :->
	"Change the angle of the beam"::
	send(L, slot, angle, A),
	(   get(L, window, Window)
	->  send(Window, update, @off)
	;   true
	).


update(L) :->
	"Update the beam if it is displayed"::
	get(L, beam, B),
	(   get(L, switch, @on),
	    get(L, device, Window),
	    Window \== @nil
	->  scale(L, ScaleX, ScaleY),
	    get(L, position, point(X, Y)),
	    RX is X * ScaleX,
	    RY is Y * ScaleY,
	    get(L, angle, Degrees),
	    Angle is pi * Degrees / 180,
	    draw_beam(Window, B, beam(RX, RY, Angle)),
	    ignore(send(B, send_hyper, gauge, update))
	;   send(B, clear)
	).


dragged(L) :->
	"User is dragging the lamp"::
	get(L, window, Window),
	send(Window, update, @off).

notify_rotated(_) :-> true.

:- pce_end_class.

:- pce_begin_class(lamp3, lamp1, "Strong `punt-bron' light").

variable(beam1,	     beam,		get, "Emitted top-beam").
variable(beam2,	     beam,		get, "Emitted bottom-beam").
variable(divergence, '0.0..10.0' := 5,	get, "Angle betweem the beams").

initialise(L) :->
	send(L, send_super, initialise, 'rbulbout.xpm'),
	send(L, slot, beam1, new(B1, beam)),
	send(L, slot, beam2, new(B2, beam)),
	send_list([B1, B2], recogniser, @beam_recogniser).

unlink(L) :->
	get(L, beam1, B1),
	free(B1),
	get(L, beam2, B2),
	free(B2),
	send(L, send_super, unlink).

name(L, Name:name) :->
	send(L, send_super, name, Name),
	get(L, beam1, B1),
	get(L, beam2, B2),
	atom_concat(Name, '-beam1', BName1),
	atom_concat(Name, '-beam2', BName2),
	send(B1, name, BName1),
	send(B2, name, BName2).

:- instrument_state([switch, angle, divergence, pos_x, pos_y]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ switch(type(bool)),
		     pos_x(type(on_bar)),
		     pos_y(type(real_range(-10, 10, cm, '%.2f'))),
		     angle(type(real_range(-80, 80, degrees, '%.2f'))),
		     divergence(type(real_range(0, 10, degrees, '%.2f')))
		   ]).


divergence(L, D:'0.0..10.0') :->
	send(L, slot, divergence, D),
	send(L, update).

update(L) :->
	get(L, beam1, B1),
	get(L, beam,  B),
	get(L, beam2, B2),
	(   get(L, switch, @on),
	    get(L, device, Window),
	    Window \== @nil
	->  scale(L, ScaleX, ScaleY),
	    get(L, position, point(X, Y)),
	    RX is X * ScaleX,
	    RY is Y * ScaleY,
	    get(L, angle, Degrees),
	    Angle is pi * Degrees / 180,
	    draw_beam(Window, B, beam(RX, RY, Angle)),
	    get(L, divergence, D),
	    Angle1 is pi * (Degrees-D) / 180,
	    draw_beam(Window, B1, beam(RX, RY, Angle1)),
	    Angle2 is pi * (Degrees+D) / 180,
	    draw_beam(Window, B2, beam(RX, RY, Angle2)),
	    ignore(send(B, send_hyper, gauge, update)),
	    ignore(send(B1, send_hyper, gauge, update)),
	    ignore(send(B2, send_hyper, gauge, update))
	;   send_list([B1, B, B2], clear)
	),
	(   get(L, device, Dev), Dev \== @nil
	->  (   get(L, hypered, centerline, CL)
	    ->	true
	    ;	send(Dev, display, new(CL, centerline)),
		get(L, name, Name),
		send(CL, name, Name),
		new(_, depto_hyper(L, CL, centerline, lamp))
	    ),
	    get(L, x, LX),
	    send(CL, x, LX)
	;   true
	).

:- pce_end_class.

:- pce_begin_class(parlamp, lamp1, "3 parallel lasers").

variable(beam1,	     beam,	get, "Emitted top-beam").
variable(beam2,	     beam,	get, "Emitted bottom-beam").
variable(separation, '0.0..5',	get, "Distance between beams").

initialise(L) :->
	send(L, send_super, initialise, 'lamp1out.xpm'),
	send(L, slot, separation, 1),
	send(L, display, new(L1, bitmap('lamp1out.xpm'))),
	send(L, display, new(L2, bitmap('lamp1out.xpm'))),
	send(L1, name, lamp1),
	send(L2, name, lamp2),
	send(L, display, new(Ln1, line)),
	send(L, display, new(Ln2, line)),
	send(Ln1, name, line1),
	send(Ln2, name, line2),
	send(L, slot, beam1, new(B1, beam)),
	send(L, slot, beam2, new(B2, beam)),
	send_list([B1, B2], recogniser, @beam_recogniser).

delete_parts([], _).
delete_parts([H|T], L) :-
	get(L, H, Gr),
	free(Gr),
	delete_parts(T, L).

unlink(L) :->
	delete_parts([beam1, beam2], L),
	send(L, send_super, unlink).

compute(L) :->
	(   get(L, request_compute, @nil)
	->  true
	;   get(L, member, lamp1, L1),
	    get(L, member, lamp2, L2),
	    get(L, member, line1, Ln1),
	    get(L, member, line2, Ln2),
	    get(L, separation, Sep),
	    scale(L, _ScaleX, ScaleY),
	    DP is round(Sep/ScaleY),
	    get(L1, hot_spot, point(HX, HY)),
	    Y1 is -DP - HY,
	    Y2 is DP - HY,
	    send(L1, set, -HX, Y1),
	    send(L2, set, -HX, Y2),
	    L1x is -HX + 7,
	    L2x is L1x + 7,
	    send(Ln1, points, L1x, -DP, L1x, DP),
	    send(Ln2, points, L2x, -DP, L2x, DP),
	    send(L, send_super, compute)
	).
		
name(L, Name:name) :->
	send(L, send_super, name, Name),
	get(L, beam1, B1),
	get(L, beam2, B2),
	atom_concat(Name, '-beam1', BName1),
	atom_concat(Name, '-beam2', BName2),
	send(B1, name, BName1),
	send(B2, name, BName2).

:- instrument_state([switch, angle, separation, pos_x, pos_y]).
state(L, Scene:scene_state, State:chain) :<-
	slot_states(Scene, L, State).

tool(L) :->
	"Edit using toolset"::
	apply_tool(L,
		   [ switch(type(bool)),
		     pos_x(type(on_bar)),
		     pos_y(type(real_range(-10, 10, cm, '%.2f'))),
		     angle(type(real_range(-80, 80, degrees, '%.2f'))),
		     separation(type(real_range(0, 5, cm, '%.1f')))
		   ]).


separation(L, D:real) :->
	send(L, slot, separation, D),
	send(L, request_compute),
	send(L, update).

update(L) :->
	get(L, beam1, B1),
	get(L, beam,  B),
	get(L, beam2, B2),
	(   get(L, switch, @on),
	    get(L, device, Window),
	    Window \== @nil
	->  scale(L, ScaleX, ScaleY),
	    get(L, position, point(X, Y)),
	    RX is X * ScaleX,
	    RY is Y * ScaleY,
	    get(L, angle, Degrees),
	    Angle is pi * Degrees / 180,
	    draw_beam(Window, B, beam(RX, RY, Angle)),
	    get(L, separation, D),
	    RY1 is RY + D,
	    RY2 is RY - D,
	    draw_beam(Window, B1, beam(RX, RY1, Angle)),
	    draw_beam(Window, B2, beam(RX, RY2, Angle)),
	    ignore(send(B, send_hyper, gauge, update)),
	    ignore(send(B1, send_hyper, gauge, update)),
	    ignore(send(B2, send_hyper, gauge, update))
	;   send_list([B1, B, B2], clear)
	).

:- pce_end_class.


		 /*******************************
		 *	     ROTATE-LAMP	*
		 *******************************/

:- pce_begin_class(rotate_lamp_gesture, gesture, "Rotate a lamp").

variable(line,		line,	get, "Feedback line").

initialise(G, Button:[button_name]) :->
	send(G, send_super, initialise, Button),
	send(G, slot, line, new(L, line)),
%	send(L, texture, dotted),
	send(L, colour, darkgoldenrod).

verify(G, Ev:event) :->
	get(Ev, receiver, L),
	get(L, read_only, @off),
	get(L, beam, Beam),
	get(Beam, segment, Ev, P1),
	get(Beam, points, Pts),
	get(Pts, head, P1),
	get(Ev, position, L?device, Pos),
	get(Pts, nth1, 2, P2),
	new(Line, line),
	send(Line, start, P1),
	send(Line, end, P2),
	get(Line, distance, Pos, D),
	D < 7,
	get(G, line, L2),
	send(L2, start, P1),
	send(L2, end, P1).

initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(Ev, receiver, Lamp),
	get(Lamp, name, Id),
	get(Lamp, device, Dev),
	send(Dev, display, G?line),
	log(begin(rotate(Id))).

drag(G, Ev:event) :->
	"Rotate the lamp to point at me"::
	get(Ev, receiver, Gr),
	get(Gr, device, Dev),
	get(Ev, position, Dev, point(EvX, EvY)),
	get(Gr, position, point(GrX, GrY)),
	Angle0 is -atan(EvY-GrY, EvX-GrX) * 180 / pi,
	bounds(Angle0, -80, 80, Angle),
	send(Gr, angle, Angle),
	get(G, line, Line),
	rotated_line(Line, Angle),
	log(drag(Angle)).

rotated_line(Line, Angle) :-
	get(Line, window, Window),
	get(Window, visible, Area),
	get(Line, start, point(X0, Y0)),
	get(Area, right_side, R),
	Y is Y0 + tan((Angle*pi)/180) * (X0-R),
	send(Line, end, point(R, Y)).


terminate(G, Ev:event) :->
	"User finished rotating"::
	get(Ev, receiver, Gr),
	send(G?line, device, @nil),
	send(Gr, notify_rotated),
	log(end),
	send(Gr?window, auto_switch_on).

bounds(X0, Low, High, X) :-
	(   X0 < Low
	->  X is Low
	;   X0 > High
	->  X is High
	;   X is X0
	).
       
:- pce_end_class.

:- pce_begin_class(move_lamp_gesture, move_gesture,
		   "Move lamp, shine at same location").

variable(target_x,	int,	get,	"X of where we are pointing to").
variable(offset_y,	int,	get,	"Y-offset from origin").

hit_y0(Path, X) :-
	get_chain(Path, points, Pts),
	maplist(object, Pts, Points),
	x_y0(Points, X).

x_y0([point(X,Y)|_], X) :-
	abs(Y) =< 2, !.
x_y0([_,point(X,Y)|_], X) :-
	abs(Y) =< 2, !.
x_y0([point(X1,Y1), point(X2, Y2)|_], X) :-
	sign(Y1) =\= sign(Y2), !,
	X is round(X1 + (abs(Y1)*(X2-X1))/(abs(Y1)+abs(Y2))).
x_y0([_|T], X) :-
	x_y0(T, X).

verify(G, Ev:event) :->
	send(G, send_super, verify, Ev),
	get(Ev?window?frame, instrument, movelamp),
	get(Ev, receiver, Lamp),
	get(Lamp, beam, B),
	(   hit_y0(B, X)
	->  send(G, slot, target_x, X)
	).


initiate(G, Ev:event) :->
	send(G, send_super, initiate, Ev),
	get(Ev, receiver, Lamp),
	get(Ev, y, Lamp, OY),
	send(G, slot, offset_y, OY),
	get(Lamp, name, Id),
	get(Lamp?window, scale_x, ScaleX),
	get(G, target_x, TX),
	RTX is TX * ScaleX,
	log(begin(shiftrotate(Id, target_x(RTX)))).

drag(G, Ev:event) :->
	"Move in Y-direction, report position"::
	get(Ev, receiver, L),
	get(L, device, Dev),
	get(Ev, y, Dev, YP),
	get(G, offset_y, OY),
	NY is YP - OY,
	scale(L, ScaleX, ScaleY),
	Y is NY * ScaleY,
	get(G, target_x, XP),
	X is XP * ScaleX,
	A is -atan(Y, X) * 180 / pi,
	(   abs(A) < 80
	->  send(L, angle, A),
	    send(L, y, NY),
	    send(L, dragged),
	    log(drag(NY))
	).

terminate(_, Ev:event) :->
	get(Ev, receiver, Gr),
	send(Gr, notify_moved),
	log(end),
	send(Gr?window, auto_switch_on).

:- pce_end_class.
