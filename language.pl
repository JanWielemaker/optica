/*  $Id: language.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(language,
	  [ message/2,			% Id, Message
	    current_language/1,		% -Language
	    set_language/1		% +Language
	  ]).
:- use_module(library(pce)).

:- multifile
	term/2,
	error/3.

:- dynamic
	current_language/1.

%current_language(english).
current_language(dutch).

set_language(Lan) :-
	retractall(current_language(_)),
	assert(current_language(Lan)),
	update_errors.

message(Var, '?') :-
	var(Var), !.
message(Number, Number) :-
	number(Number), !.
message(Term, Translation) :-
	current_language(Lan),
	term(Term, Translations),
	(   is_list(Translations)
	->  T =.. [Lan, Translation0],
	    memberchk(T, Translations),
	    (	is_list(Translation0)
	    ->	map_parts(Translation0, Translation1),
	        concat_atom(Translation1, Translation)
	    ;	Translation = Translation0
	    )
	;   Translation = Translations
	), !.
message(Term, Translation) :-
	get_class(Term, char_array, label_name, Translation).

map_parts([], []).
map_parts([H0|T0], [H|T]) :-
	map_part(H0, H),
	map_parts(T0, T).

map_part(nl, '
') :- !.
map_part(X, X).

		 /*******************************
		 *     MAP LABEL IDENTIFIERS	*
		 *******************************/

:- pce_extend_class(name).

label_name(Name, Label:name) :<-
	message(Name, Label).

:- pce_end_class.


		 /*******************************
		 *        GENERIC LABELS	*
		 *******************************/

term(user,
     [ dutch('Gebruiker')
     ]).
term(configuration,
     [ dutch('Configuratie')
     ]).
term(settings,
     [ dutch('Instellingen')
     ]).
term(replay,
     [ dutch('Afspelen')
     ]).
term(index,
     [ dutch('Volgnummer')
     ]).
term(dutch,
     'Nederlands').
term(new,
     [ dutch('Nieuw')
     ]).
term(name,
     [ dutch('Naam')
     ]).
term(value,
     [ dutch('Waarde')
     ]).
term(description,
     [ dutch('Beschrijving')
     ]).
term(open,
     [ dutch('Openen')
     ]).
term(save,
     [ dutch('Opslaan')
     ]).
term(save_as,
     [ dutch('Opslaan Als')
     ]).
term(load,
     [ dutch('Laden')
     ]).
term(cancel,
     [ dutch('Afbreken')
     ]).
term(confirm,
     [ dutch('Bevestig')
     ]).
term(ok,
     [ dutch('Doorgaan')
     ]).
term(apply,
     [ dutch('Doorvoeren')
     ]).
term(restore,
     [ dutch('Herstel')
     ]).
term(exit,
     [ dutch('Sluiten')
     ]).
term(quit,
     [ dutch('Sluiten')
     ]).
term(done,
     [ dutch('Klaar')
     ]).
term(delete,
     [ dutch('Verwijderen')
     ]).
term(remove,
     [ dutch('Verwijderen')
     ]).
term(add,
     [ dutch('Toevoegen')
     ]).
term(edit,
     [ dutch('Wijzig')
     ]).
term(continue_,
     [ dutch('Doorgaan ...'),
       english('Continue ...')
     ]).
term(continue,
     [ dutch('Doorgaan')
     ]).
term(class,
     [ dutch('Klasse')
     ]).
term(sort,
     [ dutch('Sorteer')
     ]).
term(false,
     [ dutch('Nee')
     ]).
term(true,
     [ dutch('Ja')
     ]).
term(range,
     [ dutch('Bereik')
     ]).
term(situation,
     [ dutch('Situatie')
     ]).
term(question,
     [ dutch('Vraag')
     ]).
term(unknown,
     [ dutch('Onbekend')
     ]).
term(specified,
     [ dutch('Gespecificeerd')
     ]).
term(colour,
     [ dutch('Kleur')
     ]).

		 /*******************************
		 *	       LOGIC		*
		 *******************************/

term(and,
     [ dutch(en)
     ]).
term(or,
     [ dutch(of)
     ]).
term(not,
     [ dutch(niet)
     ]).

		 /*******************************
		 *	       ERRORS		*
		 *******************************/

%	error(+Id, +Kind, -Messages).

error(item_not_filled, warning,
      [ dutch('%I"%N" is niet ingevuld'),
	english('%I"%N" has no value')
      ]).
	
		 /*******************************
		 *      LINK ERROR DATABASE	*
		 *******************************/

define_error(Id) :-
	current_language(Lan),
	T =.. [Lan, Message],
	error(Id, Kind, Messages),
	memberchk(T, Messages), !,
	new(_E, error(Id, Message, Kind, report)).

:- initialization
	send(@pce?exception_handlers, value,
	     undefined_error,
	     message(@prolog, define_error, @arg1)).

%	update_errors
%	
%	If the language is switched, already defined errors must be updated.
%	Called from set_language.

update_errors :-
	current_language(Lan),
	T =.. [Lan, Message],
	error(Id, Kind, Messages),
	memberchk(T, Messages),
	get(@errors, member, Id, _),
	new(_, error(Id, Message, Kind, report)),
	fail.
update_errors.
	
