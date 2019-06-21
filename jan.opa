/*  Saved optica configurations
    Saved at Fri Nov  5 16:18:58 1999
*/

auto_hide_gauge_values(true).

auto_switch_off(false).

auto_switch_on(true).

config_file_time_stamp(8.58356e+08).

config_file_time_stamp(8.8772e+08).

config_file_time_stamp(8.8772e+08).

config_file_time_stamp(8.87721e+08).

config_file_time_stamp(8.87722e+08).

config_file_time_stamp(8.87747e+08).

config_file_time_stamp(8.87748e+08).

config_file_time_stamp(8.87748e+08).

config_file_time_stamp(8.87793e+08).

config_file_time_stamp(8.8946e+08).

config_file_time_stamp(8.8946e+08).

config_file_time_stamp(8.89528e+08).

config_file_time_stamp(8.90214e+08).

config_file_time_stamp(8.90216e+08).

config_file_time_stamp(8.90217e+08).

config_file_time_stamp(8.9022e+08).

language(dutch).

log(true).

log_directory(log).

pretest(pretest).

test_clear_quickly(true).

test_font(large).

test_mode(true).

test_moment(logout).

test_random_order(true).

test_scale(1).

test_sets([]).

test_with_ok_button(false).

window(full_screen).

experiment('Vrij Experimenteren',
	   [ initial_state([]),
	     tools([ dotruler,
		     consline,
		     hconsline,
		     ruler,
		     protractor,
		     extend_beam,
		     calculator,
		     tool,
		     rotlamp,
		     xmove,
		     ymove,
		     move,
		     delete,
		     delete_all,
		     hypothesis_editor,
		     notebook,
		     help_viewer,
		     save,
		     restore
		   ]),
	     instruments([ 'ideale-lens',
			   'echte-lens',
			   lhalfrond,
			   rhalfrond,
			   plat,
			   separator,
			   laser,
			   puntbron,
			   parlamp80,
			   separator,
			   biglamp1,
			   scherm,
			   vangscherm
			 ]),
	     index(1)
	   ]).

instrument(biglamp1,
	   [ class(biglamp),
	     icon('biglamp.xpm'),
	     cardinality(0, 1),
	     balloon('Lamp met wijde bundel')
	   ], []).

instrument(bolf10,
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon('Lens f=10')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(10)
		       ]),
	     attribute(sfere_left,
		       [ default(*)
		       ]),
	     attribute(sfere_right,
		       [ default(*)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

instrument(bolf5,
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon('Lens f=5')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(5)
		       ]),
	     attribute(sfere_left,
		       [ default(*)
		       ]),
	     attribute(sfere_right,
		       [ default(*)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

instrument(dubbelbol,
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, 1),
	     balloon('Dubbelbolle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(7)
		       ]),
	     attribute(sfere_left,
		       [ default(10)
		       ]),
	     attribute(sfere_right,
		       [ default(10)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(dubbelhol,
	   [ class(lens),
	     icon('neglens.xpm'),
	     cardinality(0, inf),
	     balloon('Dubbelholle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-7)
		       ]),
	     attribute(sfere_left,
		       [ default(-10)
		       ]),
	     attribute(sfere_right,
		       [ default(-10)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument('echte-lens',
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon('`Echte'' lens')
	   ],
	   [ attribute(label,
		       [ edit(name)
		       ]),
	     attribute(radius,
		       [ default(5),
			 edit(range(0 - inf))
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(*)
		       ]),
	     attribute(sfere_left,
		       [ default(10),
			 edit(range(-100 - 100))
		       ]),
	     attribute(sfere_right,
		       [ default(10),
			 edit(range(-100 - 100))
		       ]),
	     attribute(breaking_index,
		       [ default(1.51),
			 edit(range(0.5 - 5))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname, [])
	   ]).

instrument('f-10',
	   [ class(lens),
	     icon('ideallensC.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens  C')
	   ],
	   [ attribute(label,
		       [ default('C')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-10)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument('f-4',
	   [ class(lens),
	     icon('ideallensC.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens 3')
	   ],
	   [ attribute(label,
		       [ default('C')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-4)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(f10,
	   [ class(lens),
	     icon('ideallensB.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens  B')
	   ],
	   [ attribute(label,
		       [ default('B')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(10)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(f2,
	   [ class(lens),
	     icon('ideallensA.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens  1')
	   ],
	   [ attribute(label,
		       [ default('A')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(2)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(f4,
	   [ class(lens),
	     icon('ideallensB.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens 2')
	   ],
	   [ attribute(label,
		       [ default('B')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(4)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(f5,
	   [ class(lens),
	     icon('ideallensA.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale  Lens  A')
	   ],
	   [ attribute(label,
		       [ default('A')
		       ]),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(5)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument('holf-10',
	   [ class(lens),
	     icon('neglens.xpm'),
	     cardinality(0, inf),
	     balloon('Lens f=-10')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-10)
		       ]),
	     attribute(sfere_left,
		       [ default(*)
		       ]),
	     attribute(sfere_right,
		       [ default(*)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

instrument('holf-5',
	   [ class(lens),
	     icon('neglens.xpm'),
	     cardinality(0, inf),
	     balloon('Lens f=-5')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-5)
		       ]),
	     attribute(sfere_left,
		       [ default(*)
		       ]),
	     attribute(sfere_right,
		       [ default(*)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

instrument('ideale-lens',
	   [ class(lens),
	     icon('ideallens.xpm'),
	     cardinality(0, inf),
	     balloon('Ideale Lens')
	   ],
	   [ attribute(label,
		       [ edit(name)
		       ]),
	     attribute(radius,
		       [ default(5),
			 edit(range(0 - inf))
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(5),
			 edit(range(-50 - 50))
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index, []),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on),
			 edit(bool)
		       ]),
	     attribute(varname,
		       [ edit(name)
		       ])
	   ]).

instrument(laser,
	   [ class(lamp1),
	     icon('lamp1.xpm'),
	     cardinality(0, 1),
	     balloon('Draaibaar lampje met een lichtstraal')
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(pos_y,
		       [ edit(range(-10 - 10))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ])
	   ]).

instrument(lhalfrond,
	   [ class(lens),
	     icon('thickleft.xpm'),
	     cardinality(0, inf),
	     balloon('Half-rond glas')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0)
		       ]),
	     attribute(focal_distance,
		       [ default(*)
		       ]),
	     attribute(sfere_left,
		       [ default(100)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51),
			 edit(range(0.5 - 5))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(oog,
	   [ class(eye),
	     icon('eye.xpm'),
	     cardinality(0, inf),
	     balloon('Oog')
	   ],
	   [ attribute(pos_x,
		       [ edit(on_bar)
		       ])
	   ]).

instrument(parlamp80,
	   [ class(parlamp),
	     icon('parlamp.xpm'),
	     cardinality(0, 1),
	     balloon('Lamp met drie paralelle lichtstralen')
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(separation,
		       [ default(0.5)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(pos_y,
		       [ edit(range(-10 - 10))
		       ])
	   ]).

instrument(plat,
	   [ class(lens),
	     icon('flatlens.xpm'),
	     cardinality(0, inf),
	     balloon('Plat stuk glas')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(1),
			 edit(range(0 - 5))
		       ]),
	     attribute(focal_distance,
		       [ default(*)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(0)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51),
			 edit(range(0.5 - 5))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(platbol,
	   [ class(lens),
	     icon('lflatposlens.xpm'),
	     cardinality(0, 1),
	     balloon('Platbolle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0)
		       ]),
	     attribute(focal_distance,
		       [ default(14)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(10)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51),
			 edit(range(0.5 - 5))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(plathol,
	   [ class(lens),
	     icon('lflatneglens.xpm'),
	     cardinality(0, inf),
	     balloon('Platholle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0)
		       ]),
	     attribute(focal_distance,
		       [ default(-14)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(-10)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@off)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(puntbron,
	   [ class(lamp3),
	     icon('rbulb.xpm'),
	     cardinality(0, inf),
	     balloon('')
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(divergence,
		       [ default(5)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(pos_y,
		       [ edit(range(-10 - 10))
		       ])
	   ]).

instrument(rhalfrond,
	   [ class(lens),
	     icon('thickright.xpm'),
	     cardinality(0, inf),
	     balloon('Rechts halfrond glas')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0)
		       ]),
	     attribute(focal_distance,
		       [ default(*)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
		       ]),
	     attribute(sfere_right,
		       [ default(100)
		       ]),
	     attribute(breaking_index,
		       [ default(1.51),
			 edit(range(0.5 - 5))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname, [])
	   ]).

instrument(scherm,
	   [ class(shield),
	     icon('shield.xpm'),
	     cardinality(0, 1),
	     balloon('Scherm met gaatjes in de vorm van een  `L''')
	   ],
	   [ attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(unit,
		       [ default(1),
			 edit(range(0.1 - 2))
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

instrument(vangscherm,
	   [ class(shield2),
	     icon('shield2.xpm'),
	     cardinality(0, 1),
	     balloon('Scherm om  beeld op te vangen')
	   ],
	   [ attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(varname,
		       [ edit(varname)
		       ])
	   ]).

text(assignment, 'fase 1',
     '<B>Opdracht</B>:

Probeer door het uitvoeren van experimenten te achterhalen wat er
gebeurt als een lichtstraal door een relatief dikke lens gaat.  Welke
principes kun je vinden?',
     [ show_at_open(true)
     ]).

text(assignment, 'fase 2',
     "<B>Opdracht</B>

Probeer door het uitvoeren van experimenten te achterhalen wat de
verschillen zijn tussen de dunne lenzen A, B en C. Welke principes kun
je vinden?
",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 3',
     "<B>Opdracht</B>

Probeer door het uitvoeren van experimenten te achterhalen wat de
verschillen zijn tussen de dunne lenzen A, B en C als een divergerende
lichtbundel op de lens valt.  Welke principes kun je vinden?
",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 4',
     "<B>Opdracht</B>

Probeer door het uitvoeren van experimenten te achterhalen wat de
samenhang is tussen brandpuntsafstand, voorwerpsafstand en beeldsafstand
voor de lenzen A en B.  Welke principes kun je vinden?
",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 5',
     "<B>Opdracht</B>:

Probeer door het uitvoeren van experimenten te achterhalen wat de
samenhang is tussen brandpuntsafstand, voorwerp en afbeelding voor de
lenzen A, B en C.  Welke principes kun je vinden?",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 6',
     "<B>Opdracht</B>

Probeer door het uitvoeren van experimenten te achterhalen hoe beelden
gevormd worden als je meerdere lenzen achter elkaar zet. Welke
principes kun je ontdekken?",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 7',
     "<B>Opdracht</B>

Probeer door het uitvoeren van experimenten te achterhalen hoe beelden
gevormd worden als je meerdere lenzen achter elkaar zet.  Welke
principes kan je ontdekken?",
     [ show_at_open(true)
     ]).

text(help, 'Vrij Experimenteren',
     "De `Vrij Experimenteren' geeft een vrijwel onbegrensde toegang tot de
optica simulatie.  In deze omgeving zijn de volgende instrumenten
aanwezig:

<IMG SRC=""ideallens.xpm"">Ideale lens.   Modellering gebeurt m.b.v. de wet voor ideale lenzen.
       Vele attributen zijn instelbaar.

<IMG SRC=""poslens.xpm"">`Echte' lens.  Modellering gebeurt m.b.v.  de wet van Snellius die de
        breking van licht aan een scheidingsvlak tussen twee
        verschillende media beschrijft.", []).

text(help, 'fase 1',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""lamp1.xpm"">	Lamp (laser).  Deze lamp geeft één evenwijdige lichtbundel,
	weergegeven door een zwarte lijn.  De lichtbundel is draaibaar
	via 'draaien lichtstralen' of via 'wijzig object attributen'.  

<IMG SRC=""poslens.xpm"">	Lenzen.  Er zijn vier verschillende lenzen in deze fase.  Er kan
	maar één lens tegelijk op de bank staan.

<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende
fase.  Je kunt geen fase overslaan.  Je kunt deze fase verlaten als je
minimaal vijf minuten aan het experimenteren bent geweest.
", []).

text(help, 'fase 2',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""lamp1.xpm"">	Lamp (laser).  Deze lamp geeft één evenwijdige lichtbundel,
	weergegeven door een zwarte lijn.  De lichtbundel is draaibaar
	via 'draaien lichtstralen' of via 'wijzig object attributen'.  

<IMG SRC=""parlamp.xpm"">	Lamp (evenwijdig). Deze lamp geeft drie evenwijdige lichtstralen,
	weergegeven door drie zwarte lijnen.  De drie stralen zijn samen
	draaibaar via 'draaien lichtstralen' of via 'wijzig object
	attributen'.

<IMG SRC=""ideallensA.xpm"">	Lenzen. Er zijn drie verschillende lenzen in deze fase. Er kan maar
	één lens tegelijk op de bank staan.


<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende
fase.  Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlaten als je minimaal vijf minuten aan
het experimenteren bent geweest.", []).

text(help, 'fase 3',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""rbulb.xpm"">	Lamp (divergerend).  Deze lamp geeft drie divergerende
	lichtstralen, weergegeven door drie zwarte lijnen.  De
	lichtstralen zijn draaibaar via 'draaien lichtstralen' of via
	'wijzig object attributen'.

<IMG SRC=""ideallensA.xpm"">	Lenzen.  Er zijn drie verschillende lenzen in deze fase.  Er kan
	maar één lens tegelijk op de bank staan.

<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende
fase.  Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlaten als je minimaal tien minuten aan
het experimenteren bent geweest.

", []).

text(help, 'fase 4',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""rbulb.xpm"">	Lamp (divergerend).  Deze lamp geeft drie divergerende
	lichtstralen, weergegeven door drie zwarte lijnen.  De
	lichtstralen zijn draaibaar via 'draaien lichtstralen' of via
	'wijzig object attributen'.

<IMG SRC=""biglamp.xpm"">	Lamp (grote lichtbron).  Deze lamp schijnt alle kanten op.


<IMG SRC=""ideallensA.xpm""> 	Lenzen.  Er zijn twee verschillende lenzen in deze fase.  Er kan
	maar één lens tegelijk op de bank staan.

<IMG SRC=""shield.xpm"">	Voorwerp.  Dit is een plaat met gaatjes in de vorm van de letter
	L.  Als de plaat beschenen wordt door een grote lichtbron die
	alle kanten op schijnt dan kun je de gaatjes beschouwen als
	afzonderlijke puntbronnen.

<IMG SRC=""shield2.xpm"">	Scherm. Op het scherm kunnen voorwerpen afgebeeld worden.

<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""dotruler.xpm"">	Meet afstand tussen puntjes.  Via deze tool kun je de afstand
	tussen puntjes meten door eerst op 'meet afstand tussen puntjes'
	aan te klikken en vervolgens het scherm of voorwerp aan te
	klikken.  Door dubbel te klikken op het beige vakje kun je deze
	waarde een naam geven.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.
Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan
het experimenteren bent geweest.

", []).

text(help, 'fase 5',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""rbulb.xpm"">	Lamp (divergerend).  Deze lamp geeft drie divergerende
	lichtstralen, weergegeven door drie zwarte lijnen.  De
	lichtstralen zijn draaibaar via 'draaien lichtstralen' of via
	'wijzig object attributen'.

<IMG SRC=""biglamp.xpm"">	Lamp (grote lichtbron).  Deze lamp schijnt alle kanten op.


<IMG SRC=""ideallensA.xpm""> 	Lenzen.  Er zijn drie verschillende lenzen in deze fase.  Er kan
	maar één lens tegelijk op de bank staan.

<IMG SRC=""shield.xpm"">	Voorwerp.  Dit is een plaat met gaatjes in de vorm van de letter
	L.  Als de plaat beschenen wordt door een grote lichtbron die
	alle kanten op schijnt dan kun je de gaatjes beschouwen als
	afzonderlijke puntbronnen.

<IMG SRC=""shield2.xpm"">	Scherm. Op het scherm kunnen voorwerpen afgebeeld worden.

<IMG SRC=""eye.xpm"">	Oog.  Door het oog op de bank te plaatsen wordt zichtbaar wat je
	ziet als je vanaf de rechterkant van de bank in de lens kijkt.
	De plek waar het zicht op de lens wordt weergegeven is de plek
	waar het voorwerp vandaan lijkt te komen.

<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""dotruler.xpm"">	Meet afstand tussen puntjes.  Via deze tool kun je de afstand
	tussen puntjes meten door eerst op 'meet afstand tussen puntjes'
	aan te klikken en vervolgens het scherm of voorwerp aan te
	klikken.  Door dubbel te klikken op het beige vakje kun je deze
	waarde een naam geven.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.
Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan
het experimenteren bent geweest.

", []).

text(help, 'fase 6',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""rbulb.xpm"">	Lamp (divergerend).  Deze lamp geeft drie divergerende
	lichtstralen, weergegeven door drie zwarte lijnen.  De
	lichtstralen zijn draaibaar via 'draaien lichtstralen' of via
	'wijzig object attributen'.

<IMG SRC=""poslens.xpm""> 	Lenzen.  Er zijn twee verschillende lenzen in deze fase. 


<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.


<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.
Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan
het experimenteren bent geweest.

", []).

text(help, 'fase 7',
     "<B>A. Objecten:</B>

Alle objecten zijn op de bank te plaatsen door eerst met de muis op het
icon te klikken en vervolgens te klikken op de plek waar je het object
wil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te
verplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en
vervolgens het slepen van het betreffende object, en (2) door eerst het
aanklikken van 'wijzig object attributen' en vervolgens door het intypen
van de gewenste waarde van de plek op de bank.  In deze fase zijn de
volgende objecten te gebruiken voor de experimenten:

<IMG SRC=""rbulb.xpm"">	Lamp (divergerend).  Deze lamp geeft drie divergerende
	lichtstralen, weergegeven door drie zwarte lijnen.  De
	lichtstralen zijn draaibaar via 'draaien lichtstralen' of via
	'wijzig object attributen'.

<IMG SRC=""biglamp.xpm"">	Lamp (grote lichtbron).  Deze lamp schijnt alle kanten op.

<IMG SRC=""poslens.xpm""> 	Lenzen.  Er zijn twee verschillende lenzen in deze fase.

<IMG SRC=""shield.xpm"">	Voorwerp.  Dit is een plaat met gaatjes in de vorm van de letter
	L.  Als de plaat beschenen wordt door een grote lichtbron die
	alle kanten op schijnt dan kun je de gaatjes beschouwen als
	afzonderlijke puntbronnen.

<IMG SRC=""shield2.xpm"">	Scherm. Op het scherm kunnen voorwerpen afgebeeld worden.

<IMG SRC=""eye.xpm"">	Oog.  Door het oog op de bank te plaatsen wordt zichtbaar wat je
	ziet als je vanaf de rechterkant van de bank in de lens kijkt.
	De plek waar het zicht op de lens wordt weergegeven is de plek
	waar het voorwerp vandaan lijkt te komen.

<B>B. Tools</B>

De tools gebruik je om objecten te manipuleren.  Je klikt op een
toolicon naar keuze, en door vervolgens op een object die de bank staat
te klikken pas je het tool toe opdat object.

<IMG SRC=""rotlamp.xpm"">	Draai een lichtbundel.  Door op 'draai een lichtbundel' te
	klikken kun je een lichtstraal draaien.  Je gaat met de muis
	naar de lichtstraal die je wil bewegen, je klikt en houdt de
	muis vast en sleept de straal tot je hem zo hebt verplaatst
	zoals je hem wil hebben.

<IMG SRC=""protractor.xpm"">	Hoekmeter.  Je kan ook de hoek van een lichtstraal meten die de
	lichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik
	eerst op 'zet gradenboog op lichtstraal' en klik vervolgens op
	de lichtstraal waar je de hoek van wil meten.

<IMG SRC=""extbeam.xpm"">	Hulplijnen.  Het is mogelijk een lichtstraal te verlengen met
	een gekleurde hulplijn.  Dit doe je door op 'hulplijn' te
	klikken en vervolgens te klikken op de lichtstraal waarlangs je
	een hulplijn wil trekken.

<IMG SRC=""xmove.xpm""> <IMG SRC=""ymove.xpm"">
	Beweeg een object.  Een object is te verplaatsen door te klikken
	op 'beweeg een object'.  Vervolgens klik je op het betreffende
	object, je houdt de muis vast en sleept het naar de plek waar je
	de lens wil hebben.  Dan pas laat je de muis weer los.

<IMG SRC=""consline.xpm"">	Meetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je
	door een meetlijn op de bank te plaatsen, op dezelfde manier als
	bij een object.  Klikken op 'meetlijnen' en klikken op de plek
	waar je de lijn wil hebben.

<IMG SRC=""ruler.xpm"">	Lengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.
	Je klikt op 'lengtemeter', gaat met de muis naar de blauwe
	stippellijn door het midden van de lens, de klikt en je ziet een
	zwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de
	muis naar de meetlijn, wacht tot er nog een vierkantje
	verschijnt en laat dan pas de muis los.  Op de zwarte
	stippellijn verschijnt de afstand.  Deze afstand kun je een naam
	geven, door dubbel op het vakje te klikken.

<IMG SRC=""dotruler.xpm"">	Meet afstand tussen puntjes.  Via deze tool kun je de afstand
	tussen puntjes meten door eerst op 'meet afstand tussen puntjes'
	aan te klikken en vervolgens het scherm of voorwerp aan te
	klikken.  Door dubbel te klikken op het beige vakje kun je deze
	waarde een naam geven.

<IMG SRC=""tool.xpm"">	Wijzig object attributen.  Via deze tool is het mogelijk
	verschillende dingen van een object te veranderen.  Je kunt
	bijvoorbeeld de plek van een object veranderen door op 'wijzig
	object attributen' te klikken.  Vervolgens klik je op het
	betreffende object.  Er verschijnt een klein scherm waarin je
	precies in kan toetsen waar je het object wil hebben.  Druk op
	apply en op quit.  Dit is ook mogelijk voor andere kenmerken dan
	de plaats van het object.

<IMG SRC=""showgauge.xpm"">	Meten.  De waarde van een afstand of een hoek verdwijnt van het
	scherm als die afstand of hoek gewijzigd wordt.  In plaats van
	de waarde komen er vraagtekens in het vakje.  Door op 'meten' te
	drukken verschijnt de nieuwe waarde van de afstand of hoek in
	het vakje.
	
<IMG SRC=""snapr.xpm"">	Verwijder een object.  Door eerst op 'verwijder een object' te
	klikken en vervolgens op een object, meetlijn, of hulplijn te
	klikken verdwijnt dat aangeklikte object, die meetlijn of
	hulplijn.

<B><B>C. Algemene acties</B></B>

Deze acties staan los van objecten.

<IMG SRC=""theory.xpm"">	Theorie.  Tijdens het werken in deze fase kun je op elk gewenst
	moment de theorie oproepen, door op 'theorie' te klikken.  Via
	een klik op 'exit' kom je weer terug.


<IMG SRC=""assignment.xpm"">	Opdracht.  Tijdens het werken in deze fase kun je ook op elk
	gewenst moment de opdracht oproepen, door op 'opdracht' te
	klikken.

<IMG SRC=""winhelp.xpm"">	Help.  Door op 'help' te klikken verschijnt uitleg over de
	objecten en tools van de fase waarin je zit.  De uitleg is
	verdeeld over 'objecten', 'tools' en 'algemene acties'.

<IMG SRC=""idea.xpm"">	Aantekeningen.  Er is de mogelijkheid om aantekeningen te maken.
	Dat doe je door te klikken op 'aantekeningen'.  Er verschijnen
	drie schermpjes.  De bovenste geeft de huidige situatie op de
	bank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als
	je de situatie plus aantekeningen bewaart dan geef je daar een
	naam bij en verschijnt het onder die naam in de lijst
	linksonder.  Door op een naam linksonder te klikken roep je een
	eerder gemaakte aantekening weer op.

<IMG SRC=""calc.xpm"">	Rekenmachine.  U krijgt een invulveld waarin U een formule kunt
	typen.  Deze formule kan bestaan uit de tekens +, -, / en *,
	getallen, namen van meetinstrumenten en (haakjes).   De formule
	wordt, met de huidige waarde op het werkblad gezet, en kan
	met de bewegings, aflees en verwijder tools gemanipuleerd
	worden.  Formules worden opgeslagen in aantekeningen.

<IMG SRC=""snapall.xpm"">	Verwijder alle objecten.  Door op 'verwijder alle objecten' te
	klikken verdwijnen alle objecten op de bank.  De bank is dan
	weer leeg.

<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.
Je mag ook terug naar een eerdere fase, maar je kunt geen fase
overslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan
het experimenteren bent geweest.

", []).

text(theory, 'fase 1',
     '<B>Theorie</B>

Alle onderdelen van Optica gaan over licht.  Zoals bekend wordt licht
opgewekt en uitgezonden door lichtbronnen, bijvoorbeeld een gloeilamp,
een TL-buis of de zon.  Een belangrijk eigenschap van licht is dat het
zich rechtlijnig voortbeweegt.

Men onderscheidt drie soorten lichtbundels:

- Divergerende lichtbundels: de lichtstralen komen uit één punt.
- Convergerende lichtbundels: de lichtstralen gaan naar één punt.
- Evenwijdige lichtbundels: de lichtstralen hebben dezelfde richting.

De lichtbron die beschikbaar is in fase 1 geeft één smalle, evenwijdige
lichtbundel, weergegeven door een dunne lijn.

Voor de experimenten die je in Optica gaat doen gebruik je naast de
lichtbronnen verschillende lenzen.  Een lens is een doorschijnend
voorwerp, meestal van glas, dat begrensd wordt door ten minste één
gebogen oppervlak.  In fase 1 bekijken we relatief dikke lenzen waarbij
de gebogen oppervlakken bolvormig zijn.  Je hebt bolle, positieve lenzen
en holle, negatieve lenzen.  De lijn die loodrecht door het midden van
de lens gaat noemen we de <I>hoofdas</I>.
',
     [ show_at_open(true)
     ]).

text(theory, 'fase 2',
     "<B>Theorie</B>

Als een bundel lichtstralen evenwijdig aan de hoofdas op een positieve
lens valt dan blijkt dat de uittredende lichtstralen door één punt op de
hoofdas gaan. Dit wordt een brandpunt ( <I>f</I> ) van de lens genoemd. De
brandpuntsafstand is de afstand van de lens tot het brandpunt.

Negatieve lenzen hebben ook een brandpunt. Als een bundel lichtstralen
evenwijdig aan de hoofdas op een negatieve lens valt dan gaan de
uittredende stralen niet door één punt maar lijkt het alsof de
uittredende lichtstralen uit één punt op de hoofdas komen.  Dit punt
wordt het brandpunt van de negatieve lens genoemd en krijgt een
negatieve waarde.

De lenzen die we in deze fase bekijken zijn zogenaamde dunne lenzen van
hooguit enkele milimeters. Deze worden hier voorgesteld als een dikke
streep. Een belangrijke eigenschap van dunne lenzen is dat een
lichtstraal gericht op het midden van de lens ongebroken doorgaat,
d.w.z. niet van richting verandert.
",
     [ show_at_open(true)
     ]).

text(theory, 'fase 3',
     "<B>theorie</B>

Met lenzen kun je beelden vormen van voorwerpen.  Voorbeelden hiervan
zijn fotocamera's en diaprojectors, die voorwerpen uit de werkelijkheid
afbeelden.

In deze fase gebruiken we als voorwerp een lampje met een divergerende
lichtbundel.  In tegenstelling tot de lampjes uit fase 1 en 2 gaan de
lichtstralen van dit lampje verschillende kanten op.  We noemen zo'n
lampje een <I>puntbron</I>.  De stralen van dit lampje zijn weergegeven door
drie dunne lijnen.
",
     [ show_at_open(true)
     ]).

text(theory, 'fase 4',
     "<B>Theorie</B>

In dit onderdeel gebruiken we als voorwerp een metalen plaatje met
gaatjes in de vorm van een 'L', die vanaf de linkerkant wordt belicht
door een krachtige lichtbron.  De gaatjes in de metalen plaat kun je
daardoor opvatten als afzonderlijke puntbronnen.  Ook hier is er geen
sprake van evenwijdige lichtstralen maar van puntbronnen die alle kanten
op schijnen.  Let op dat van de krachtige lichtbron de stralen niet
worden afgebeeld.

Via een lens kunnen deze lichtbronnen afgebeeld worden op een scherm.
De afstand van het voorwerp tot de lens wordt voorwerpsafstand
genoemd.  De afstand van het beeld tot de lens wordt beeldsafstand
genoemd
",
     [ show_at_open(true)
     ]).

text(theory, 'fase 5',
     "<B>Theorie</B>:

In fase 5 gebruiken we opnieuw de letter 'L' als voorwerp.  Je hebt voor
het experimenteren de drie lenzen A, B en C tot je beschikking.

In deze fase is het ook mogelijk om vanaf de rechterkant in de lens te
kijken.  Door het oog op de bank te plaatsen wordt zichtbaar wat je ziet
als je vanaf de rechterkant van de bank in de lens kijkt.  De plek waar
het zicht op de lens wordt weergegeven is de plek waar het voorwerp
vandaan lijkt te komen.",
     [ show_at_open(true)
     ]).

text(theory, 'fase 6',
     "<B>Theorie</B>

Tot nu toe hebben we telkens gekeken naar licht door één lens tegelijk.
Het is natuurlijk mogelijk om meerdere lenzen achter elkaar te zetten en
een voorwerp via meerdere lenzen af te beelden.  In deze fase gebruiken
we als voorwerp weer het lampje met een divergerende lichtbundel,
waarvan de lichtstralen verschillende kanten opgaan.

Bij de lenzen in deze fase zijn de brandpuntsafstanden onderaan de lens
weergegeven.",
     [ show_at_open(true)
     ]).

text(theory, 'fase 7',
     "<B>theorie</B>

Ook in deze fase is het mogelijk om meerdere lenzen achter elkaar te
zetten en een voorwerp via twee lenzen af te beelden.  We gebruiken als
voorwerp weer het metalen plaatje met gaatjes in de vorm van een 'L'",
     [ show_at_open(true)
     ]).

