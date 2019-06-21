/*  Saved optica configurations
    Saved at Thu May  4 16:32:06 2000
*/

auto_hide_gauge_values(true).

auto_switch_off(false).

auto_switch_on(true).

config_file_time_stamp(8.58356e+08).

config_file_time_stamp(9.54934e+08).

config_file_time_stamp(9.57277e+08).

config_file_time_stamp(9.57354e+08).

config_file_time_stamp(9.5745e+08).

language(dutch).

log(true).

log_directory(log).

plugin(stress(stress('casper.sgml'))).

pretest(pretest).

test_clear_quickly(true).

test_font(large).

test_mode(true).

test_moment(logout).

test_random_order(true).

test_scale(1).

test_sets([]).

test_with_ok_button(false).

window(window).

window_height(0.75).

window_y(0.23).

experiment(afbeelden,
	   [ initial_state(state(state, '', [])),
	     tools([ dotruler,
		     consline,
		     hconsline,
		     ruler,
		     protractor,
		     extend_beam,
		     show_gauges,
		     tool,
		     rotlamp,
		     xmove,
		     ymove,
		     delete
		   ]),
	     instruments([ 'lens A',
			   'lens B',
			   'lens C',
			   separator,
			   lampje1,
			   lamp2,
			   lampje3,
			   biglamp1,
			   'L-plaat',
			   scherm,
			   oog
			 ]),
	     index(1),
	     max_lenses(1)
	   ]).

instrument('L-plaat',
	   [ class(shield),
	     icon('shield.xpm'),
	     cardinality(0, inf),
	     balloon('Plaat met gaatjes erin (die een L vormen)')
	   ],
	   [ attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(unit,
		       [ default(1),
			 edit(range(0.1 - 2))
		       ]),
	     attribute(varname,
		       [ edit(name)
		       ])
	   ]).

instrument(biglamp1,
	   [ class(biglamp),
	     icon('biglamp.xpm'),
	     cardinality(0, 1),
	     balloon('Lamp met wijde bundel')
	   ], []).

instrument(lamp2,
	   [ class(parlamp),
	     icon('parlamp.xpm'),
	     cardinality(0, 1),
	     balloon('lamp met evenwijdige lichtbundel')
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
	     icon('lamp1.xpm'),
	     cardinality(0, 1),
	     balloon('lampje met een lichtstraal')
	   ],
	   [ attribute(switch,
		       [ default(@on)
		       ]),
	     attribute(angle,
		       [ default(0),
			 edit(range(-80 - 80))
		       ]),
	     attribute(pos_y,
		       [ edit(set([]))
		       ]),
	     attribute(pos_x,
		       [ edit(set([]))
		       ])
	   ]).

instrument(lampje3,
	   [ class(lamp3),
	     icon('rbulb.xpm'),
	     cardinality(0, 1),
	     balloon('lamp met divergerende lichtbundel')
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

instrument('lens A',
	   [ class(lens),
	     icon('ideallensa.xpm'),
	     cardinality(0, inf),
	     balloon('lens A')
	   ],
	   [ attribute(label,
		       [ default('A'),
			 edit(name)
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
		       [ default(2),
			 edit(range(-100 - 100))
		       ]),
	     attribute(sfere_right,
		       [ default(2)
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

instrument('lens B',
	   [ class(lens),
	     icon('ideallensb.xpm'),
	     cardinality(0, inf),
	     balloon('lens B')
	   ],
	   [ attribute(label,
		       [ default('B'),
			 edit(name)
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
		       [ default(5)
		       ]),
	     attribute(sfere_right,
		       [ default(5)
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

instrument('lens C',
	   [ class(lens),
	     icon('ideallensc.xpm'),
	     cardinality(0, inf),
	     balloon('lens C')
	   ],
	   [ attribute(label,
		       [ default('C'),
			 edit(name)
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

instrument(scherm,
	   [ class(shield2),
	     icon('shield2.xpm'),
	     cardinality(0, inf),
	     balloon(projectiescherm)
	   ],
	   [ attribute(pos_x,
		       [ edit(on_bar)
		       ]),
	     attribute(varname,
		       [ edit(name)
		       ])
	   ]).

