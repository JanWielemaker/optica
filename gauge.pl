/*  $Id: gauge.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(gauge, []).
:- use_module(library(pce)).
:- use_module(library(pce_template)).
:- use_module(configdb).
:- use_module(tool).
:- require([ concat/3
	   , concat_atom/2
	   ]).

:- pce_begin_class(gauge, template,
		   "Generic handling of gauges").

varname(G, Name0:name*) :->
	"Assign the gauge a variable"::
	(   Name0 == ''
	->  Name = @nil
	;   Name = Name0
	),
	get(G, gauge_text, GT),
	send(GT, varname, Name).
varname(G, Name:name) :<-
	"Find name of the variable"::
	get(G, gauge_text, GT),
	get(GT, varname, Name),
	Name \== @nil.

gauge_text(G, GT:gauge_text) :<-
	"Find the gauge_text displaying the value"::
	get(G, find, @default,
	    message(@arg1, instance_of, gauge_text),
	    GT).

value(G, V:real) :<-
	"Read the gauge"::
	get(G, gauge_text, GT),
	get(GT, value, V).

is_variable(G) :->
	"Test gauge defines a variable"::
	get(G, varname, _).

show_value(G, Val:bool) :->
	get(G, gauge_text, GT),
	send(GT, show_value, Val).

:- pce_end_class.

:- pce_begin_class(gauge_text, text, "Text for a gauge").

variable(unit,         name*,          get,  "Unit displayed").
variable(value,	       real*,	       get,  "Value displayed").
variable(value_format, name := '%.1f', get,  "Format for value").
variable(varname,      name*,	       get,  "Name of displayed variable").
variable(sensitive,    bool := @off,   both, "Handles events itself").
variable(show_value,   bool := @on,    get,  "Show the value").
variable(client_for,   [object]*,      none, "Object I'm a client for").

initialise(GT, ClientFor:[object]*) :->
	send(GT, send_super, initialise, '', center, normal),
	send(GT, background, colour(navajo_white)),
	send(GT, border, 2),
	send(GT, slot, client_for, ClientFor),
	send(GT, slot, value, 0).

client_for(GT, ClientFor:object) :<-
	"Find object I'm client for"::
	get(GT, slot, client_for, ClientFor0),
	(   ClientFor0 == @default
	->  get(GT, device, ClientFor)
	;   ClientFor0 \== @nil
	->  ClientFor = ClientFor0
	).

compute(GT) :->
	(   get(GT, request_compute, @nil)
	->  true
	;   get(GT, unit, Unit),
	    (	get(GT, show_value, @on)
	    ->	get(GT, value, Val),
		(   Val == @nil
		->  Value = '--',
		    Fmt = '%s'
		;   get(GT, value_format, Fmt),
		    Value = Val
		)
	    ;	Value = '?',
		Fmt = '%s'
	    ),
	    get(GT, varname, VarName),
	    value_format(VarName, Unit, Fmt, TheFormat),
	    send(GT, string, string(TheFormat, Value)),
	    send(GT, send_super, compute)
	).

:- pce_global(@gauge_text_recogniser1,
	      new(click_gesture(left, '', double,
				message(@event?receiver, client_tool)))).
:- pce_global(@gauge_text_recogniser2,
	      new(click_gesture(left, '', single,
				message(@event?receiver, clicked)))).
				
event(GT, Ev:event) :->
	(   send(@gauge_text_recogniser1, event, Ev)
	;   (   get(GT, sensitive, @off)
	    ->  send(GT, send_super, event, Ev)
	    ;   (   send(GT, send_super, event, Ev)
		;   send(@gauge_text_recogniser2, event, Ev)
		)
	    )
	).


clicked(GT) :->
	"Clicked: assign variable name"::
	get(GT?frame, instrument, tool),
	send(GT, tool).

client_tool(GT) :->
	"Apply tool on <-client or itself"::
	(   get(GT, client_for, Client),
	    send(Client, has_send_method, tool)
	->  send(Client, tool)
	;   send(GT, tool)
	).


tool(GT) :->
	apply_tool(GT,
		   [ varname(type(varname))
		   ]).

value_fmt(@nil, @nil, Fmt, Fmt) :- !.
value_fmt(@nil, Unit, Fmt, TheFmt) :- !,
	concat_atom([Fmt, ' ', Unit], TheFmt).
value_fmt(Var, @nil, Fmt, TheFmt) :- !,
	concat_atom([Var, =, Fmt], TheFmt).
value_fmt(Var,  Unit, Fmt, TheFmt) :-
	concat_atom([Var, =, Fmt, ' ', Unit], TheFmt).

:- dynamic
	format_cache/4.

value_format(VarName, Unit, Fmt, TheFormat) :-
	format_cache(VarName, Unit, Fmt, TheFormat), !.
value_format(VarName, Unit, Fmt, TheFormat) :-
	value_fmt(VarName, Unit, Fmt, TheFormat0),
	(   concat('\n', TheFormat, TheFormat0)
	->  true
	;   TheFormat = TheFormat0
	),
	asserta(format_cache(VarName, Unit, Fmt, TheFormat)).


set_parameter(GT, Name, Value) :-
	get(GT, Name, Value), !.
set_parameter(GT, Name, Value) :-
	send(GT, slot, Name, Value),
	send(GT, request_compute).

unit(GT, Unit:name) :->
	set_parameter(GT, unit, Unit).
value(GT, Value:real*) :->
	get(GT, value, Old),
	(   Value == Old
	->  true
	;   number(Old), number(Value),
	    abs(Old-Value) < abs(Value/10000)
	->  send(GT, slot, value, Value)		% very small change
	;   (	get(GT, window, OW),
	        send(OW, has_get_method, auto_hide_gauges),
	        get(OW, auto_hide_gauges, @on)
	    ->  send(GT, show_value, @off)
	    ;	true
	    ),
	    send(GT, slot, value, Value),
	    send(GT, request_compute)
	).
value_format(GT, Fmt:name) :->
	set_parameter(GT, value_format, Fmt).
varname(GT, VN0:name*) :->
	(   VN0 == ''
	->  VN = @nil
	;   VN = VN0
	),
	set_parameter(GT, varname, VN).
show_value(GT, Show:bool) :->
	set_parameter(GT, show_value, Show).
		
:- pce_end_class.

