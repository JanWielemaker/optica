/*  $Id: tipper.pl,v 1.1 2000/03/03 10:50:28 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 2000 University of Amsterdam. All rights reserved.
*/

:- module(tipper, [tipper/0]).
:- use_module(library(pce)).
:- use_module(library(broadcast)).
:- use_module(stress, [tip/3, show/2]).

:- initialization
   listen(optica(O, open(experiment(Exp, _Offset))),
	  attach_tipper(O, Exp)),
   listen(optica(O, quit),
	  log_quit(O)),
   listen(optica(O, restore_log(@(_, tip_status(Exp, Ids, Time)))),
	  restore_tip_status(Exp, Ids, Time)).

restore_tip_status(Exp, Ids, Time) :-
	retractall(tip_status(Exp, _, _)),
	assert(tip_status(Exp, Ids, Time)).

attach_tipper(Optica, Exp) :-
	(   get(Optica, hypered, tipper, T)
	->  true
	;   new(T, tipper),
	    send(Optica, service, T),
	    new(_, hyper(Optica, T, tipper, optica))
	),
	(   tip(_,_,_)
	->  send(T, experiment, Exp)
	;   true
	).

log_quit(Optica) :-
	(   get(Optica, hypered, tipper, T)
	->  send(T, log_status)
	;   true
	).

:- pce_image_directory(icons).

resource(tip,	  image, image('tip.xpm')).
resource(tipseen, image, image('tipseen.xpm')).


:- dynamic
	tip_status/3.			% Exp, Show, Time

:- pce_begin_class(tipper, dialog_group, "Show available tips").

variable(tips,	      chain, get, "Registered tips").
variable(timer,	      timer, get, "Related timer").
variable(experiment,  name*, get, "Current experriment").
variable(topen,       date*, get, "Date last tip was made available").

class_variable(radius, int,  0).
class_variable(gap,    size, size(5, 2)).

initialise(T) :->
	send_super(T, initialise, tipper, box),
	new(B, button(size)),
	send(B, label, resource(tip)),
	get(B, size, size(W, H)),
	free(B),
	send(T, size, size(W, H+4)),
	send(T, show_label, @off),
	send(T, slot, tips, new(chain)),
	send(T, slot, timer, timer(0, message(T, show_next_tip))).


unlink(T) :->
	"Make sure timer is stopped"::
	get(T, timer, Timer),
	send(Timer, status, idle),
	send_super(T, unlink).


reference(T, Ref:point) :<-
	"Reference for alignment"::
	get(T, height, H),
	new(Ref, point(0,H-4)).


show_next_tip(T) :->
	"Show the next not-yet-shown"::
	get(T?tips, find, @arg1?device == @nil, Next),
	send(T, append, Next),
	send(T, fix_layout),
	send(T, slot, topen, @nil),
	send(T, log_status).


fix_layout(T) :->
	"Fix layout of tipper and device"::
	send(T, size, @default),
	send(T, layout_dialog),
	(   get(T, device, Dev),
	    send(Dev, has_send_method, layout)
	->  send(T?device, layout)
	;   true
	).


schedule(T, Time:int*) :->
	"Schedule for the next tip"::
	get(T, timer, Timer),
	(   Time == @nil
	->  send(Timer, status, idle)
	;   send(Timer, interval, Time),
	    send(Timer, status, once)
	).


log_status(T) :->
	"Log current status"::
	(   get(T, experiment, Exp),
	    Exp \== @nil
	->  get(T?graphicals, map, @arg1?name, IdChain),
	    chain_list(IdChain, IdList),
	    (	get(T, topen, OpenDate),
		OpenDate \== @nil
	    ->  get(new(date), difference, OpenDate, second, Time)
	    ;   Time = []
	    ),
	    broadcast(log(tip_status(Exp, IdList, Time))),
	    retractall(tip_status(Exp, _, _)),
	    assert(tip_status(Exp, IdList, Time))
	;   true
	).
	

experiment(T, Exp:name) :->
	"Activate for the given experiment"::
	send(T, schedule, @nil),
	send(T, log_status),		% log quit status
	send(T, clear),
	get(T, tips, Tips),
	send(Tips, clear),
	send(T, slot, experiment, Exp),
	findall(tip(Id, Time), tip(Exp, Time, Id), Pairs),
	(   Pairs == []
	->  send(T, slot, topen, @nil)
	;   send_list(Tips, append, Pairs),
	    (	tip_status(Exp, Shown, ActTime)
	    ->	restore(Shown, ActTime, T)
	    ;   send(T, append, Tips?head),
		send(T, slot, topen, @nil)
	    ),
	    send(T, fix_layout)
	),
	send(T, log_status).

restore([], _, _) :- !.
restore([Tip0|Rest], ActTime, T) :- !,
	get(T, tips, Tips),
	get(Tips, find, @arg1?name == Tip0, Tip),
	(   get(Tip, device, T)
	->  true
	;   send(T, append, Tip)
	),
	(   Rest == []
	->  (   ActTime == []		% not yet seen
	    ->	send(T, slot, topen, @nil)
	    ;	send(Tip, seen, @on),
	        get(Tip, time, Time),
		SchedTime is Time - ActTime,
		send(T, schedule, SchedTime),
		new(D, date),
		get(D, posix_value, Now),
		Start is Now - ActTime,
		send(D, posix_value, Start),
		send(T, slot, topen, D)
	    )
	;   send(Tip, seen, @on),
	    restore(Rest, ActTime, T)
	).
	
:- pce_end_class.

:- pce_begin_class(tip, button, "Show a tip").
		   
variable(time,	int, 	get, "Minimum time in seconds").
variable(seen,  bool,   get, "Has tip been seen").

initialise(Tip, Id:name, Time:int) :->
	send_super(Tip, initialise, Id, message(Tip, show)),
	send(Tip, slot, time, Time),
	send(Tip, seen, @off).

seen(Tip, Seen:bool) :->
	"Select the proper image"::
	image(Seen, Image),
	send(Tip, label, Image),
	send(Tip, slot, seen, Seen).

image(@off, image(resource(tip))).
image(@on,  image(resource(tipseen))).

show(Tip) :->
	"Show related tip"::
	get(Tip, name, Id),
	get(Tip, frame, Optica),
	show(Optica, Id),
	(   get(Tip, seen, @on)
	->  true
	;   send(Tip, seen, @on),
	    get(Tip, time, Time),
	    get(Tip, device, Tipper),
	    send(Tipper, slot, topen, new(date)),
	    send(Tipper, schedule, Time)
	).

:- pce_end_class.


		 /*******************************
		 *	      TEST		*
		 *******************************/

tipper :-
	new(D, dialog),
	send(D, append, new(T, tipper)),
	send(T, experiment, fase_1),
	send(D, open).
