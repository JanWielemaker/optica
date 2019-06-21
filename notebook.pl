/*  $Id: notebook.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(notebook, []).
:- use_module(library(pce)).
:- use_module(language).
:- use_module(log).
:- use_module(local(save)).
:- require([ concat/3
	   , default/3
	   ]).

:- pce_global(@notes, new(note_database)).

:- pce_begin_class(notebook, frame, "Optica notebook").

variable(current,	name,		get, "Key of current state").
variable(selection,	name,		get, "Currently viewed note").

initialise(NB, Tool:object, DB:[note_database]) :->
	message(notebook, Label),
	default(DB, @notes, TheDB),
	(   get(TheDB, browser, OldB), OldB \== @nil
	->  free(OldB),
	    send(TheDB, slot, browser, @nil)
	;   true
	),
	send(NB, send_super, initialise, Label),
	send(NB, done_message, message(NB, quit)),
	send(NB, append, new(D, dialog)),
	send(new(WS, note_state), below, D),
	message(notes, NotesLabel),
	message(note, NoteLabel),
	new(B, browser),
	send(B, label, NotesLabel),
	send(B, dict, TheDB),
	send(B, select_message, message(NB, selection, @arg1)),
	send(new(V, view(size := size(40,10))), right, B),
	send(V, font, normal),
	send(V, label, NoteLabel),
	send(B, below, WS),
	send(D, append,
	     optica_tool_button(save_and_exit,
				message(NB, quit), 'exit.xpm')),
	send(D, append,
	     optica_tool_button(resume_with_state,
				message(NB,experiment), 'experiment.xpm'),
	     right),
	send(D, append, label(reporter), right),
	send(D?graphicals, for_all,
	     message(@arg1, reference, create(point, 0, @arg1?height))),
	new(_, depto_hyper(Tool, NB, notebook, object)),
	send(NB, new).

instrument(_F, I:name) :<-
	"Optical workspace integration"::
	I = none.

quit(NB) :->
	send(NB, save_on_quit),
	send(NB, destroy),
	log(end(notebook)).

experiment(NB) :->
	get(NB, selection, Id),
	(   get(NB, current, Id)
	->  send(NB, quit)
	;   send(NB, save_on_quit),
	    get(NB, note, Id, Note),
	    get(NB, hypered, object, Optica),
	    get(Note, state, State),
	    send(Optica, restore_state, State),
	    send(NB, destroy),
	    log(resumed_state_of_note(Id)),
	    log(end(notebook))
	).


note(NB, Id:name, Note:note) :<-
	"Fetch note from Id"::
	get(NB, member, browser, B),
	get(B, member, Id, Note).


editable(NB, Val:bool) :->
	get(NB, member, view, View),
	send(View, editable, Val),
	send(View?text_cursor, displayed, Val).


selection(NB, Note:note) :->
	send(NB, save_current),
	get(NB, member, view, View),
	get(NB, member, browser, B),
	get(NB, member, note_state, WS),
	send(View, contents, Note?object),
	send(View, modified, @off),
	send(Note?state, restore, WS),
	get(Note, key, Id),
	(   get(NB, current, Id)
	->  send(NB, editable, @on),
	    message(enter_note, Message)
	;   send(NB, editable, @off),
	    message(view_note, Message)
	),
	send(NB, report, status, Message),
	send(NB, slot, selection, Id),
	send(B, selection, Note),
	log(view(Id)).


view(NB, Id:name) :->
	"View note with given id"::
	get(NB, note, Id, Note),
	get(NB, member, view, View),
	get(NB, member, browser, B),
	get(NB, member, note_state, WS),
	send(View, contents, Note?object),
	send(View, modified, @off),
	send(Note?state, restore, WS),
	get(Note, key, Id),
	send(NB, editable, @off),
	message(view_note, Message),
	send(NB, report, status, Message),
	send(NB, slot, selection, Id),
	send(B, selection, Note).


save_current(NB) :->
	(   get(NB, current, Id),
	    get(NB, selection, Id)	% viewing the current note
	->  get(NB, member, view, View),
	    get(NB, note, Id, NoteObj),
	    send(NoteObj, text, View?contents)
	;   true
	).


log_saved(_NB, Note:note) :->
	"Make a record in the log database"::
	get(Note, key, Key),
	get(Note?label, value, Label),
	get(Note?text, value, NoteText),
	get(Note, state, State),
	state_to_term(State, TermState),
	(   send(State, has_get_method, experiment),
	    get(State, experiment, Exp)
	->  log(note(Key, Label, Exp, NoteText, TermState))
	;   log(note(Key, Label, NoteText, TermState))
	).


save_on_quit(NB) :->
	"Query save on quit"::
	send(NB, save_current),
	get(NB, current, Id),
	get(NB, note, Id, Note),
	(   get(Note, text, Text),
	    get(Text, size, Size),
	    Size > 0			% text has been entered
	->  new(Label, string('%s', Text)),
	    (	get(Label, size, Size),
		Size < 15
	    ->	true
	    ;   send(Label, truncate, 10),
		send(Label, append, ' ...')
	    ),
	    message(note_save_note, Purpose)
	;   Label = '',
	    message(note_save_state, Purpose)
	),
	new(D, transient_dialog(NB, confirm_save)),
	send(D, append, label(purpose, Purpose)),
	send(D, append, new(LI, text_item(label, Label))),
	send(D, append,
	     button(save, and(message(D, return, LI?selection?value)))),
	send(D, append,
	     button(discard_note, message(D, return, @default))),
	send(D, append,
	     button(cancel_save_note, message(D, return, @nil))),
	repeat,
	    get(D, confirm_centered, Answer),
	    (   Answer == ''
	    ->  send(D, error, no_label_specified),
		fail
	    ;   true
	    ), !,
	send(D, destroy),
	(   atom(Answer)
	->  send(Note, label, Answer),
	    send(NB, log_saved, Note)
	;   Answer == @default
	->  free(Note)
	).


new(NB) :->
	"Create a new note, copy current state"::
	get(NB, member, view, View),		% Prepare view
	send(View, clear),
	send(View, modified, @off),
	send(NB, editable, @on),

	message(current_state, Label),		% Prepare note
	get(NB, member, browser, B),
	get(B?dict?members, size, N),
	NN is N + 1,
	atom_concat('note-', NN, Name),
	send(B, append, new(NObj, note(Name, Label))),
	send(NB, slot, current, Name),
	send(NB, slot, selection, Name),
	send(B, selection, Name),

	get(NB, hypered, object, Optica),	% fetch state
	get(Optica, state, Scene),
	get(NB, member, note_state, WS),
	send(Scene, restore, WS),
	send(NObj, slot, state, Scene),

	message(enter_note, Text),
	send(NB, report, status, Text).		% report status

:- pce_end_class.

:- pce_begin_class(note_database, dict, "Database of notes").

:- pce_end_class.

:- pce_begin_class(note, dict_item, "A Note").

variable(state,	     scene_state, both, "Associated state").
variable(experiment, name*,	  both, "Related experiment").

text(Note, Txt:string) :->
	send(Txt, strip),
	send(Note, object, Txt).
text(Note, Txt:string) :<-
	get(Note, object, Txt).

:- pce_end_class.
