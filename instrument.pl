/*  $Id: instrument.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of Optica
    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(instrument,
	  [ current_instrument/3,
	    instrument/3
	  ]).
:- use_module(library(pce)).
:- use_module(configdb).


		 /*******************************
		 *	      INSTRUMENTS	*
		 *******************************/

:- pce_global(@rotlamp_cursor, new(cursor(rotlamp, 'rotline.crs'))).
:- pce_global(@xmove_cursor,   new(cursor(xmove,   'xmove.crs'))).
:- pce_global(@ymove_cursor,   new(cursor(ymove,   'ymove.crs'))).

%	instrument(Name, Cursor, Icon, Summary).
%
%	Defines the instruments shown in the tool-bar.  Switching
%	an instrument just changes the result of <-instrument of
%	the tool and changes the cursor to indicate the current
%	instrument.

instrument(Tool, Name, Attributes) :-
	get(Tool, experiment, Exp),
	Exp \== @nil,
	config(experiment(Exp, Options)), !,
	(   memberchk(instruments(Instruments), Options),
	    member(Name, Instruments),
	    (	instrument_config(Name, icon(Image)),
		instrument_config(Name, balloon(Tag))
	    ->	Attributes = [ cursor(hand2),
			       image(Image),
			       tag(_, Tag)
			     ]
	    ;	Name == separator
	    ->	Attributes = []
	    )
	;   Name = separator,
	    Attributes = []
	;   memberchk(tools(Tools), Options),
	    tool(Name, Attributes),
	    (	memberchk(Name, Tools)
	    ;	Name = separator
	    )
	).
instrument(_, Name, Attributes) :-
	(   instrument(Name, Attributes)
	;   Name = separator,
	    Attributes = []
	;   tool(Name, Attributes)
	),
	\+ not_in_unconstraint_environment(Name).

current_instrument(Tool, Name, Attributes) :-
	instrument(Tool, Name, AllAtts),
	subset(Attributes, AllAtts).


not_in_unconstraint_environment(show_gauges).
not_in_unconstraint_environment(switch).
not_in_unconstraint_environment(theory_viewer).
not_in_unconstraint_environment(help_viewer).
not_in_unconstraint_environment(assignment_viewer).

instrument(lens,
	   [ cursor(hand2),
	     image('poslens.xpm'),
	     tag(english, 'lens'),
	     tag(dutch, 'lens')
	   ]).
instrument(lamp1,
	   [ cursor(hand2),
	     image('lamp1.xpm'),
	     tag(english, 'Strong, small-bundled light source'),
	     tag(dutch, 'Sterke lamp met smalle bundel')
	   ]).
instrument(lamp3,
	   [ cursor(hand2),
	     image('rbulb.xpm'),
	     tag(english, 'Strong light source'),
	     tag(dutch, 'Sterke lamp; punt-bron')
	   ]).
instrument(parlamp,
	   [ cursor(hand2),
	     image('parlamp.xpm'),
	     tag(english, 'Three paralel lasers'),
	     tag(dutch, 'Drie paralele stralen')
	   ]).
instrument(biglamp,
	   [ cursor(hand2),
	     image('biglamp.xpm'),
	     tag(english, 'Wide-bundled light source'),
	     tag(dutch, 'Lamp met brede paralelle bundel')
	   ]).
instrument(shield,
	   [ cursor(hand2),
	     image('shield.xpm'),
	     tag(english, 'Shield with small holes'),
	     tag(dutch, 'Plaat met kleine gaatjes')
	   ]).
instrument(shield2,
	   [ cursor(hand2),
	     image('shield2.xpm'),
	     tag(english, 'Shield'),
	     tag(dutch, 'Scherm')
	   ]).
instrument(eye,
	   [ cursor(hand2),
	     image('eye.xpm'),
	     tag(english, 'Eye'),
	     tag(dutch, 'Oog')
	   ]).

instrument(separator, []).

tool(dotruler,
     [ cursor(hand2),
       image('dotruler.xpm'),
       tag(english, 'Measure distance between dots on shield'),
       tag(dutch,   'Meet afstand tussen puntjes op scherm')
     ]).
tool(consline,
     [ cursor(hand2),
       image('consline.xpm'),
       tag(english, 'Vertical Construction line'),
       tag(dutch, 'Verticale hulplijn')
     ]).
tool(hconsline,
     [ cursor(hand2),
       image('hconsline.xpm'),
       tag(english, 'Horizontal Construction line'),
       tag(dutch, 'Horizontale hulplijn')
     ]).
tool(ruler,
     [ cursor(pencil),
       image('ruler.xpm'),
       tag(english, 'Ruler between construction lines'),
       tag(dutch, 'Lineaal tussen hulplijnen')
     ]).
tool(protractor,
     [ cursor(hand2),
       image('protractor.xpm'),
       tag(english, 'Attach protractor to beam'),
       tag(dutch, 'Zet gradenboog op lichtstraal')
     ]).
tool(extend_beam,
     [ cursor(hand2),
       image('extbeam.xpm'),
       tag(english, 'Extend beam using a construction line'),
       tag(dutch, 'Verleng lichtstraal met hulplijn')
     ]).
tool(show_gauges,
     [ image('showgauge.xpm'),
       tag(english, 'Show gauge values'),
       tag(dutch, 'Maak meetwaarden zichtbaar'),
       action(show_gauges)
     ]).
tool(switch,
     [ image('switch.xpm'),
       tag(english, 'Switch light-sources on'),
       tag(dutch, 'Schakel lampen aan'),
       action(switch_on)
     ]).
tool(calculator,
     [ image('calc.xpm'),
       tag(english, 'Create formula'),
       tag(dutch, 'Maak een formule'),
       action(calculator)
     ]).

tool(separator, [next_row]).

tool(tool,
     [ cursor(gumby),
       image('tool.xpm'),
       tag(english, 'Settings'),
       tag(dutch, 'Instellingen')
     ]).
tool(rotlamp,
     [ cursor(@rotlamp_cursor),
       image('rotlamp.xpm'),
       tag(english, 'Rotate a (small) bundle'),
       tag(dutch, 'Draai een (dunne) lichtbundel')
     ]).
tool(movelamp,
     [ cursor(sb_v_double_arrow),
       image('movelamp.xpm'),
       tag(english, 'Move lamp, pointing to same location'),
       tag(dutch, 'Beweeg lamp, schijn op zelfde punt')
     ]).
tool(xmove,
     [ cursor(@xmove_cursor),
       image('xmove.xpm'),
       tag(english, 'Move an object horizontally'),
       tag(dutch, 'Beweeg een object horizontaal')
     ]).
tool(ymove,
     [ cursor(@ymove_cursor),
       image('ymove.xpm'),
       tag(english, 'Move an object vertically'),
       tag(dutch, 'Beweeg een object vertikaal')
     ]).
tool(move,
     [ cursor(fleur),
       image('move.xpm'),
       tag(english, 'Move an object'),
       tag(dutch, 'Beweeg een object')
     ]).

tool(separator, []).

tool(delete,
     [ cursor(pirate),
       image('snapr.xpm'),
       tag(english, 'Delete object from scene'),
       tag(dutch, 'Verwijder een object')
     ]).
tool(delete_all,
     [ image('snapall.xpm'),
       tag(english, 'Delete entire scene'),
       tag(dutch, 'Verwijder alle objecten'),
       action(delete_all)
     ]).

tool(separator, []).

tool(hypothesis_editor,
     [ image('quant.xpm'),
       tag(english, 'Open hypothesis editor'),
       tag(dutch, 'Quantitatieve analyse tool'),
       action(hypothesis_editor)
     ]).
tool(notebook,
     [ image('idea.xpm'),
       tag(english, 'Notebook'),
       tag(dutch, 'Aantekeningen'),
       action(notebook)
     ]).

tool(separator, []).

tool(theory_viewer,
     [ image('theory.xpm'),
       tag(english, 'View theory'),
       tag(dutch, 'Bekijk theorie'),
       action(theory_viewer)
     ]).
tool(assignment_viewer,
     [ image('assignment.xpm'),
       tag(english, 'View assignment'),
       tag(dutch, 'Bekijk opdracht'),
       action(assignment_viewer)
     ]).
tool(help_viewer,
     [ image('winhelp.xpm'),
       tag(english, 'View help document'),
       tag(dutch, 'Bekijk help tekst'),
       action(help_viewer)
     ]).

tool(separator, []).

tool(save,
     [ image('save.xpm'),
       tag(english, 'Make a snapshot of the current settings'),
       tag(dutch, 'Bewaar de huidige toestand'),
       action(save)
     ]).
tool(restore,
     [ image('restore.xpm'),
       tag(english, 'Retreive snapshot'),
       tag(dutch, 'Herstel bewaarde toestand'),
       action(restore)
     ]).

tool(separator, []).

tool(configure,
     [ image('settings.xpm'),
       tag(english, 'Edit configuration'),
       tag(dutch, 'Configuratie editor'),
       action(configure)
     ]).
tool(test_editor,
     [ image('test.xpm'),
       tag(english, 'Edit test'),
       tag(dutch, 'Test editor'),
       action(test_editor)
     ]).

