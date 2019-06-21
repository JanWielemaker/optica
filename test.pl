/*  $Id: test.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(test,
	  [ current_test/1,		% +TestName
	    run_test/1			% +TestName
	  ]).
:- use_module(library(pce)).
:- use_module(util).
:- pce_autoload(finder, library(find_file)).
:- pce_global(@finder, new(finder)).
:- use_module(local(save)).
:- use_module(language).
:- use_module(pretty_print).
:- use_module(configdb).
:- require([ absolute_file_name/3
	   , between/3
	   , concat_atom/3
	   , default/3
	   , forall/2
	   , gensym/2
	   , get_time/1
	   , ignore/1
	   , maplist/3
	   , member/2
	   , memberchk/2
	   , open/4
	   , random/3
	   , round/2
	   ]).

		 /*******************************
		 *	      TOPLEVEL		*
		 *******************************/

current_test(Term) :-
	test_spec_to_file_base(Term, Base),
	absolute_file_name(test(Base),
			   [ extensions([tst]),
			     access(read),
			     file_errors(fail)
			   ], _).

run_test(Term) :-
	test_spec_to_file_base(Term, Base),
	new(T, tester),
	(   send(@event, instance_of, event)
	->  get(@event?window, frame, Optica),
	    send(T, transient_for, Optica),
	    send(T, modal, transient)
	;   true
	),
	send(T, open_centered),
	send(T, run_test, Base, Base),
	ignore(get(T, confirm_centered, _)). % wait for it.

runtest(In, Out) :-
	send(new(T, tester), open_centered),
	send(T, run_test, In, Out).

test_spec_to_file_base(Term, Base) :-
	Term =.. [Set, Name], !,
	concat_atom([Set, Name], /, Base).
test_spec_to_file_base(Base, Base).


		 /*******************************
		 *	    QUESTIONER		*
		 *******************************/

:- pce_begin_class(questioner, frame, "Frame for asking questions").

initialise(F) :->
	send(F, send_super, initialise),
	send(F, append, new(WS, test_state)),
	send(new(_QW, question_window), below, WS).

instrument(_, I:name) :<-
	I = none.

show_question(F, Q:question) :->
	get(Q, name, Name),
	send(F, label, Name),
	get(F, member, test_state, WS),
	(   config(test_clear_quickly(true))
	->  send(WS, clear, @on, @on)
	;   send(WS, clear, @on)
	),
	(   get(Q, situation, State),
	    State \== @nil
	->  send(State, restore, WS)
	;   true
	),
	get(F, member, question_window, QW),
	send(QW, show_question, Q).

:- pce_end_class.

:- pce_begin_class(question_window, dialog, "Dialog for question").

show_question(QW, Q:question) :->
	send(QW, clear),
	(   config(test_font(Font))
	->  true
	;   Font = large
	),
	send(QW, append, label(question, Q?question, Font)),
	send(QW, append, graphical(0,0,20,0)),
	send(QW, append, new(M, menu(answer, choice,
				     message(QW, answer, @arg1))), right),
	send(M, value_font, Font),
	send(M, alignment, left),
	send(M, layout, vertical),
	send(M, multiple_selection, @on),
	send(M, show_label, @off),
	send(Q?answers, for_all,
	     message(M, append,
		     create(menu_item, @arg2, @default, @arg1))),
	(   config(test_with_ok_button(true))
	->  send(QW, append, new(Ok, button(ok))),
	    send(Ok, active, @off)
	;   send(M, message, message(QW, ok)),
	    send(QW, append, graphical(0,0,1,1)) % Span
	),
	send(QW, layout, QW?size).

answer(QW, A:int) :->
	get(QW, member, answer, Menu),
	send(Menu, selection, A),
	get(QW, member, ok, Ok),
	send(Ok, active, @on).
	
ok(QW) :->
	"Forward the answer to our frame"::
	get(QW, member, answer, Menu),
	get(Menu?selection, head, Answer0),
	(   answername(Answer0, Answer)
	->  true
	;   Answer = Answer0
	),
	send(QW?frame, answer, Answer).

:- pce_end_class.


:- pce_begin_class(tester, questioner, "Actually running a test").

variable(questionaire,     questionaire*, get, "Questionaire to run").
variable(current_question, int := 0,	  get, "Current question number").
variable(answer_stream,	   'name|int'*,	  get, "Stream alias for output").
variable(sequence,	   vector*,	  get, "Sequencing vector").
variable(test,		   name*,	  get, "Identifier of the test").
variable(epoch,		   real,	  get, "Time of start").
variable(time0,		   real,	  get, "Time at start question").

initialise(T) :->
	send(T, send_super, initialise),
	get(T, member, question_window, QW),
	send(QW, size, size(200, 220)).

test_result_file(Base, File) :-
	(   config(log_directory(LogDir)),
	    fact(user(User))
	->  true
	;   LogDir = '.',
	    User = '.'
	),
	between(1, 1000000, N),
	get(string('%s/%s/%s%03d.asw', LogDir, User, Base, N), value, File),
	\+ send(file(File), exists), !.
	

run_test(F, Name:name, Output:name) :->
	send(F, slot, test, Name),
	absolute_file_name(test(Name),
			   [ extensions([tst]),
			     access(read)
			   ], TestFile),
	test_result_file(Output, TestResultFile),
	new(Q, questionaire),
	send(Q, load, TestFile),
	gensym(testresult, OutAlias),
	open(TestResultFile, write, _Fd, [alias(OutAlias)]),
	send(F, run_questionaire, Q, OutAlias).


run_questionaire(F, Q:questionaire, Out:'int|name') :->
	get(@pce?date, value, Date),
	(   fact(user(User))
	->  true
	;   User = '(unknown)'
	),
	get(F, test, Test),
	get_time(Epoch),
	send(F, slot, epoch, Epoch),
	format(Out, '/*  Test results for "~w" started ~w~n', [User, Date]),
	format(Out, '*/~n~n', []),
	format(Out, 'test(~q).~n', [Test]),
	format(Out, 'pp(~q).~n', [User]),
	format(Out, 'epoch(~1f).~n~n', [Epoch]),
	send(F, slot, questionaire, Q),
	send(F, slot, current_question, 0),
	(   config(test_random_order(true))
	->  get(Q?members, size, Num),
	    random_sequence(Num, Random),
	    Term =.. [vector|Random],
	    send(F, slot, sequence, Term)
	;   send(F, slot, sequence, @nil)
	),
	send(F, slot, answer_stream, Out),
	send(F, next_question).


sequence(0, []) :- !.
sequence(N, [N|T]) :-
	NN is N - 1,
	sequence(NN, T).

random_sequence(Len, List) :-
	sequence(Len, List0),
	randomise(List0, Len, List).

randomise([], _, []).
randomise(In, Len, [H|T]) :-
	A is random(Len),
	delete_nth(A, In, H, In1),
	Len1 is Len - 1,
	randomise(In1, Len1, T).

delete_nth(0, [H|T], H, T) :- !.
delete_nth(N, [H0|T0], H, [H0|T]) :-
	NN is N - 1,
	delete_nth(NN, T0, H, T).

question_number(F, Q0, Q) :-
	get(F, sequence, Seq),
	Seq \== @nil, !,
	get(Seq, element, Q0, Q).
question_number(_, Q, Q).

next_question(F) :->
	get(F, questionaire, Q),
	get(F, current_question, CQ0),
	CQ1 is CQ0 + 1,
	(   question_number(F, CQ1, CQ),
	    get(Q?members, nth1, CQ, Question)
	->  send(F, show_question, Question),
	    send(F, slot, current_question, CQ1),
	    get_time(Time0),
	    send(F, slot, time0, Time0)
	;   get(F, answer_stream, Fd),
	    get(@pce?date, value, Date),
	    format(Fd, '~n%% Completed at ~w~n', [Date]),
	    close(Fd),
	    message(thanks_for_test, Text),
	    send(@display, inform, Text),
	    send(F, destroy)
	).


answer(F, Answer:any) :->
	get_time(Time1),
	get(F, epoch, Epoch),
	get(F, time0, Time0),
	Start is Time0 - Epoch,
	End   is Time1 - Epoch,
	get(F, current_question, CQ0),
	question_number(F, CQ0, CQ),
	get(F, answer_stream, Fd),
	format(Fd, '@(~1f - ~1f, ~q = ~q).~n', [Start, End, CQ, Answer]),
	flush_output(Fd),
	send(F, next_question).

:- pce_end_class.


		 /*******************************
		 *	  AUTHOR SUPPORT	*
		 *******************************/

tool(save,
     [ icon('save.xpm'),
       english('Save test'),
       dutch('Toets opslaan')
     ]).
tool(load,
     [ icon('restore.xpm'),
       english('Load test'),
       dutch('Toets laden')
     ]).

tool(-, []).

tool(run,
     [ icon('run.xpm'),
       english('Test the entire test'),
       dutch('Gehele toets proberen')
     ]).

:- pce_begin_class(question_author, frame, "Edit/Create questionaire").

variable(file,	file*,	get, "Last file used").

initialise(QA, Tool:[frame], Questionaire:[questionaire]) :->
	default(Questionaire, new(questionaire), Questions),
	send(QA, send_super, initialise, 'Test Authoring tool'),
	send(QA, done_message, message(QA, quit)),
	send(QA, append, new(TD, dialog)),
	send(new(B, list_editor), left, new(D, dialog)),
	send(B, name, browser),
	send(B, dict, Questions),
	send(B, below, TD),
	send(new(RD, dialog), below, B),
	send(RD, pen, 0),
	send(RD, gap, size(0,0)),
	send(RD, append, label(reporter)),
	send(B, select_message, message(QA, view, @arg1?head)),
	send(D, name, question),
	send(TD, name, tool_dialog),
	send(TD, pen, 0),
	send(TD, gap, size(0, 5)),
	send(QA, fill_tool_bar),
	send(QA, fill_question_window),
	(   get(Questions?members, size, 0)
	->  send(QA, new_question)
	;   true
	),
	(   Tool \== @default
	->  new(_, hyper(Tool, QA, test_author, tool))
	;   true
	).
	

instrument(_, I:name) :<-
	"For integration of the optical workspace"::
	I = none.


quit(QA) :->
	send(QA, destroy).

fill_tool_bar(QA) :->
	get(QA, member, tool_dialog, TD),
	current_language(Lan),
	Term =.. [Lan, Tag],
	(   tool(Name, Options),
	    (	Name == -
	    ->	send(TD, append, graphical(0,0,10,0), right)
	    ;   memberchk(icon(Icon), Options),
		memberchk(Term, Options),
		send(TD, append,
		     new(B, button(Name, message(QA, Name))), right),
		send(B, label, image(Icon)),
		send(B, help_message, tag, Tag)
	    ),
	    fail
	;   true
	).
	

append_editor(Q, Name, Height) :-
	send(Q, append, string_item(Name, '', @nil, size(50,Height))).

answername(1, 'A').
answername(2, 'B').
answername(3, 'C').
answername(4, 'D').
answername(5, 'E').

fill_question_window(QA) :->
	get(QA, member, question, Question),
	send(Question, gap, size(15, 5)),
	send(Question, append, new(_N, text_item(name, ''))),
	append_editor(Question, question, 8),
	forall(answername(_, Name), append_editor(Question, Name, 4)),
	send(Question, append, thumb_item(situation, @nil)),
	send(Question, append, button(new, message(QA, new_question))),
	send(Question, append, button(preview, message(QA, preview_question))),
	send(Question, append, button(save, message(QA, save_question))),
	send(Question, send_method,
	     send_method(modified_item,
			 vector(graphical, bool),
			 message(QA, modified_item, @arg2))).
	     

modified_item(QA, Val:bool) :->
	(   Val == @on
	->  send_parts(QA/question/[save,preview], active(Val))
	;   true
	).


modified(QA, Val:bool) :<-
	"Test if an item was modified"::
	get(QA, member, question, D),
	(   get(D?graphicals, find, @arg1?modified == @on, _)
	->  Val = @on
	;   Val = @off
	).

save_if_modified(QA) :->
	(   get(QA, status, open),
	    get(QA, modified, @on)
	->  new(D, dialog('Save?')),
	    send(D, transient_for, QA),
	    send(D, modal, transient),
	    send(D, append, label(label, 'Question was modified, Save?')),
	    send(D, append, button(save,
				   message(D, return, save))),
	    send(D, append, button(discard_changes,
				   message(D, return, discard_changes))),
	    send(D, append, button(cancel,
				   message(D, return, cancel))),
	    get(D, confirm_centered, QA?area?center, Answer),
	    send(D, destroy),
	    (	Answer == save
	    ->	send(QA, save_question)
	    ;	Answer == discard_changes
	    ->	true
	    )
	;   true
	).
	
view_in_editor(D, I, Text) :-
	(   answername(I, Name)
	->  true
	;   Name = I
	),
	get(D, member, Name, Editor),
	send(Editor, selection, Text).

view(QA, Q:question) :->
	"View a question"::
	send(QA, save_if_modified),
	get(QA, member, question, D),
	send(QA, clear_question),
	get(Q, question, Question),
	send_parts(D/name, selection(Q?key)),
	send_parts(D/situation, selection(Q?situation)),
	view_in_editor(D, question, Question),
	send(Q?answers, for_all,
	     message(@prolog, view_in_editor, D, @arg2, @arg1)),
	send_parts(D/[new,preview], active(@on)),
	send_parts(D/save, active(@off)),
	new(_, hyper(QA, Q, current_question, editor)).

value(D, Name, S) :-
	get(D, member, Name, Item),
	get(Item, selection, V),
	get(@pce, convert, V, string, S),
	send(S, strip).

question(QA, Q:question) :<-
	"Construct a question"::
	get(QA, member, question, D),
	value(D, question, Question),
	value(D, name, Name0),
	(   get(Name0, size, 0)
	->  get(QA, member, browser, B),
	    get(B?dict?members, size, N),
	    Name is N + 1
	;   Name = Name0
	),
	new(Q, question(Name, Question)),
	send(Q, question, Question),
	forall((answername(I, A),
		value(D, A, Answer),
		\+ get(Answer, size, 0)),
	       send(Q, answer, I, Answer)),
	get(D, member, situation, Thumbnail),		% add the situation
	get(Thumbnail, selection, State),
	send(Q, situation, State).    
	

preview_question(QA) :->
	"Preview the current question"::
	get(QA, question, Q),
	send(new(_QP, question_previewer(Q)), open_centered).


empty_editor(QA, Name:name) :->
	"Empty the named editor"::
	find_graphical(QA/question/Name, E),
	send(E, clear),
	send(E, modified, @off).

clear_question(QA) :->
	send(QA, save_if_modified),
	send(QA, delete_hypers, current_question),
	(   (   A = question
	    ;   answername(_, A)
	    ),
	    send(QA, empty_editor, A),
	    fail
	;   true
	),
	send_parts(QA/question/name, selection('')),
	send_parts(QA/question/situation, clear),
	send_parts(QA/question, advance),
	send_parts(QA/question/[save,new,preview], active(@off)).

new_question(QA) :->
	send(QA, clear_question),
	send_parts(QA/browser, selection(@nil)).

save_question(QA) :->
	"Save the current question"::
	get(QA, question, Q),
	(   get(QA, hypered, current_question, Current)
	->  send(Current, copy, Q)
	;   find_graphical(QA/browser, B),
	    send(B, append, Q)
	),
	send(QA, new_question),
	send_parts(QA/question/new, active(@on)).

:- pce_group(file).

run(QO) :->
	"Run entire questionaire"::
	get(QO, member, browser, Browser),
	get(Browser, dict, Questionaire),
	send(new(T, tester), open_centered),
	new(V, view('Answers from test run')),
	pce_open(V, write, Fd),
	send(T, run_questionaire, Questionaire, Fd),
	repeat,
	    ignore(send(@display, dispatch)),
	    \+ object(T), !,
	send(V, open_centered).


save(QO) :->
	"Save questionaire to file"::
	send(QO, save_if_modified),
	(   get(QO, file,  File), File \== @nil
	->  get(File, directory_name, Dir),
	    get(File, base_name, Def)
	;   absolute_file_name(test(.),
			       [ file_type(directory),
				 access(write),
				 file_errors(fail)
			       ], Dir)
	->  Def = @default
	;   Dir = @default,
	    Def = @default
	),
	get(@finder, file, @off, '.tst', Dir, Def, SaveFile),
	get(QO, member, browser, B),
	send(B, save, SaveFile),
	send(QO, slot, file, SaveFile),
	send(QO, label,
	     string('Test Authoring tool -- %s', file(SaveFile)?base_name)).

load(QO) :->
	"Load questionaire from file"::
	absolute_file_name(test(.),
			   [ file_type(directory),
			     access(read)
			   ], Dir),
	get(@finder, file, @on, '.tst', Dir, File),
	send(QO, new_question),
	get(QO, member, browser, B),
	new(Q, questionaire),
	send(B, dict, Q),
	send(Q, load, File),
	send(QO, slot, file, File),
	send(QO, label,
	     string('Test Authoring tool -- %s', file(File)?base_name)).

snap(QA, Tool:object) :->
	get(QA, member, question, QD),
	get(QD, member, situation, ThumbItem),
	send(ThumbItem, snap, Tool).

:- pce_end_class.

active(Spec, Val) :-
	forall(find_graphical(Spec, Gr),
	       send(Gr, active, Val)).

:- pce_begin_class(question_previewer, questioner).

initialise(QP, Q:question) :->
	send(QP, send_super, initialise),
	send(QP, show_question, Q).

answer(QP, _Answer:any) :->
	send(QP, destroy).

:- pce_end_class.


:- pce_begin_class(mini_editor, editor).

'_wants_keyboard_focus'(E) :->
	get(E, editable, @on).

event(E, Ev:event) :->
	send(E, send_super, event, Ev),
	(   send(Ev, is_a, obtain_keyboard_focus)
	->  send(E?text_cursor, displayed, @on)
	;   send(Ev, is_a, release_keyboard_focus)
	->  send(E?text_cursor, displayed, @off)
	;   true
	).

:- pce_end_class.

:- pce_begin_class(labeled_dialog_item, dialog_group,
		   "Item that is encapsulated with a label").

variable(default,	   'any|function', get, "Default value").
variable(message,	   [code]*,	   get, "Action associated").
variable(auto_label_align, bool := @on,	   both, "Align label").

initialise(SI, Name:name, Def:'any|function', Msg:[code]*) :->
	send(SI, send_super, initialise, Name, group),
	send(SI, gap, size(0,0)),
	send(SI, display, new(Gr, graphical(0,0,1,0))),
	send(Gr, name, anchor),
	get(SI, label_name, Name, Label),
	send(SI, display,
	     new(L, label(label, string('%s:', Label), bold)), point(0,0)),
	send(L, reference, point(0,2)),
	send(L, length, 0),
	send(SI, slot, default, Def),
	send(SI, slot, message, Msg).

next(SI) :->
	send(SI?device, advance, SI).

label_width(SI, W:int) :<-
	"Minimal label width"::
	get(SI, member, label, Label),
	get(Label, width, W0),
	get(Label?font, ex, Ex),
	W is W0 + Ex.
label_width(SI, W:int) :->
        "Assign label width"::
        get(SI, member, item, E),
        get(SI, member, label, L),
        get(L?font, ex, Ex),
        send(E, x, W),
        send(L, x, W-L?width-Ex/2).

restore(SI) :->
	get(SI, default, Def),
	send(SI, selection, Def).

apply(SI, Always:[bool]) :->
	(   (   Always == @on
	    ;   get(SI, modified, @on)
	    )
	->  get(SI, selection, Sel),
	    get(SI, message, Msg),
	    (	Msg == @nil
	    ->	send(Msg, forward, Sel)
	    ;	true
	    )
	;   true
	).
	
:- pce_end_class.

:- pce_begin_class(string_item, labeled_dialog_item, "Item for a string").

initialise(SI, Name:name, Def:'string|function', Msg:[code]*, Size:[size]) :->
	default(Size, size(40,5), TheSize),
	send(SI, send_super, initialise, Name, Def, Msg),
	send(SI, append, new(E, mini_editor), right),
	send(E, font, normal),
	get(TheSize, width, Width),
	send(E, right_margin, Width-5),
	send(E, name, item),
	send(E, size, TheSize),
	send(E, modified_message,
	     if(SI?device \== @nil,
		message(SI?device, modified_item, SI, @on))),
	send(E, key_binding, 'TAB', message(SI, next)),
	send(E, key_binding, '\\C-c', export_selection),
	send(E, key_binding, '\\C-v', import_selection),
	send(E?text_cursor, displayed, @off),
	send(SI, restore).
	

selection(SI, Str:string) :->
	get(SI, member, item, E),
	send(E, contents, Str),
	send(E, modified, @off).
selection(SI, Str:string) :<-
	get(SI, member, item, E),
	get(E, contents, Str),
	send(E, modified, @off).

modified(SI, Val:bool) :<-
	get(SI, member, item, E),
	get(E, modified, Val).
modified(SI, Val:bool) :->
	get(SI, member, item, E),
	send(E, modified, Val).

clear(SI) :->
	send(SI, selection, '').

:- pce_end_class.


:- pce_begin_class(thumb_item, labeled_dialog_item,
		   "Thumbnail of workspace").

variable(modified,	bool := @off,	both, "Item was modified").
variable(selection,	scene_state*,	none, "Current scene state").
variable(hor_stretch,	int := 100,	both, "Stretchability").

initialise(SI, Name:name, Def:'scene_state|function*', Msg:[code]*,
	   Size:[size]) :->
	default(Size, size(200,50), TheSize),
	send(SI, send_super, initialise, Name, Def, Msg),
	send(SI, display, new(WS, test_thumb(TheSize))),
	send(SI, display, new(B, button(snap)), point(0,0)),
	send(SI, display, new(E, button(edit)), point(0,0)),
	send(B, help_message, tag, 'Import situation'),
	send(E, help_message, tag, 'Export situation (for editing)'),
	send(B, label, image('mini-camera.xpm')),
	send(E, label, image('editstate.xpm')),
	send(WS, name, item),
	send(SI, restore).

geometry(SI, X:[int], Y:[int], W:[int], H:[int]) :->
	(   W \== @default
	->  get(SI, member, snap, Snap),
	    get(SI, member, edit, Edit),
	    get(SI, member, item, Item),
	    get(Snap, width, IW),
	    IX is W - IW,
	    send(Item, right_side, IX-10),
	    stack_icons([Snap, Edit], IX, 0)
	;   true
	),
	send(SI, send_super, geometry, X, Y, W, H).

stack_icons([], _, _).
stack_icons([H|T], X, Y) :-
	send(H, set, X, Y),
	get(H, height, DY),
	NY is Y + DY,
	stack_icons(T, X, NY).

selection(SI, State:scene_state*) :->
	get(SI, member, item, WS),
	(   State == @nil
	->  send(WS, clear)
	;   send(State, restore, WS)
	),
	send(SI, slot, selection, State),
	send(SI, modified, @off).
selection(SI, State:scene_state*) :<-
	get(SI, slot, selection, State),
	send(SI, modified, @off).

clear(SI) :->
	send(SI, selection, @nil).


tool(SI, Create:[bool], Optica:object) :<-
	"Find the simulation tool"::
	(   get(SI?frame, hypered, tool, Optica),
	    (	Create \== @on
	    ;   send(Optica, has_send_method, state)
	    )
	->  true
	;   Create == @on
	->  send(new(Optica, state_editor), open),
	    new(_, hyper(SI?frame, Optica, tool, test))
	;   get(SI, frame, Frame0),
	    find_transient(Frame0, optica, Optica)
	->  true
	;   send(SI, report, warning, 'No simulation environment'),
	    fail
	).

find_transient(Frame, Class, Frame) :-
	send(Frame, instance_of, Class), !.
find_transient(Frame0, Class, Frame) :-
	get(Frame0, transient_for, Frame1),
	Frame1 \== @nil,
	find_transient(Frame1, Class, Frame).

snap(SI, Tool:[object]) :->
	"Import current situation from simulation"::
	(   Tool == @default
	->  get(SI, tool, Optica)
	;   Optica = Tool
	),
	get(Optica, state, State),
	send(SI, selection, State),
	send(SI, modified, @on),
	(   get(SI, device, Dev),
	    Dev \== @nil
	->  send(Dev, modified_item, SI, @on)
	;   true
	).


edit(SI) :->
	"Bring back to simulator"::
	get(SI, selection, State),
	get(SI, tool, @on, Optica),
	send(Optica, state, State),
	send(Optica, attribute, author_version, @on).

:- pce_end_class.


:- pce_begin_class(list_editor, browser, "Browser for editing").

initialise(LE) :->
	send(LE, send_super, initialise),
	send(LE, multiple_selection, @on),
	send(LE?key_binding, function, '\\C-w', cut),	% Unix bindings 
	send(LE?key_binding, function, '\\C-y', paste),
	send(LE?key_binding, function, '\\e-w', copy),
	send(LE?key_binding, function, '\\C-x', cut),	% Windows bindings
	send(LE?key_binding, function, '\\C-c', copy),
	send(LE?key_binding, function, '\\C-v', paste).

next_line(LE, Arg:[int]) :->
	default(Arg, 1, A),
	get(LE, selection, Chain),
	(   get(Chain, size, 1)
	->  get(Chain?head, index, I0),
	    I1 is I0 + A,
	    get(LE?dict?members, nth0, I1, DI),
	    send(LE, selection, DI)
	;   get(Chain, size, 0)
	->  get(LE?dict?members, head, DI),
	    send(LE, selection, DI)
	),
	get(LE, select_message, Msg),
	send(Msg, forward, DI).

previous_line(LE, Arg:[int]) :->
	default(Arg, 1, A),
	get(LE, selection, Chain),
	(   get(Chain, size, 1)
	->  get(Chain?head, index, I0),
	    I1 is I0 - A,
	    get(LE?dict?members, nth0, I1, DI),
	    send(LE, selection, DI)
	;   get(Chain, size, 0)
	->  get(LE?dict?members, tail, DI),
	    send(LE, selection, DI)
	),
	get(LE, select_message, Msg),
	send(Msg, forward, DI).


:- pce_global(@list_editor_clipboard, new(chain)).

copy(LE) :->
	"Put items on @list_editor_clipboard"::
	get(LE, selection, DictItems),
	send(@list_editor_clipboard, clear),
	send(DictItems, for_all,
	     message(@list_editor_clipboard, append, @arg1?clone)),
	send(LE, report, status, 'Copied %d items', DictItems?size).

cut(LE) :->
	"Put items on clipboard and remove them"::
	send(LE, copy),
	get(LE, selection, DictItems),
	send(DictItems, for_all, message(LE, delete, @arg1)).

paste(LE) :->
	"Put items below selection, or at top"::
	(   send(@list_editor_clipboard, empty)
	->  send(LE, report, warning, 'No items on clipboard')
	;   (	get(LE, selection, DictItems),
	        get(DictItems, tail, Last)
	    ->	true
	    ;	Last = @nil
	    ),
	    get(LE, dict, Dict),
	    send(@list_editor_clipboard, for_all,
		 and(assign(new(L, var), Last),
		     assign(new(C, var), @nil),
		     assign(C, @arg1?clone),
		     message(Dict, insert_after, C, L),
		     assign(L, C)))
	).

:- pce_end_class.


:- pce_begin_class(question, dict_item, "Storage for a question").

variable(question,	string, 	both, "The question text").
variable(answers,	vector, 	get,  "The answers").
variable(situation,	scene_state*,	both, "What-if scene state").

initialise(Q, Name:name, Question:string, Answers:[vector]) :->
	default(Answers, new(vector), TheAnswers),
	send(Q, send_super, initialise, Name),

	send(Q, slot, question, Question),
	send(Q, slot, answers, TheAnswers).

name(Q, Name:name) :<-
	"Name (is <-key)"::
	get(Q, key, Name).

copy(Q, Q2:question) :->
	"Copy attributes of argument"::
	send(Q, key, Q2?key),
	send(Q, question, Q2?question?clone),
	send(Q, slot, answers, Q2?answers?clone),
	send(Q, situation, Q2?situation?clone).

answer(Q, A:[int], T:string) :->
	get(Q, answers, Vector),
	(   A == @default
	->  send(Vector, append, T)
	;   send(Vector, element, A, T)
	).

save(Q, Fd:'int|name') :->
	question_to_term(Q, Term),
	pretty_print(Fd, Term).

question_to_term(Q, question(I, Name, QA, Atoms, State)) :-
	nonvar(Q), !,
	get(Q, question, S1),
	get(Q, key, Name),
	get(Q, index, I0),
	I is I0 + 1,
	get(S1, value, QA),
	get(Q, answers, V),
	object(V, VT),
	VT =.. [_|Answers],
	maplist(pce_string_to_atom, Answers, Atoms),
	(   get(Q, situation, D),
	    D \== @nil
	->  state_to_term(D, State)
	;   State = (-)
	).
question_to_term(Q, question(_I, Name, QA, Atoms, StateTerm)) :-
	new(Q, question(Name, QA)),
	forall(member(A, Atoms), send(Q, answer, @default, A)),
	(   StateTerm == -
	->  true
	;   state_to_term(State, StateTerm),
	    send(Q, situation, State)
	).

pce_string_to_atom(String, Atom) :-
	get(String, value, Atom).

:- pce_end_class.

:- pce_begin_class(questionaire, dict).

save(Q, In:file) :->
	"Save in named file"::
	ignore(send(In, backup)),
	get(@pce?date, value, Date),
	get(In, name, Name),
	open(Name, write, Fd, [alias(save_questionaire)]),
	format(Fd, '/*  Questionaire created by optica toolkit~n', []),
	format(Fd, '    Date: ~w~n', [Date]),
	format(Fd, '*/~n~n', []),
	send(Q?members, for_all,
	     message(@arg1, save, save_questionaire)),
	close(Fd).

load(Q, From:file) :->
	"Load the questions"::
	get(From, name, Name),
	open(Name, read, Fd),
	send(Q, clear),
	with_long_atoms((read(Fd, Term),
			 load_questions(Term, Fd, Q))),
	close(Fd).
	
load_questions(end_of_file, _, _) :- !.
load_questions(Term, Fd, Q) :-
	question_to_term(Question, Term),
	send(Q, append, Question),
	read(Fd, Term2),
	load_questions(Term2, Fd, Q).

:- pce_end_class.
