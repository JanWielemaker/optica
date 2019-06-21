/*  $Id: hypothesis.pl,v 1.2 1999/11/18 16:17:19 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(hypothesis, []).
:- use_module(library(pce)).
:- use_module(util).
:- use_module(formula).
:- use_module(plotter).
:- use_module(table).
:- use_module(language).
:- require([ between/3
	   , ceiling/2
	   , chain_list/2
	   , concat/3
	   , default/3
	   , floor/2
	   , forall/2
	   , get_chain/3
	   , ignore/1
	   , log10/2
	   , maplist/3
	   , member/2
	   , msort/2
	   , pow/3
	   , sublist/3
	   , subset/2
	   ]).


		 /*******************************
		 *	       TOOLS		*
		 *******************************/

tool(table,
     [ image('table.xpm'),
       tag(english, 'Create a measurement table'),
       tag(dutch, 'Maak een meetwaardetabel'),
       action(table)
     ]).

tool(separator, []).

tool(measure,
     [ image('measure.xpm'),
       tag(english, 'Read gauges and add row to table'),
       tag(dutch, 'Lees meetinstrumenten en voeg rij aan tabel toe'),
       action(measure)
     ]).

tool(separator, []).

tool(delete_last_row,
     [ image('dellastrow.xpm'),
       tag(english, 'Delete last measurement of table'),
       tag(dutch, 'Verwijder de laatste rij meetwaarden'),
       action(delete_last_row)
     ]).
tool(delete_table_column,
     [ image('delcolumn.xpm'),
       tag(english, 'Delete selected column from table'),
       tag(dutch, 'Verwijder geselekteerde kolom'),
       action(delete_table_column)
     ]).
/*
tool(clear_diagram,
     [ image('wipediagram.xpm'),
       tag(english, 'Clear the plot window'),
       tag(dutch, 'Verwijder grafiek'),
       action(clear_diagram)
     ]).
*/


current_tool(Name, Attributes) :-
	tool(Name, AllAtts),
	subset(Attributes, AllAtts).


		 /*******************************
		 *	    MAIN WINDOW		*
		 *******************************/

:- pce_begin_class(hypothesis_editor, frame, "The Hypothesis Editor").

initialise(SP, Label:[name]) :->
	default(Label, 'Functie anlyse', TheLabel),
	send(SP, send_super, initialise, TheLabel),

	send(SP, append, new(D2, dialog)),
	
	make_window(TW, table_window,   measurements),
	make_window(DW, diagram_window, diagram),
	make_window(FW, formula_window, formulas),
	new(FM, formula_menu),

	send(FW, height, 120),
	send(DW, height, 150),
	send(TW, width, 250),

	send(TW, below, D2),
	send(FM, above, FW),
	send(DW, below, FW),
	send(FM, right, TW),

	send(D2, name, tool_dialog),
	send(D2, gap, size(0, 5)),

	send(SP, add_tools).

make_window(W, Class, Title) :-
	new(W, Class),
	message(Title, Label),
	send(W, label, Label).


add_tools(SP) :->
	get(SP, member, tool_dialog, D),
	(   current_language(Lan),
	    tool(Name, _),
	    (	Name == separator
	    ->	send(D, append, graphical(0,0,10,0), right)
	    ;   current_tool(Name,
			     [ image(Image),
			       action(Action),
			       tag(Lan, Tag)
			     ]),
		send(D, append,
		     new(B, button(Name, message(SP, Action))),
		     right),
		send(B, label, image(Image)),
		send(B, help_message, tag, Tag)
	    ),
	    fail
	;   true
	).

:- pce_group(parts).

table(HE, Tab:measurement_table) :<-
	"Find the currently displayed table"::
	get(HE, member, table_window, Window),
	get(Window, member, measurement_table, Tab).

:- pce_group(measure).

measure(HE) :->
	"Add values to the table"::
	(   get(HE, table, Tab)
	->  send(Tab, measure)
	;   send(HE, report, error, 'No table')
	).


delete_last_row(HE) :->
	"Delete last column from the table"::
	(   get(HE, table, Tab)
	->  send(Tab, delete_last_row)
	;   send(HE, report, error, 'No table')
	).


delete_table_column(HE) :->
	"Delete last column from the table"::
	(   get(HE, table, Tab)
	->  send(Tab, delete_column)
	;   send(HE, report, error, 'No table')
	).


clear_diagram(HE) :->
	"Clear the diagram window"::
	get(HE, member, diagram_window, DW),
	send(DW, clear).


table(HE) :->
	"Add/replace the measurement table"::
	get(HE, hypered, simulator, Simulator),
	get(Simulator, gauges, Gauges),
	(   send(Gauges, empty)
	->  send(HE, report, error, 'No values in scene'),
	    fail
	;   true
	),
	(   get(HE, table, Old)
	->  send(@display, confirm, 'Delete old table?'),
	    send(Old, destroy)
	;   true
	),
	get(HE, member, table_window, Window),
	send(Window, clear),
	send(Window, display, new(T, measurement_table)),
%	name_gauges(Gauges),
	sort_gauges(Gauges, KeyedSortedList),
	forall(member(_K-G, KeyedSortedList), send(T, gauge, G)),
	send(Window, recenter).

renamed_gauge(HE, G:object) :->
	"A gauge has been renamed"::
	(   get(HE, table, Tab)
	->  send(Tab, renamed_gauge, G)
	;   true
	).

%	sort_gauges(+Gauges)
%
%	Sort gauges by type and name

sort_gauges(Gauges, KeyedSorted) :-
	chain_list(Gauges, L0),
	maplist(sort_gauge_key, L0, L1),
	keysort(L1, KeyedSorted).

sort_gauge_key(G, t(Type, Name)-G) :-
	(   send(G, instance_of, lens)
	->  Type = a
	;   send(G, instance_of, ruler)
	->  Type = b
	;   Type = c
	),
	get(G, name, Name).

%	name_gauges(+Gauges)
%
%	Give the members of the chain of gauge unique names.  This is very
%	tricky.

name_gauges(Gauges) :-
	chain_list(Gauges, List),
	maplist(gauge_id, List, Id0),
	extract_explicit_named(Id0, Id1, Names),
	(   no_duplicates(Names)
	->  msort(Id1, Sorted),
	    assign_names(Sorted, Names)
	;   send(@display, inform, 'Duplicate names'),
	    fail
	).

extract_explicit_named([], [], []).
extract_explicit_named([gauge(Base, _, Name, _)|T0], T, [Name|TN]) :-
	\+ implicit_name(Name, Base), !,
	extract_explicit_named(T0, T, TN).
extract_explicit_named([G|T0], [G|T], Names) :-
	extract_explicit_named(T0, T, Names).

implicit_name('', _) :- !.
implicit_name(Base, Base) :- !.
implicit_name(Name, Base) :-
	atom_concat(Base, A, Name),
	atom_codes(A, Chars),
	name(N, Chars),
	integer(N).

no_duplicates(Set) :-
	sort(Set, Sorted),
	same_length(Set, Sorted).

same_length([], []).
same_length([_|T1], [_|T2]) :-
	same_length(T1, T2).

assign_names([G0|T0], Names0) :-
	same_base_gauges(G0, T0, Gs, T),
	assign_names_for_group([G0|Gs], Names0, Names),
	assign_names(T, Names).
assign_names([], _).

same_base_gauges(G0, [G1|T0], [G1|TS], T) :-
	same_base(G0, G1), !,
	same_base_gauges(G0, T0, TS, T).
same_base_gauges(_, T, [], T).

same_base(G0, G1) :-
	arg(1, G0, B),
	arg(1, G1, B).

assign_names_for_group([gauge(Base, _, _, G)], Names, [Base|Names]) :- !,
	send(G, name, Base).
assign_names_for_group(G, Names0, Names) :-
	assign_names_for_group(G, 1, Names0, Names).

assign_names_for_group([], _, Names, Names).
assign_names_for_group([gauge(Base, _, _, G)|T], N, Names0, Names) :- !,
	atom_concat(Base, N, BaseN),
	send(G, name, BaseN),
	NN is N + 1,
	assign_names_for_group(T, NN, [BaseN|Names0], Names).
	
gauge_id(Gauge, gauge(Base, X, Name, Gauge)) :-
	get(Gauge, x, X),
	get(Gauge, name, Name),
	basename(Name, Gauge, Base).

basename('', Gauge, f) :-
	send(Gauge, instance_of, lens), !.
basename('', _, d) :- !.
basename(Name, _, Base) :-
	atom_codes(Name, Chars),
	sublist(letter, Chars, Letters),
	atom_codes(Base, Letters).
	
letter(C) :- between(0'a, 0'z, C).
letter(C) :- between(0'A, 0'Z, C).

:- pce_end_class.


:- pce_begin_class(table_window, window, "Window for the table-field").

initialise(TW) :->
	send(TW, send_super, initialise),
	send(TW, resize_message, message(TW, recenter)).

recenter(T) :->
	get(T, member, measurement_table, Tab),
	get(T?visible, center, C),
	send(Tab, center, C).

changed_union(T, _Args:any ...) :->
	(   get(T, attribute, changing_union, _)
	->  true
	;   send(T, attribute, changing_union, @on),
	    send(T, recenter),
	    send(T, delete_attribute, changing_union)
	).

:- pce_end_class.


:- pce_begin_class(diagram_window, window, "Window for the diagram").

initialise(DW) :->
	send(DW, send_super, initialise),
	send(DW, resize_message, message(DW, resized)).

resized(DW) :->
	get(DW?visible, size, size(W, H)),
	get(DW, plotter, Plotter),
	(   get(Plotter, x_axis, XAsis)
	->  send(XAsis, length, W-40)
	;   true
	),
	(   get(Plotter, y_axis, YAsis)
	->  send(YAsis, length, H-40)
	;   true
	),
	send(DW, plot),
	send(DW, recenter).


recenter(DW) :->
	(   get(DW, member, plotter, Plotter)
	->  send(Plotter, compute),
	    get(DW, visible, area(AX,AY,_AW,AH)),
	    get(Plotter, height, H),
	    send(Plotter, do_set, AX+5, AY+AH-H-5)
	;   true
	).


plotter(DW, Plotter:plotter) :<-
	(   get(DW, member, plotter, Plotter)
	->  true
	;   send(DW, display, new(Plotter, plotter))
	).

drop_axis(DW, Pos:point, Type:{x,y}) :<-
	"Which axis are we missing"::
	get(DW, plotter, Plotter),
	(   get(Plotter, x_axis, _)
	->  (   get(Plotter, y_axis, _)
	    ->	get(Plotter, offset, point(OX, OY)),
		object(Pos, point(PX, PY)),
		(   abs(PX-OX) > abs(PY-OY)
		->  Type = x
		;   Type = y
		)
	    ;	Type = y
	    )
	;   Type = x
	).
	
axis_length(x, DW, L) :- !,
	get(DW?visible, width, W),
	L is W - 40.
axis_length(y, DW, L) :- !,
	get(DW?visible, height, H),
	L is H - 40.


plot(DW) :->
	get(DW, plotter, Plotter),
	get(Plotter, x_axis, XAxis),
	get(Plotter, y_axis, YAxis),
	send(Plotter, clear),
	get(XAxis, hypered, column, XCol),
	get(YAxis, hypered, column, YCol),
	get_chain(XCol, values, Xvals),
	get_chain(YCol, values, Yvals),
	pair_values(Xvals, Yvals, Pairs),
	msort(Pairs, XSortedPairs),
	new(G, plot_graph(smooth, box(5,5))),
	plot_points(XSortedPairs, G),
	send(Plotter, graph, G).

pair_values([], [], []).
pair_values([H0|T0], [H1|T1], [(H0,H1)|T]) :-
	pair_values(T0, T1, T).

plot_points([], _).
plot_points([(X1,Y1)|T], G) :-
	send(G, append, X1, Y1),
	plot_points(T, G).


:- pce_global(@horaxis_cursor, new(cursor(@nil, image('horaxis.crs')))).
:- pce_global(@veraxis_cursor, new(cursor(@nil, image('veraxis.crs')))).

preview_drop(DW, C:column*, Pos:[point]) :->
	get(DW, drop_axis, Pos, Type),
	(   Type == x
	->  Cursor = @horaxis_cursor
	;   Cursor = @veraxis_cursor
	),
	set_drop_cursor(C, Cursor).


drop(DW, C:column, Pos:point) :->
	get_chain(C, values, Values),
	(   Values == []
	->  send(DW, report, error, 'No values'),
	    fail
	;   true
	),
	get(DW, drop_axis, Pos, Type),
	domain(Values, Low, High, Step),
	axis_length(Type, DW, Len),
	new(Axis, plot_axis(Type, Low, High, Step, Len)),
	send(Axis, label, C?title?clone),
	new(_, hyper(Axis, C, column, diagram)),
	get(DW, plotter, Plotter),
	send(Plotter, axis, Axis),
	ignore(send(DW, plot)),
	send(DW, recenter).


domain(Values, Low, High, Step) :-
	minlist(Values, L0),
	maxlist(Values, H0),
	Range is H0 - L0,
	(   Range =:= 0
	->  Round is 10**ceil(log10(H0)-1)
	;   Round is 10**ceil(log10(Range)-1)
	),
	Low1  is floor(L0 / Round) * Round,
	High1 is floor((H0 + Round - 0.00001) / Round) * Round,
	(   High1 - Low1 < 2 * Round
	->  High is High1 + 2 * Round,
	    Low is  Low1  - 2 * Round
	;   High = High1,
	    Low  = Low1
	),
	Step = Round.

minlist([L|T], Min) :-
	minlist(T, L, Min).
minlist([], M, M).
minlist([H|T], M0, M) :-
	M1 is min(H, M0),
	minlist(T, M1, M).

maxlist([L|T], Min) :-
	maxlist(T, L, Min).
maxlist([], M, M).
maxlist([H|T], M0, M) :-
	M1 is max(H, M0),
	maxlist(T, M1, M).


:- pce_end_class.

