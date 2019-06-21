/*  Saved optica configurations
    Saved at Wed Mar  5 10:00:07 1997
*/

auto_hide_gauge_values(true).

experiment('Demonstratie',
	   [ initial_state([]),
	     tools([ dotruler,
		     consline,
		     ruler,
		     protractor,
		     extend_beam,
		     show_gauges,
		     calculator,
		     tool,
		     rotlamp,
		     xmove,
		     ymove,
		     delete,
		     delete_all,
		     notebook,
		     theory_viewer,
		     assignment_viewer,
		     help_viewer
		   ]),
	     instruments([ lens0,
			   separator,
			   laser,
			   puntbron,
			   parlamp80,
			   separator,
			   scherm,
			   vangscherm
			 ]),
	     index(2)
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
		       [ default(80),
			 edit(range(-80 - 80))
		       ]),
	     attribute(pos_y,
		       [ edit(range(-10 - 10))
		       ])
	   ]).

instrument(lens0,
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon('Lens')
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
		       [ default(@off)
		       ]),
	     attribute(varname,
		       [ edit(varname)
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
		       [ default(80),
			 edit(range(-80 - 80))
		       ]),
	     attribute(separation, []),
	     attribute(pos_y,
		       [ edit(range(-10 - 10))
		       ])
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
	     cardinality(0, 1),
	     balloon('Lamp, divergerend')
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(80),
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
		       ]),
	     attribute(read_only,
		       [ default(@off)
		       ])
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

language(dutch).

log(false).

log_directory(log).

pretest(none).

test_clear_quickly(true).

test_font(large).

test_mode(false).

test_random_order(true).

test_scale(1).

test_sets([ whatif
	  ]).

test_with_ok_button(false).

