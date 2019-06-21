/*  $Id: table.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(table, []).
:- use_module(library(pce)).
:- use_module(util).
:- require([ between/3
	   , ceiling/2
	   , concat_atom/2
	   , get_chain/3
	   , log10/2
	   , maplist/3
	   ]).

:- pce_autoload(drag_and_drop_gesture, library(dragdrop)).
:- pce_global(@row, new(var(int, table_row, 1))).

:- pce_global(@dragcolumn_cursor,
	      new(cursor(dragcolumn, image('dragcolumn.crs')))).
:- pce_global(@dropcolumn_cursor,
	      new(cursor(dropcolumn, image('dropcolumn.crs')))).


:- pce_begin_class(measurement_table, figure, "The complete table").

initialise(T) :->
	send(T, send_super, initialise),
	send(T, display, new(HR, line)),
	send(T, border, 0),
	send(HR, name, hrule),
	send(T, pen, 1).

compute(T) :->
	"Update the table rules"::
	(   get(T, request_compute, @nil)
	->  true
	;   get_chain(T, graphicals, Columns),
	    align_columns(Columns, 5, Right),
	    get(T, member, hrule, Rule),
	    send(Rule, points, 0, 0, Right, 0),
	    send(T, send_super, compute)
	).

align_columns([], R, R).
align_columns([H|T], R0, R) :-
	send(H, instance_of, column), !,
	get(H, width, W),
	send(H, set, R0),
	(   T == []
	->  Sep = 5
	;   Sep = 15
	),
	R1 is R0 + W + Sep,
	align_columns(T, R1, R).
align_columns([_|T], R0, R) :-
	align_columns(T, R0, R).

append(T, C:column) :->
	"Append a column"::
	send(T, display, C).

gauge(T, Gauge:object) :->
	"Add a relation to a gauge"::
	send(T, append, gauge_column(Gauge)).

renamed_gauge(T, Gauge:object) :->
	get(Gauge, name, Id),
	(   get(T?graphicals, find,
		and(message(@arg1, instance_of, gauge_column),
		    @arg1?gauge_id == Id),
		Column)
	->  get(Gauge, varname, VN),
	    send(Column, gauge_name, VN)
	;   true
	).


measure(T) :->
	"Measure all columns"::
	send(T?graphicals, for_some,
	     if(message(@arg1, instance_of, gauge_column),
		message(@arg1, measure))),
	send(T, update).

update(T) :->
	"Update dependent columns"::
	send(T?graphicals, for_some,
	     if(message(@arg1, instance_of, dependent_column),
		message(@arg1, update))).

delete_last_row(T) :->
	"Delete the last row"::
	send(T?graphicals, for_some,
	     if(message(@arg1, instance_of, column),
		message(@arg1, delete_last_row))).


delete_column(T) :->
	"Delete the selected column"::
	(   get(T, selection, Selection),
	    get(Selection, size, 1)
	->  get(Selection, head, Column),
	    send(Column, destroy)
	;   send(T, report, error, 'No selection'),
	    fail
	).


rows(T, Rows:int) :<-
	"Get the current number of rows"::
	get(T?graphicals, find, message(@arg1, instance_of, column), C1),
	get(C1, cells, Values),
	get(Values, size, Rows).

:- pce_group(formula).

preview_drop(_, F:'formula|column*') :->
	(   F == @nil
	;   send(F, instance_of, formula)
	), !,
	set_drop_cursor(F, @dropcolumn_cursor).


drop(T, F:'formula|column') :->
	send(F, instance_of, formula),
	new(C, dependent_column(F)),
	send(T, append, C),
	send(C, update).

:- pce_end_class.


:- pce_begin_class(column, figure, "A column of the table").

variable(cells,	chain,	        	get, "Chain holding the cells").
variable(title,		graphical,      get, "Graphical for the title").
variable(number_format,	name := '%.1f', get, "Format for numerical fields").

initialise(C, T:name) :->
	"Create from title"::
	send(C, send_super, initialise),
	send(C, slot, cells, new(chain)),
	send(C, name, T),
	send(C, slot, title, new(TT, text(T, center, bold))),
	send(C, display, TT),
	send(C, request_compute).


title(C, Title:graphical) :->
	(   get(C, title, Old), Old \== @nil
	->  send(Old, device, @nil)
	;   true
	),
	send(C, slot, title, Title),
	send(C, display, Title).


name(C, Name:name) :->
	"Change title of the column"::
	send(C, send_super, name, Name),
	(   get(C, title, T),
	    T \== @nil
	->  send(T, string, Name),
	    send(C, request_compute)
	;   true
	).


clear(C) :->
	"Delete all cells"::
	get(C, cells, Chain),
	send(Chain, for_all, message(@arg1, free)),
	send(Chain, clear).


delete_last_row(C) :->
	get(C, cells, Chain),
	get(Chain, tail, Last),
	send(Chain, delete, Last),
	free(Last).


number_format(C, Fmt:[name]) :->
	"Change the number format"::
	(   get(C, number_format, Fmt)
	->  true
	;   Fmt == @default
	->  get_chain(C, values, Values),
	    maplist(required_digits, Values, RDigits),
	    maxlist(RDigits, Digits),
	    concat_atom(['%.', Digits, f], TheFmt),
	    send(C, number_format, TheFmt)
	;   send(C, slot, number_format, Fmt),
	    send(C?cells, for_all,
		 message(@arg1, string,
			 create(string, Fmt, @arg1?value)))
	).


required_digits(V, D) :-
	(   V =:= 0
	->  D is 1
	;   D is ceil(max(0, 1-log10(V)))
	).

maxlist([L|T], Min) :-			% utility
	maxlist(T, L, Min).
maxlist([], M, M).
maxlist([H|T], M0, M) :-
	M1 is max(H, M0),
	maxlist(T, M1, M).


append(C, V:'int|real|char_array') :->
	"Append and value"::
	(   send(V, instance_of, char_array)
	->  S = V
	;   get(C, number_format, F),
	    new(S, string(F, V))
	),
	new(T, text(S, left, normal)),
	send(T, attribute, value, V),
	send(C?cells, append, T),
	send(C, display, T),
	send(C, request_compute).


values(C, Values:chain) :<-
	get(C, cells, Cells),
	get(Cells, map, @arg1?value, Values).


compute(C) :->
	"Compute the positions of the table-elements"::
	(   get(C, request_compute, @nil)
	->  true
	;   get(C, title, TT),
	    get_chain(C, cells, Values),
	    align_cells(Values, 5, 0-L, 0-R),
	    CX is (R-L)//2,
	    send(TT, center_x, CX),
	    get(TT, height, TH),
	    send(TT, y, -TH),
	    send(C, send_super, compute)
	).
	

align_cells([], _, L-L, R-R).
align_cells([H|T], Y, L0-L, R0-R) :-
	alignment_x(H, LX, RX),
	send(H, position, point(-LX, Y)),
	get(H, height, CH),
	NY is CH + Y,
	L1 is max(L0, LX),
	R1 is max(R0, RX),
	align_cells(T, NY, L1-L, R1-R).
	

alignment_x(Text, L, R) :-
	get(Text, string, String),
	get(Text, width, TW),
	(   get(String, index, '.', DotIndex)
	->  get(String, sub, 0, DotIndex+1, WholePart),
	    get(Text?font, width, WholePart, L)
	;   L = TW
	),
	R is TW - L.

:- pce_global(@column_recogniser, make_column_recogniser).


make_column_recogniser(G) :-
	new(C, click_gesture(left, '', single,
			     message(@receiver?device, selection, @receiver),
			     @default,
			     message(@receiver?device, selection, @nil))),
	new(DD, drag_and_drop_gesture),
	send(C, condition, @event?y < 0),
	send(DD, condition, @event?y < 0),
	send(DD, cursor, @dragcolumn_cursor),
	new(G, handler_group(C, DD)).

event(C, Ev:event) :->
	(   get(Ev, y, Y),
	    Y < 0
	->  send(@column_recogniser, event, Ev)
	;   (   send(C, send_super, event, Ev)
	    ;   send(@column_recogniser, event, Ev)
	    )
	).

formula(C, S:formula) :<-
	"Return formula (symbol) for column"::
	get(C, name, Symbol),
	new(S, column_symbol(Symbol)).

:- pce_end_class.

:- pce_extend_class(formula).

convert(_, C:column, F:formula) :<-
	"Convert a table-column"::
	get(C, formula, F).

:- pce_end_class.


:- pce_begin_class(column_symbol, formula_symbol,
		   "Use a column in a formula").

value(F, Value:'int|real') :<-
	"Compute value, given an @row"::
	get(F, name, Symbol),
	get(F, table, Table),
	get(Table, member, Symbol, Column),
	get(Column?cells, nth1, @row, CellText),
	get(CellText, value, Value).

table(F, Table:measurement_table) :<-
	"Find the table I'm displayed on"::
	find_table(F, Table).

find_table(@nil, _) :- !,
	fail.
find_table(X, X) :-
	send(X, instance_of, measurement_table).
find_table(Gr, T) :-
	get(Gr, device, Dev),
	find_table(Dev, T).

:- pce_end_class.

		 /*******************************
		 *	    GAUGE-COLUMN	*
		 *******************************/

:- pce_begin_class(gauge_column, column, "Column bound to a gauge").

variable(gauge_id,	name,	get, "Id name of the gauge").
variable(gauge_name,	name,	get, "Variable-name of the gauge").

initialise(C, Gauge:object) :->
	get(Gauge, varname, Var),
	get(Gauge, name, Id),
	send(C, send_super, initialise, Var),
	send(C, slot, gauge_id, Id),
	send(C, slot, gauge_name, Var).

gauge(C, Gauge:object) :<-
	"Find the associated gauge"::
	get(C, device, Table),
	get(Table?frame, hypered, simulator, Simulation),
	get(C, gauge_id, Id),
	get(C, gauge_name, Name),
	get(Simulation, gauge, Id, Name, Gauge).

gauge_name(C, Name:name) :->
	send(C, slot, gauge_name, Name),
	send(C, name, Name).

measure(C) :->
	"Append value of associated <-gauge"::
	get(C, gauge, Gauge),
	get(Gauge, value, Value),
	send(C, append, Value).

:- pce_end_class.


		 /*******************************
		 *    FORMULA SPECIFIED COLUMN	*
		 *******************************/

:- pce_begin_class(dependent_column, column, "Column specified by a formula").

initialise(C, F:formula) :->
	send(C, send_super, initialise, formula),
	send(C, title, F?clone).

update(C) :->
	"(Re)compute cells"::
	get(C, title, F),
	send(C, clear),
	get(C, device, T),
	get(T, rows, Rows),
	(   between(1, Rows, Row),
		send(@row, assign, Row),
		get(F, value, Value),
		send(C, append, Value),
	    fail
	;   true
	),
	send(C, number_format).
	
:- pce_end_class.


