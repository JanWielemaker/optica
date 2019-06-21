/*  Saved optica configurations
    Saved at Tue Mar 24 16:26:42 1998
*/

auto_hide_gauge_values(true).

auto_switch_off(false).

auto_switch_on(true).

config_file_time_stamp(8.57552e+008).

config_file_time_stamp(8.90234e+008).

config_file_time_stamp(8.90235e+008).

config_file_time_stamp(8.90314e+008).

config_file_time_stamp(8.90736e+008).

experiment(tutor,
	   [ initial_state([]),
	     tools([ consline,
		     hconsline,
		     ruler,
		     protractor,
		     extend_beam,
		     show_gauges,
		     switch,
		     calculator,
		     tool,
		     rotlamp,
		     xmove,
		     ymove,
		     delete,
		     delete_all,
		     theory_viewer,
		     assignment_viewer,
		     help_viewer
		   ]),
	     instruments([ 'dubbelbolle lens',
			   separator,
			   lamptutor
			 ]),
	     index(1)
	   ]).

experiment('volgende fase',
	   [ initial_state([]),
	     tools([]),
	     instruments([]),
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

instrument('dubbelbolle lens',
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon(lens)
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

instrument(lamp2tutor,
	   [ class(parlamp),
	     icon('parlamp.xpm'),
	     cardinality(0, inf),
	     balloon(lamp2)
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

instrument(lampje1,
	   [ class(lamp1),
	     icon('poslens.xpm'),
	     cardinality(0, inf),
	     balloon(lamp)
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(pos_y, []),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ])
	   ]).

instrument(lamptutor,
	   [ class(lamp1),
	     icon('lamp1out.xpm'),
	     cardinality(0, inf),
	     balloon(lamp)
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(pos_y,
		       [ default(0)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
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

instrument(tutorlens,
	   [ class(lens),
	     icon('ideallens.xpm'),
	     cardinality(0, inf),
	     balloon('')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
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
	     attribute(breaking_index,
		       [ default(1.51)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(show_gauge,
		       [ default(@on)
		       ]),
	     attribute(varname, [])
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

test_moment(logout).

test_random_order(true).

test_scale(1).

test_sets([ whatif
	  ]).

test_with_ok_button(false).

text(assignment, tutor, "Opdracht:", []).

text(theory, tutor, "Theorie:", []).

window(full_screen).

