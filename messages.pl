/*  $Id: messages.pl,v 1.2 1999/11/18 16:20:45 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1999 University of Amsterdam. All rights reserved.
*/

:- module(optica_messages, []).

:- multifile
	user:term_expansion/2.
:- dynamic
	user:term_expansion/2.

term_expansion(term(Id, Term),	      language:term(Id,	 Term)).
term_expansion(error(Id, Kind, Term), language:error(Id, Kind, Term)).

		 /*******************************
		 *        GENERIC LABELS	*
		 *******************************/

term(student,
     [ dutch('Proefpersoon')
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
term(minimum_time,
     [ dutch('Minimale Tijd')
     ]).
term(max_lenses,
     [ dutch('Maximaal aantal lenzen')
     ]).
term(experiments,
     [ dutch('Experimenten')
     ]).
term(dutch,
     'Nederlands').
term(new,
     [ dutch('Nieuw')
     ]).
term(name,
     [ dutch('Naam')
     ]).
term(tools,
     [ dutch('Gereedschappen')
     ]).
term(initial_state,
     [ dutch('Aanvangstoestand')
     ]).
term(instruments,
     [ dutch('Instrumenten')
     ]).
term(save,
     [ dutch('Bewaren')
     ]).
term(save_as,
     [ dutch('Bewaren Als')
     ]).
term(load,
     [ dutch('Laden')
     ]).
term(cancel,
     [ dutch('Afbreken')
     ]).
term(ok,
     [ dutch('Doorgaan')
     ]).
term(apply,
     [ dutch('Uitvoeren')
     ]).
term(restore,
     [ dutch('Herstel')
     ]).
term(quit,
     [ dutch('Sluiten')
     ]).
term(quit_viewer,
     [ dutch('Sluiten')
     ]).
term(delete,
     [ dutch('Verwijderen')
     ]).
term(edit,
     [ dutch('Wijzig')
     ]).
term(formula,
     [ dutch('Formule')
     ]).
%term(label,
%     image('label.lbl')).
term(class,
     [ dutch('Klasse')
     ]).
term(cardinality,
     [ dutch('Aantal')
     ]).
term(radius,
     [ dutch('Straal')
     ]).
term(thickness,
     [ dutch('Dikte')
     ]).
term(focal_distance,
     [ dutch('Brandpuntsafstand')
     ]).
term(sfere_left,
     [ dutch('Linker bolling')
     ]).
term(sfere_right,
     [ dutch('Rechter bolling')
     ]).
term(breaking_index,
     [ dutch('Brekingsindex')
     ]).
term(show_gauge,
     [ dutch('Waarde zichtbaar')
     ]).
term(varname,
     [ dutch('Variabele naam')
     ]).
term(balloon,
     [ dutch('Tekst ballon')
     ]).
term(language,
     [ dutch('Taal')
     ]).
term(auto_hide_gauge_values,
     [ dutch('Meetwaarden onderdrukken')
     ]).
term(test_mode,
     [ dutch('Test (geen tijd limiet)')
     ]).
term(log_directory,
     [ dutch('Protokol map')
     ]).
term(attributes,
     [ dutch('Attributen')
     ]).
term(attribute,
     [ dutch('Attribuut')
     ]).
term(angle,
     [ dutch('Hoek')
     ]).
term(switch,
     [ dutch('Schakelaar')
     ]).
term(read_only,
     [ dutch('Niet veranderbaar')
     ]).
term(false,
     [ dutch('Nee')
     ]).
term(true,
     [ dutch('Ja')
     ]).
term(on_bar,
     [ dutch('Op Bank')
     ]).
term(range,
     [ dutch('Bereik')
     ]).
term(set,
     [ dutch('Verzameling')
     ]).
term(pos_x,
     [ dutch('X-Waarde')
     ]).
term(pos_y,
     [ dutch('Y-Waarde')
     ]).
term(value_set,
     [ dutch('Domein')
     ]).
term(type,
     [ dutch('Soort')
     ]).
term(situation,
     [ dutch('Situatie')
     ]).
term(question,
     [ dutch('Vraag')
     ]).


		 /*******************************
		 *	     SIMULATOR		*
		 *******************************/

term(optica_simulation_environment,
     [ english('Optics Simulation Environment'),
       dutch('Optica Simulatie Omgeving')
     ]).
term(confirm_delete_all,
     [ english('Delete all instruments?'),
       dutch('Alle instrumenten verwijderen?')
     ]).
term(quit_optica,
     [ english('Quit Optica Simulator?'),
       dutch('Optica Simulator sluiten?')
     ]).
term(quit_and_run_tests,
     [ english('Quit Optica Simulator and run tests?'),
       dutch('Optica Simulator sluiten en toets afnemen?')
     ]).

		 /*******************************
		 *     QUALITATIVE ANALYSIS	*
		 *******************************/

term(measurements,
     [ english('Measurements'),
       dutch('Meetwaarden')
     ]).

term(diagram,
     [ english('Diagram'),
       dutch('Grafiek')
     ]).

term(formulas,
     [ english('Formulas'),
       dutch('Formules')
     ]).

term(enter_formula,
     [ english('Please enter formula'),
       dutch('Nieuwe formule invoeren')
     ]).

		 /*******************************
		 *	     NOTEBOOK		*
		 *******************************/

term(notebook,
     [ english('Note Book'),
       dutch('Aantekenblok')
     ]).

term(enter_note,
     [ english('Please enter text for note'),
       dutch('U kunt nu een aantekening invoeren')
     ]).

term(view_note,
     [ english('You are Viewing an old note'),
       dutch('U bekijkt nu een oude aantekening')
     ]).

term(note_entered,
     [ english('Added note to database'),
       dutch('Uw aantekening is opgeslagen')
     ]).

term(notes,
     [ english('Notes'),
       dutch('Aantekeningen')
     ]).

term(note,
     [ english('Text'),
       dutch('Tekst')
     ]).

term(current_state,
     [ english('Current State'),
       dutch('Huidige toestand')
     ]).

term(note_save_note,
     [ english('Save state and note text?'),
       dutch('Toestand en aantekening bewaren?')
     ]).

term(note_save_state,
     [ english('Save state?'),
       dutch('Toestand bewaren?')
     ]).

%	(Tool) button translations

term(save_and_exit,
     [ dutch('Bewaren en terug naar simulatie')
     ]).
term(resume_with_state,
     [ english('Resume experiment with this state'),
       dutch('Experimenteer verder met deze toestand')
     ]).
term(discard_note,
     [ english('Discard'),
       dutch('Niet opslaan')
     ]).
term(cancel_save_note,
     [ english('Cancel'),
       dutch('Terug')
     ]).

		 /*******************************
		 *	       LOGIN		*
		 *******************************/

term(optica_login(Version),
     [ english(['Optica Login (Version ', Version, ')']),
       dutch(['Optica aanmelden (Version ', Version, ')'])
     ]).


		 /*******************************
		 *	       TEST		*
		 *******************************/

term(thanks_for_test,
     [ english('Thanks for filling out the test'),
       dutch('Bedankt voor het invullen')
     ]).
term(start_test,
     [ english('Click "OK" to start test'),
       dutch('Klik op "OK" om aan de toets te beginnen')
     ]).
term(start_named_test(Name),
     [ english(['Click "OK" to start test "', Name, '"']),
       dutch(['Klik op "OK" om aan de toets "', Name, '" te beginnen'])
     ]).
     
		 /*******************************
		 *		TEXT		*
		 *******************************/

term(not_read_for_time(Time),
     [ english(['You should study this text for at least ', Time, ' minutes']),
       dutch(['U moet deze tekst tenminste ', Time, ' minuten bestuderen'])
     ]).

		 /*******************************
		 *	       ERRORS		*
		 *******************************/

error(no_label_specified, error,
      [ dutch('U heeft geen label ingevoerd'),
	english('Please enter a label first')
      ]).
error(max_instruments, error,
      [ dutch('%IU kunt niet meer dan %d van deze instrumenten gebruiken'),
	english('%IYou can not use more than %d of these instruments')
      ]).
error(protractor_value_on_bad_segment, error,
      [ dutch('U kunt alleen de hoek van het eerste lijnstuk instellen'),
	english('You can only set the angle for the first segment')
      ]).
error(syntax_error, error,
      [ dutch('Ingevoerde formule bevat een syntactische fout'),
	english('Syntax error')
      ]).
error(illegal_formula, error,
      [ dutch('Formule bevat niet ondersteunde operaties'),
	english('Formula contain not-supported operators')
      ]).
error(no_student_name, error,
      [ dutch('U heeft geen naam ingevuld'),
	english('You did not fill out the student field')
      ]).
error(insufficiently_experimented, error,
      [ dutch('%IU moet minimaal %g minuten in "%s" experimenteren (nu %.1f)'),
	english('%IYou are requested to experiment for at least %.1f minutes in "%s" (now %.1f')
      ]).
error(no_log_directory, error,
      [ dutch('%IDe ingestelde log map %s bestaat niet'),
	english('%IThe configured log directory does not exist')
      ]).
error(min_focal_distance, error,
      [ dutch('%IDe minimale brandpuntsafstand is %s'),
	english('%IThe minimal focal distance is %s')
      ]).
