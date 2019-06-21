/*  $Id: stress.pl,v 1.6 2002/01/22 20:11:51 jan Exp $

    Part of OPTICA
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 2000 University of Amsterdam. All rights reserved.
*/


:- module(stress,
	  [ stress/0,
	    stress/1,
	    show/2,			% +Id
	    tip/3			% Fase, Time, Id
	  ]).
:- print_message(informational, format('        Stress pluggin', [])).

:- use_module(library(pce)).
:- use_module(library(broadcast)).
:- use_module(optica(pretty_print)).
:- use_module(tipper).

:- multifile
	xml:parameter/1,
	user:file_search_path/2.

user:file_search_path(doc,	optica('stress/html')).
user:file_search_path(dtd,	optica('stress/dtd')).
user:file_search_path(library,	optica('stress/lib')).

:- use_module(doc(html)).
:- use_module(doc(util)).
:- use_module(doc(layout)).
:- use_module(doc(objects)).
:- use_module(library(dcg_basics)).
:- use_module(library(autowin)).

:- pce_autoload(partof_hyper, library(hyper)).

		 /*******************************
		 *	 OPTICA RELATIONS	*
		 *******************************/

:- initialization
   listen(optica(_, activate(stress(File))),
	  activate(File)),
   listen(optica(O, open(experiment(Exp, Offset))),
	  open_fase(O, Exp, Offset)).

activate(Spec) :-
	absolute_file_name(Spec,
			   [ access(read),
			     extensions([sgml])
			   ],
			   SgmlFile),
	load_data(SgmlFile).


		 /*******************************
		 *	       DEBUG		*
		 *******************************/

show(Id) :-
	load_data('stress.sgml'),
	send(stress_frame(Id), open).

stress :-
	stress('stress.sgml').

stress(File) :-
	load_data(File),
	send(new(stress_tester), open).

:- pce_begin_class(stress_tester, frame).

initialise(F) :->
	send_super(F, initialise, 'Test stress tool'),
	send(F, append, new(D, dialog)),
	send(new(B, browser), above, D),
	send(B, select_message, message(@prolog, show, F, @arg1?key)),
	forall(element(Id, _, Options, _),
	       ( option(title(Title), Options, ''),
		 send(B, append,
		      dict_item(Id, string('%s: %s', Id, Title)))
	       )),
	send(D, append,
	     new(M, menu(fase,
			 choice,
			 and(message(@receiver, selection, @arg1),
			     message(@prolog, open_fase, F, @arg1))))),
	send(M, multiple_selection, @on),
	findall(Fase, interrupt(Fase, _, _), Fs),
	list_to_set(Fs, Fasen),
	send_list(M, append, Fasen).

:- pce_end_class.


		 /*******************************
		 *	       SHOW		*
		 *******************************/

:- pce_begin_class(stress_frame, frame,
		   "Show a stress question").

variable(id,	  name,	get, "Id of current question").
variable(element, name, get, "Element (class) name of this Id").
variable(is_modal,name, get, "Is frame used in modal state").

initialise(F, Id:name, Model:[{true,false}]) :->
	"Create from content"::
	default(Model, true, IsModal),
	send(F, slot, is_modal, IsModal),
	element(Id, Class, Options, Content),
	send(F, slot, id, Id),
	send(F, slot, element, Class),
	option(title(Title), Options, ''),
	send_super(F, initialise, Title),
	send(F, append, new(W, auto_sized_picture)),
	send(F, done_message, message(W, flash)),
	id_option(Id, bgcolor(BGColor), grey80),
	(   catch(new(BG, colour(BGColor)), _, fail)
	->  true
	;   BG = colour(grey80)
	),
	send(W, background, BG),
	send(W, display, new(P, pbox(500))),
	send(P, auto_crop, @off),
	send(W, resize_message, message(P, line_width, @arg2?width-20)),
	new(M, doc_mode),
	(   base_url(Base)
	->  send(M, base_url, Base)
	;   true
	),
	send(P, show,
	     [ \ignorespaces,
	       element(Class, Options, Content)
	     ], M),
	(   Class == tip,
	    id_option(Id, modal(X), true),
	    X == true
	->  send(P, show,
		 [ element(ok, [], [])
		 ], M)
	;   true
	),
	Log =.. [Class, Id],
	(   IsModal == true
	->  broadcast(log(begin(Log)))
	;   broadcast(log(Log))
	).
	
ok(F, Ok:button) :->
	"User pressed ok button"::
	get(F, id, Id),
	(   get(Ok, hypered, control, DI)
	->  get(DI, selection, Answer0),
	    clean_answer(Answer0, Answer),
	    broadcast(log(answer(Id, Answer)))
	;   true
	),
	element(Id, Class, _, _),
	Log =.. [Class, Id],
	(   get(F, is_modal, true)
	->  broadcast(log(end(Log)))
	;   broadcast(log(remove(Log)))
	),
	send(F, destroy).

clean_answer(Chain, Head) :-
	send(Chain, instance_of, chain),
	get(Chain, size, 1), !,
	get(Chain, head, Head).
clean_answer(Value, Value).

:- pce_end_class.

:- multifile
	html:element/5.

html:element(question, _, Content) -->
	Content.
html:element(tip, _, Content) -->
	Content.
html(element(ok, [], [])) -->
	ok(@nil).

html:element(qbody, _, Content) -->
	Content,
	[ \par
	].
html:element(slider, _, Content) -->
	{ content(Content, from, From),
	  content(Content, to, To), !,
	  new(B, grbox(new(S, slider(answer, 0, 10, 5,
				     message(@receiver, send_hyper,
					     ok, active, @on))),
		       center)),
	  send(S, show_label, @off),
	  send(S, show_value, @off),
	  send(S, drag, @on),
	  append([ \setfont(weight, bold)
		 | From
		 ],
		 [ ' ', B, ' '
		 | To
		 ],
		 BoxContent)
	},
	[ \par,
	  @hfill,
	  \parbox(BoxContent,
		  [ width(500),
		    auto_crop(true)
		  ]),
	  @hfill,
	  \par
	],
	ok(S).
html:element(choose, _, Content) -->
	{ new(B, grbox(new(S, menu(answer, marked,
				   and(message(@receiver, selection, @arg1),
				       message(@receiver, send_hyper,
					       ok, active, @on)))),
		       center)),
	  send(S, multiple_selection, @on),
	  send(S, show_label, @off),
	  send(S, layout, vertical),
	  forall(content(Content, choice, Option),
		 add_option(S, Option))
	},
	[ \par,
	  @hfill,
	  B,
	  @hfill,
	  \par
	],
	ok(S).

add_option(S, [Cdata]) :-
	new(Item, string('%s', Cdata)),
	send(Item, strip),
	send(S, append, Item?value).

ok(For) -->
	{ new(Ok, button(ok, message(@browser, ok, @receiver))),
	  (   label(ok, Label)
	  ->  send(Ok, label, Label)
	  ;   true
	  ),
	  (   For \== @nil
	  ->  send(Ok, active, @off),
	      new(_, hyper(For, Ok, ok, control))
	  ;   true
	  ),
	  new(Box, grbox(Ok))
	},
	[ \par,
	  @hfill,
	  Box,
	  @br
	].
	  
content(element(E, _, C), E, C).
content(element(_, _, C0), T, C) :-
	content(C0, T, C).
content([H|_], E, C) :-
	content(H, E, C).
content([_|T], E, C) :-
	content(T, E, C).


		 /*******************************
		 *	    SCHEDULING		*
		 *******************************/

open_fase(Frame, Fase) :-
	open_fase(Frame, Fase, 0).

open_fase(Frame, Fase, Offset) :-
	format('Scheduling interrupts for experiment ~w, start time = ~w~n',
	       [Fase, Offset]),
	close_timers(Frame),
	(   interrupt(Fase, Time, Id),
	    FromNow = Time - Offset,
	    FromNow >= 0,
	    format('  ~w~n', [Id]),
	    new(T, timer(FromNow, message(@prolog, show_from_timer,
					  @receiver, Id))),
	    new(_, partof_hyper(Frame, T, stress_timer, application)),
	    send(T, status, once),
	    fail
	;   true
	).

show_from_timer(Timer, Id) :-
	get(Timer, hypered, application, Frame),
	free(Timer),
	show(Frame, Id).

show(Frame, Id) :-
	send(Frame, wait),		% make sure it is visible
	id_option(Id, modal(Modal), true),
	new(SF, stress_frame(Id, Modal)),
	id_option(Id, valign(VAlign), center),
	send(SF, transient_for, Frame),
	(   Modal == true		% modal subframe
	->  send(SF, modal, transient)
	;   element(Id, Class, _, _),	% destroy shown object
	    get(Frame, transients, Open),
	    Open \== @nil,
	    get(Open, find, and(@arg1?element == Class,
				@arg1 \== SF),
		Old)
	->  send(Old, destroy)
	;   true
	),
	get(Frame, area, Area),
	(   VAlign == center
	->  send(SF, open_centered, Area?center)
	;   VAlign == top
	->  send(SF, create),
	    get(SF?area, height, H),
	    send(SF, open_centered,
		 point(Area?center?x,
		       Area?y + H/2))
	;   VAlign == above
	->  send(SF, create),
	    get(SF?area, height, H),
	    send(SF, open_centered,
		 point(Area?center?x,
		       Area?y - H - 30))
	).


id_option(Id, Option, Default) :-
	element(Id, Class, Options, _),
	(   option(Option, Options)
	->  true
	;   functor(Option, Name, 1),
	    attribute_default(Class, Name, Value)
	->  arg(1, Option, Value)
	;   arg(1, Option, Default)
	).


close_timers(Frame) :-
	send(Frame, send_hyper, stress_timer, free), !.
close_timers(_).


		 /*******************************
		 *	     DATABASE		*
		 *******************************/


:- dynamic
	attribute_default/3,		% Element, Attribute, Value
	element/4,			% Id, Class, Options, Content
	interrupt/3,			% Fase, Time, Id
	tip/3,				% Fase, Time, Id
	label/2,			% Id, Text
	base_url/1.			% URL

load_data(File) :-
	retractall(element(_, _, _, _)),
	retractall(interrupt(_, _, _)),
	retractall(tip(_,_,_)),
	retractall(label(_,_)),
	retractall(base_url(_)),
	retractall(attribute_default(_,_,_)),
	atom_concat('file:', File, BaseUrl),
	assert(base_url(BaseUrl)),
	load_sgml_file(File, Term),
%	pretty_print(Term),
	Term = document(_, [element(stress, _, Stress)]),
	assert_elements(Stress).

assert_elements([]).
assert_elements([H|T]) :- !,
	assert_element(H),
	assert_elements(T).

assert_element(element(fase, Options, Content)) :- !,
	option(id(Fase), Options),
	assert_fase(Content, Fase).
assert_element(element(message, Options, [Text])) :- !,
	option(id(Id), Options),
	new(S, string('%s', Text)),
	send(S, strip),
	get(S, value, Label),
	assert(label(Id, Label)).
assert_element(element(default, Options, _)) :- !,
	option(element(E), Options),
	option(attribute(A), Options),
	option(value(V), Options),
	assert(attribute_default(E, A, V)).

assert_element(element(Class, Options, Content)) :-
	option(id(Id), Options), !,
	assert(element(Id, Class, Options, Content)).
assert_element(X) :-
	print_message(warning, not_processed(X)).

assert_fase([], _).
assert_fase([element(showtip, Options, _)|T], Fase) :- !,
	option(id(Id), Options),
	option(time(TimeSpec), Options),
	parse_time(TimeSpec, Seconds),
	assert(tip(Fase, Seconds, Id)),
	assert_fase(T, Fase).
assert_fase([element(interrupt, Options, _)|T], Fase) :-
	option(time(TimeSpec), Options),
	parse_time(TimeSpec, Seconds),
	option(show(Id), Options),
	assert(interrupt(Fase, Seconds, Id)),
	assert_fase(T, Fase).


		 /*******************************
		 *	       TIME		*
		 *******************************/

parse_time(Spec, Time) :-
	atom_codes(Spec, Chars),
	phrase(time(Time), Chars).

time(Time) -->
	number(Min),
	":",
	number(Sec), !,
	{ Time is Min*60 + Sec
	}.
time(Time) -->
	number(N),
	blanks,
	time_unit(Unit),
	blanks,
	{ Time is N * Unit
	}.

time_unit(1)    --> "sec", !.
time_unit(60)   --> "min", !.
time_unit(3600) --> "hour", !.
time_unit(1)    --> [].

		 /*******************************
		 *	      MESSAGES		*
		 *******************************/

:- multifile
	prolog:message/3.

prolog:message(not_processed(element(Tag, _, _))) -->
	[ 'Not processed: <~w>'-[Tag] ].
