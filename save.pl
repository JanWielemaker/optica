/*  $Id: save.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(opt_save,
	  [ slot_states/4,		% +Scene, +Object, +Slots, -State
	    slot_states/3,		% +Scene, +Object, -State
	    state_to_term/2,		% ?State, ?Term
	    instrument_state/1,		% +Slots
	    instrument_state/2,		% +Class, -Slots
	    make_instrument/3		% +Class, +Slots, -Object
	  ]).
:- use_module(library(pce)).
:- use_module(pretty_print).
:- require([ chain_list/2
	   , exists_file/1
	   , forall/2
	   , get_chain/3
	   , get_object/3
	   , maplist/3
	   , member/2
	   , select/3
	   , send_list/3
	   , source_location/2
	   ]).

		 /*******************************
		 *      STATE DECLARATIONS	*
		 *******************************/

:- dynamic
	instrument_state_db/2.

instrument_state(State) :-
	pce_compiling(Class),
	retractall(instrument_state_db(Class, _)),
	assert(instrument_state_db(Class, State)).

instrument_state(Class, Slots) :-
	superclass(Class, Super),
	instrument_state_db(Super, Slots), !.

superclass(Class, Class).
superclass(ClassName, Super) :-
	get(@pce, convert, ClassName, class, Class),
	get(Class, super_class_name, Super0),
	superclass(Super0, Super).


		 /*******************************
		 *       STATE OF OBJECT	*
		 *******************************/

slot_states(Scene, Object, State) :-
	get(Object, class_name, Class),
	instrument_state(Class, Slots),
	slot_states(Scene, Object, Slots, State).

generic_attribute(read_only,		false).
generic_attribute(instrument_name,	-).

slot_states(Scene, Object, Slots, State) :-
	new(State, chain),
	slot_values(Slots, Scene, Object, State),
	(   generic_attribute(Name, Default),
	    send(Object, has_get_method, Name),
	    get(Object, Name, Value0),
	    primitive_value(Value0, Value),
	    Value \== Default,
	    send(State, append, attribute(Name, Value)),
	    fail
	;   true
	).

slot_values([], _, _, _).
slot_values([Slot|T], Scene, Object, State) :-
	slot_value(Scene, Object, Slot, Attribute), !,
	send(State, append, Attribute),
	slot_values(T, Scene, Object, State).
slot_values([_|T], Scene, Object, State) :-
	slot_values(T, Scene, Object, State).

slot_value(Scene, Object, Slot, attribute(Slot, Value)) :-
	get(Object, Slot, Value0),
	(   primitive_value(Value0, Value)
	->  true
	;   (   device_with_state(Value0, Value1)
	    ->	true
	    ;	Value1 = Value0
	    ),
	    (	Scene \== @nil,
		get(Scene, done, Done),
		Done \== @nil,
		send(Value1, has_get_method, state)
	    ->	get(Scene, save_state, Value1, Value2),
		get(Value2, name, Value)
	    ;   send(Value1, instance_of, graphical)
	    ->  get(Value1, name, Value)
	    )
	).

device_with_state(@nil, _) :- !,
	fail.
device_with_state(Gr, Gr) :-
	send(Gr, has_get_method, state), !.
device_with_state(Gr0, Gr) :-
	get(Gr0, device, Gr1),
	\+ send(Gr1, instance_of, window),
	device_with_state(Gr1, Gr).

primitive_value(Value, Value) :-
	atomic(Value).
primitive_value(@on, true).
primitive_value(@off, false).
primitive_value(@nil, -).
primitive_value(@default, *).
	
:- pce_begin_class(object_state, object, "State description of an object").

variable(type,		name,	get, "Type of the object").
variable(name, 		name,	get, "Name of the object").
variable(state,		chain,  get, "List of attributes").

snap(OS, S:scene_state, Obj:[object]) :->
	"Save the state of the argument object"::
	(   Obj \== @default
	->  get(Obj, functor, Type),
	    get(Obj, name, Name),
	    get(Obj, state, S, Attributes),
	    send(OS, slot, name, Name),
	    send(OS, slot, type, Type),
	    send(OS, slot, state, Attributes)
	;   true
	).


restore(OS, Obj:object) :<-
	"Recreate the object"::
	get(OS, type, Type),
	get_chain(OS, state, Attributes),
	maplist(prolog_attribute, Attributes, Atts),
	make_instrument(Type, Atts, Obj),
	get(OS, name, Name),
	send(Obj, name, Name).

prolog_attribute(A, Name=Value) :-
	nonvar(A), !,
	get(A, name, Name),
	get(A, value, Value).

make_instrument(ClassName, Atts0, Obj) :-
	get(@pce, convert, ClassName, class, Class),
	get_object(Class, term_names, TermNameVector),
	TermNameVector =.. [vector|TermNames],
	init_args(TermNames, Atts0, InitArgs, Atts1),
	NewTerm =.. [ClassName|InitArgs],
	new(Obj, NewTerm),
	forall(member(Name=Value, Atts1),
	       set_instrument_attribute(Obj, Name, Value)).
	
prolog_to_saved_value(*, @default) :- !.
prolog_to_saved_value(Val, Val).

init_args([], Atts, [], Atts).
init_args([N|TN], Atts0, [V|TV], Atts) :-
	select(Atts0, N=PV, Atts1), !,
	prolog_to_saved_value(PV, V),
	init_args(TN, Atts1, TV, Atts).
init_args([A|TN], Atts0, [@default|InitArgs], [A|Atts]) :-
	init_args(TN, Atts0, InitArgs, Atts).

set_instrument_attribute(I, instrument_name, PlValue) :- !,
	prolog_to_saved_value(PlValue, Value),
	send(I, slot, instrument_name, Value).
set_instrument_attribute(I, Name, PlValue) :-
	prolog_to_saved_value(PlValue, Value),
	send(I, Name, Value).


:- pce_end_class.


:- pce_begin_class(scene_state, chain, "State description of a scene").

variable(name,		name,	     get,  "Name of the state").
variable(description,	string*,     both, "Description of the state").
variable(done,		hash_table*, get,  "Hash-table of mapped objects").
variable(experiment,	name*,	     get,  "Experiment the state belongs to").

initialise(S, Name:name) :->
	send(S, send_super, initialise),
	send(S, slot, name, Name).

snap(S, OW:optical_workspace) :->
	"Make a snapshot of an optical workspace"::
	send(S, clear),
	send(S, slot, done, new(hash_table)),
	send(OW?graphicals, for_all,
	     if(and(message(@arg1, has_get_method, state),
		    not(message(@arg1, instance_of, eye_image))),
		?(S, save_state, @arg1))),
	send(S, slot, done, @nil),
	(   get(OW, experiment, Exp)
	->  send(S, slot, experiment, Exp)
	;   send(S, slot, experiment, @nil)
	).

save_state(S, Obj:object, State:object_state) :<-
	get(S, done, Done),
	(   Done \== @nil,
	    get(Done, member, Obj, State)
	->  true
	;   new(State, object_state),
	    (	Done \== @nil
	    ->  send(Done, append, Obj, State)
	    ;	true
	    ),
	    send(State, snap, S, Obj),
	    send(S, append, State)
	).

:- pce_global(@optical_workspace,
	      new(var('window*', optical_workspace, @nil))).

restore(S, OW:optical_workspace) :->
	"Restore this state"::
	send(OW, clear, @on),
	send(@optical_workspace, assign, OW),
	send(S, for_all,
	     message(OW, display, @arg1?restore)),
	send(OW, resized),
	send(OW, restore_gauges).

pretty_print(S) :->
	state_to_term(S, Term),
	nl,
	pretty_print(Term).

:- pce_end_class.


state_to_term(S, state(Name, Description, Contents)) :-
	nonvar(S), !,
	get(S, name, Name),
	chain_list(S, StateObjects),
	maplist(state_object_to_term, StateObjects, Contents),
	get(S, description, D0),
	(   D0 == @nil
	->  Description = ''
	;   get(D0, value, Description)
	).
state_to_term(S, state(Name, Description, Contents)) :- !,
	new(S, scene_state(Name)),
	maplist(state_object_to_term, StateObjects, Contents),
	send_list(S, append, StateObjects),
	(   Description \== ''
	->  send(S, description, string('%s', Description))
	;   true
	).
state_to_term(S, []) :- !,
	new(S, scene_state(empty)).


%	convert_old_term(+Old, -New)
%	
%	Convert between 0.6 version format and new format, where all lenses
%	have been unified.

convert_old_term(thicklens(radius(R),
			   thickness(T),
			   sfere_left(SL0),
			   sfere_right(SR0),
			   breaking_index(BI),
			   pos_x(X)),
		 lens(radius(R),
		      thickness(T),
		      sfere_left(SL),
		      sfere_right(SR),
		      breaking_index(BI),
		      pos_x(X))) :- !,
	SL is SL0/R*100,
	SR is SR0/R*100.
convert_old_term(neglens(radius(R),
			 thickness(T),
			 focal_distance(FD),
			 pos_x(X)),
		 lens(radius(R),
		      thickness(T),
		      focal_distance(FD),
		      pos_x(X))) :- !.
convert_old_term(poslens(radius(R),
			 thickness(T),
			 focal_distance(FD),
			 pos_x(X)),
		 lens(radius(R),
		      thickness(T),
		      focal_distance(FD),
		      pos_x(X))) :- !.
					% rulers changed to allow heights
convert_old_term(ruler(From, To, pos_y(Offset)),
		 ruler(From, To, offset(Offset))) :- !.
convert_old_term(ruler(From, To, pos_y(Offset), VarName),
		 ruler(From, To, offset(Offset), VarName)) :- !.
					% Catch all
convert_old_term(Term, Term).

state_object_to_term(SO, Name = Term) :-
	nonvar(SO), !,
	get(SO, type, Type),
	get(SO, name, Name),
	get_chain(SO, state, Attributes),
	maplist(attribute_to_term, Attributes, Terms),
	Term =.. [Type|Terms].
state_object_to_term(SO, Name = Term0) :-
	new(SO, object_state),
	convert_old_term(Term0, Term),
	Term =.. [Type|PlAtts],
	maplist(attribute_to_term, Attributes, PlAtts),
	chain_list(State, Attributes),
	send(SO, slot, name, Name),
	send(SO, slot, type, Type),
	send(SO, slot, state, State).


attribute_to_term(A, Term) :-
	nonvar(A), !,
	get(A, name, Name),
	get(A, value, Value),
	Term =.. [Name,Value].
attribute_to_term(A, Term) :-
	Term =.. [Name, Value],
	ATerm =.. [attribute, Name, Value],
	new(A, ATerm).


		 /*******************************
		 *	      DATABASE		*
		 *******************************/
	
:- pce_global(@optica_states, new(optica_database)).

default_database(File) :-
	absolute_file_name(optica('StateDB'), File).

:- pce_begin_class(optica_database, dict).

append(DB, State:scene_state, Save:[bool]) :->
	get(State, name, Name),
	send(DB, send_super, append,
	     dict_item(Name, @default, State)),
	(   Save \== @off
	->  state_to_term(State, Term),
	    default_database(DBFile),
	    open(DBFile, append, Stream),
	    pretty_print(Stream, Term),
	    close(Stream)
	;   true
	).

restore(DB, OW:optical_workspace, Name:name) :->
	"Restore named state"::
	get(DB, member, Name, DI),
	send(DI?object, restore, OW).

read(DB, F:file) :->
	get(F, name, Name),
	open(Name, read, Fd),
	read(Fd, T0),
	read_states(T0, DB, Fd),
	close(Fd).

read_states(end_of_file, _, _) :- !.
read_states(Term, DB, Fd) :-
	state_to_term(State, Term), !,
	send(DB, append, State, @off),
	read(Fd, T2),
	read_states(T2, DB, Fd).
read_states(_, DB, Fd) :-
	source_location(File, Line),
	format(user_error, 'Failed to read state from ~w:~w~n', [File:Line]),
	read(Fd, T2),
	read_states(T2, DB, Fd).

read_default_states(DB) :->
	(   default_database(DBFile),
	    exists_file(DBFile)
	->  send(DB, read, DBFile)
	;   true
	).

:- pce_end_class.


