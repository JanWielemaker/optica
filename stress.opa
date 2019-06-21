/*  Saved optica configurations
    Saved at Fri Mar  3 12:46:36 2000
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

config_file_time_stamp(8.90058e+08).

config_file_time_stamp(8.90058e+08).

config_file_time_stamp(8.90061e+08).

config_file_time_stamp(8.90065e+08).

config_file_time_stamp(8.90066e+08).

config_file_time_stamp(8.90067e+08).

config_file_time_stamp(8.90067e+08).

config_file_time_stamp(8.90071e+08).

config_file_time_stamp(8.90215e+08).

config_file_time_stamp(8.90225e+08).

config_file_time_stamp(8.90233e+08).

config_file_time_stamp(8.90238e+08).

config_file_time_stamp(8.90309e+08).

config_file_time_stamp(8.9031e+08).

config_file_time_stamp(8.9031e+08).

config_file_time_stamp(8.90313e+08).

config_file_time_stamp(9.49411e+08).

config_file_time_stamp(9.52082e+08).

language(dutch).

log(true).

log_directory(log).

plugin(stress(stress('stress.sgml'))).

pretest(pretest).

test_clear_quickly(true).

test_font(large).

test_mode(true).

test_moment(experiment).

test_random_order(true).

test_scale(1).

test_sets([ whatif2,
	    normal2
	  ]).

test_with_ok_button(false).

window(window).

window_height(0.7).

window_y(0.25).

experiment(einde,
	   [ initial_state([]),
	     tools([]),
	     instruments([]),
	     index(5)
	   ]).

experiment(fase_1,
	   [ initial_state([]),
	     tools([ consline,
		     hconsline,
		     ruler,
		     protractor,
		     show_gauges,
		     switch,
		     tool,
		     rotlamp,
		     xmove,
		     delete,
		     delete_all,
		     theory_viewer,
		     assignment_viewer,
		     help_viewer
		   ]),
	     instruments([ 'dubbelbolle lens',
			   'platbolle lens',
			   'dubbelholle lens',
			   'platholle lens',
			   separator,
			   lampje1
			 ]),
	     index(1),
	     minimum_time(3),
	     max_lenses(1)
	   ]).

experiment(fase_2,
	   [ initial_state([]),
	     tools([ consline,
		     hconsline,
		     ruler,
		     protractor,
		     extend_beam,
		     show_gauges,
		     switch,
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
	     instruments([ 'lens A',
			   'lens B',
			   'lens C',
			   separator,
			   lamp2
			 ]),
	     index(2),
	     minimum_time(3),
	     max_lenses(1)
	   ]).

experiment(fase_3,
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
	     instruments([ 'lens A',
			   'lens B',
			   'lens C',
			   separator,
			   lampje3
			 ]),
	     index(3),
	     minimum_time(5),
	     max_lenses(1)
	   ]).

experiment(fase_4,
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
	     instruments([ 'veranderbare lens',
			   separator,
			   lampje3
			 ]),
	     index(4),
	     minimum_time(5)
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

instrument('dubbelbolle lens',
	   [ class(lens),
	     icon('poslens.xpm'),
	     cardinality(0, 1),
	     balloon('dubbelbolle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(3)
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

instrument('dubbelholle lens',
	   [ class(lens),
	     icon('neglens.xpm'),
	     cardinality(0, 1),
	     balloon('dubbelholle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-3)
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
	     balloon('`Echte\' lens')
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
	     icon('lamp1out.xpm'),
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
		       [ default(0)
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
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
		       [ default(0),
			 edit(range(0 - 0))
		       ]),
	     attribute(pos_x,
		       [ edit(on_bar)
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
		       [ default(8)
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
		       [ default(-8)
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

instrument('platbolle lens',
	   [ class(lens),
	     icon('lflatposlens.xpm'),
	     cardinality(0, 1),
	     balloon('platbolle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(6)
		       ]),
	     attribute(sfere_left,
		       [ default(0)
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

instrument('platholle lens',
	   [ class(lens),
	     icon('lflatneglens.xpm'),
	     cardinality(0, 1),
	     balloon('platholle lens')
	   ],
	   [ attribute(label, []),
	     attribute(radius,
		       [ default(5)
		       ]),
	     attribute(thickness,
		       [ default(0.1)
		       ]),
	     attribute(focal_distance,
		       [ default(-6)
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
	     balloon('Scherm met gaatjes in de vorm van een  `L\'')
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

instrument('veranderbare lens',
	   [ class(lens),
	     icon('ideallens.xpm'),
	     cardinality(0, inf),
	     balloon('veranderbare lens')
	   ],
	   [ attribute(label,
		       [ edit(name)
		       ]),
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

text(assignment, 'fase 1',
     '<B>Opdracht</B>:\n\nProbeer door het uitvoeren van experimenten te achterhalen wat er\ngebeurt als een lichtstraal door een relatief dikke lens gaat.  Welke\nprincipes kun je vinden?',
     [ show_at_open(true)
     ]).

text(assignment, 'fase 2',
     "<B>Opdracht</B>\n\nProbeer door het uitvoeren van experimenten te achterhalen wat de\nverschillen zijn tussen de dunne lenzen A, B en C. Welke principes kun\nje vinden?\n",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 3',
     "<B>Opdracht</B>\n\nProbeer door het uitvoeren van experimenten te achterhalen wat de\nverschillen zijn tussen de dunne lenzen A, B en C als een divergerende\nlichtbundel op de lens valt.  Welke principes kun je vinden?\n",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 4',
     "<B>Opdracht</B>\n\nProbeer door het uitvoeren van experimenten te achterhalen wat de\nsamenhang is tussen brandpuntsafstand, voorwerpsafstand en beeldsafstand\nvoor de lenzen A en B.  Welke principes kun je vinden?\n",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 5',
     "<B>Opdracht</B>:\n\nProbeer door het uitvoeren van experimenten te achterhalen wat de\nsamenhang is tussen brandpuntsafstand, voorwerp en afbeelding voor de\nlenzen A, B en C.  Welke principes kun je vinden?",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 6',
     "<B>Opdracht</B>\n\nProbeer door het uitvoeren van experimenten te achterhalen hoe beelden\ngevormd worden als je meerdere lenzen achter elkaar zet. Welke\nprincipes kun je ontdekken?",
     [ show_at_open(true)
     ]).

text(assignment, 'fase 7',
     "<B>Opdracht</B>\n\nProbeer door het uitvoeren van experimenten te achterhalen hoe beelden\ngevormd worden als je meerdere lenzen achter elkaar zet.  Welke\nprincipes kan je ontdekken?",
     [ show_at_open(true)
     ]).

text(assignment, fase_1,
     "Probeer door het uitvoeren van experimenten te achterhalen wat er\ngebeurt als een lichtstraal door een van de dikke lenzen gaat. \nWanneer snijdt de uittredende lichtstraal de hoofdas en waardoor wordt\nde plaats van dit snijpunt bepaald?\nWat is het verschil tussen de vier dikke lenzen?",
     [ show_at_open(true)
     ]).

text(assignment, fase_2,
     "Probeer door het uitvoeren van experimenten te achterhalen waardoor de\nplaats van het snijpunt van de uittredende lichtstralen wordt bepaald\nals een evenwijdige lichtbundel op de lens valt.\nWat zijn de brandpuntsafstanden van de drie lenzen?",
     [ show_at_open(true)
     ]).

text(assignment, fase_3,
     "Probeer door het uitvoeren van experimenten te achterhalen wanneer de\nuittredende lichtstralen elkaar gaan snijden als een divergerende\nlichtbundel op een lens valt.\nIn hoeverre is dat afhankelijk van de brandpuntsafstand van de lens?\nWaardoor wordt de plaats van het reeel en virtueel beeldpunt bepaald?\nWelke regel kun je vinden voor de vergroting?",
     [ show_at_open(true)
     ]).

text(assignment, fase_4,
     "Probeer door het uitvoeren van experimenten te achterhalen hoe beelden\ngevormd worden door meerdere lenzen achter elkaar.\nHoe werken de lenzen samen?\nOp welke manier kan je de plaats en de brandpuntsafstand van de lens\nbepalen die een lenzenstelsel vervangt?",
     [ show_at_open(true)
     ]).

text(help, 'Vrij Experimenteren',
     "De `Vrij Experimenteren' geeft een vrijwel onbegrensde toegang tot de\noptica simulatie.  In deze omgeving zijn de volgende instrumenten\naanwezig:\n\n<IMG SRC=\"ideallens.xpm\">Ideale lens.   Modellering gebeurt m.b.v. de wet voor ideale lenzen.\n       Vele attributen zijn instelbaar.\n\n<IMG SRC=\"poslens.xpm\">`Echte' lens.  Modellering gebeurt m.b.v.  de wet van Snellius die de\n        breking van licht aan een scheidingsvlak tussen twee\n        verschillende media beschrijft.",
     []).

text(help, 'fase 1',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"lamp1.xpm\">\tLamp (laser).  Deze lamp geeft één evenwijdige lichtbundel,\n\tweergegeven door een zwarte lijn.  De lichtbundel is draaibaar\n\tvia 'draaien lichtstralen' of via 'wijzig object attributen'.  \n\n<IMG SRC=\"poslens.xpm\">\tLenzen.  Er zijn vier verschillende lenzen in deze fase.  Er kan\n\tmaar één lens tegelijk op de bank staan.\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende\nfase.  Je kunt geen fase overslaan.  Je kunt deze fase verlaten als je\nminimaal vijf minuten aan het experimenteren bent geweest.\n",
     []).

text(help, 'fase 2',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"lamp1.xpm\">\tLamp (laser).  Deze lamp geeft één evenwijdige lichtbundel,\n\tweergegeven door een zwarte lijn.  De lichtbundel is draaibaar\n\tvia 'draaien lichtstralen' of via 'wijzig object attributen'.  \n\n<IMG SRC=\"parlamp.xpm\">\tLamp (evenwijdig). Deze lamp geeft drie evenwijdige lichtstralen,\n\tweergegeven door drie zwarte lijnen.  De drie stralen zijn samen\n\tdraaibaar via 'draaien lichtstralen' of via 'wijzig object\n\tattributen'.\n\n<IMG SRC=\"ideallensA.xpm\">\tLenzen. Er zijn drie verschillende lenzen in deze fase. Er kan maar\n\téén lens tegelijk op de bank staan.\n\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende\nfase.  Je mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlaten als je minimaal vijf minuten aan\nhet experimenteren bent geweest.",
     []).

text(help, 'fase 3',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"rbulb.xpm\">\tLamp (divergerend).  Deze lamp geeft drie divergerende\n\tlichtstralen, weergegeven door drie zwarte lijnen.  De\n\tlichtstralen zijn draaibaar via 'draaien lichtstralen' of via\n\t'wijzig object attributen'.\n\n<IMG SRC=\"ideallensA.xpm\">\tLenzen.  Er zijn drie verschillende lenzen in deze fase.  Er kan\n\tmaar één lens tegelijk op de bank staan.\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je deze fase doorlopen hebt kun je door naar de volgende\nfase.  Je mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlaten als je minimaal tien minuten aan\nhet experimenteren bent geweest.\n\n",
     []).

text(help, 'fase 4',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"rbulb.xpm\">\tLamp (divergerend).  Deze lamp geeft drie divergerende\n\tlichtstralen, weergegeven door drie zwarte lijnen.  De\n\tlichtstralen zijn draaibaar via 'draaien lichtstralen' of via\n\t'wijzig object attributen'.\n\n<IMG SRC=\"biglamp.xpm\">\tLamp (grote lichtbron).  Deze lamp schijnt alle kanten op.\n\n\n<IMG SRC=\"ideallensA.xpm\"> \tLenzen.  Er zijn twee verschillende lenzen in deze fase.  Er kan\n\tmaar één lens tegelijk op de bank staan.\n\n<IMG SRC=\"shield.xpm\">\tVoorwerp.  Dit is een plaat met gaatjes in de vorm van de letter\n\tL.  Als de plaat beschenen wordt door een grote lichtbron die\n\talle kanten op schijnt dan kun je de gaatjes beschouwen als\n\tafzonderlijke puntbronnen.\n\n<IMG SRC=\"shield2.xpm\">\tScherm. Op het scherm kunnen voorwerpen afgebeeld worden.\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"dotruler.xpm\">\tMeet afstand tussen puntjes.  Via deze tool kun je de afstand\n\ttussen puntjes meten door eerst op 'meet afstand tussen puntjes'\n\taan te klikken en vervolgens het scherm of voorwerp aan te\n\tklikken.  Door dubbel te klikken op het beige vakje kun je deze\n\twaarde een naam geven.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.\nJe mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan\nhet experimenteren bent geweest.\n\n",
     []).

text(help, 'fase 5',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"rbulb.xpm\">\tLamp (divergerend).  Deze lamp geeft drie divergerende\n\tlichtstralen, weergegeven door drie zwarte lijnen.  De\n\tlichtstralen zijn draaibaar via 'draaien lichtstralen' of via\n\t'wijzig object attributen'.\n\n<IMG SRC=\"biglamp.xpm\">\tLamp (grote lichtbron).  Deze lamp schijnt alle kanten op.\n\n\n<IMG SRC=\"ideallensA.xpm\"> \tLenzen.  Er zijn drie verschillende lenzen in deze fase.  Er kan\n\tmaar één lens tegelijk op de bank staan.\n\n<IMG SRC=\"shield.xpm\">\tVoorwerp.  Dit is een plaat met gaatjes in de vorm van de letter\n\tL.  Als de plaat beschenen wordt door een grote lichtbron die\n\talle kanten op schijnt dan kun je de gaatjes beschouwen als\n\tafzonderlijke puntbronnen.\n\n<IMG SRC=\"shield2.xpm\">\tScherm. Op het scherm kunnen voorwerpen afgebeeld worden.\n\n<IMG SRC=\"eye.xpm\">\tOog.  Door het oog op de bank te plaatsen wordt zichtbaar wat je\n\tziet als je vanaf de rechterkant van de bank in de lens kijkt.\n\tDe plek waar het zicht op de lens wordt weergegeven is de plek\n\twaar het voorwerp vandaan lijkt te komen.\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"dotruler.xpm\">\tMeet afstand tussen puntjes.  Via deze tool kun je de afstand\n\ttussen puntjes meten door eerst op 'meet afstand tussen puntjes'\n\taan te klikken en vervolgens het scherm of voorwerp aan te\n\tklikken.  Door dubbel te klikken op het beige vakje kun je deze\n\twaarde een naam geven.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.\nJe mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan\nhet experimenteren bent geweest.\n\n",
     []).

text(help, 'fase 6',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"rbulb.xpm\">\tLamp (divergerend).  Deze lamp geeft drie divergerende\n\tlichtstralen, weergegeven door drie zwarte lijnen.  De\n\tlichtstralen zijn draaibaar via 'draaien lichtstralen' of via\n\t'wijzig object attributen'.\n\n<IMG SRC=\"poslens.xpm\"> \tLenzen.  Er zijn twee verschillende lenzen in deze fase. \n\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.\nJe mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan\nhet experimenteren bent geweest.\n\n",
     []).

text(help, 'fase 7',
     "<B>A. Objecten:</B>\n\nAlle objecten zijn op de bank te plaatsen door eerst met de muis op het\nicon te klikken en vervolgens te klikken op de plek waar je het object\nwil plaatsen.  Eenmaal op de bank zijn de objecten op twee manieren te\nverplaatsen: (1) Door eerst het aanklikken van 'beweeg een object' en\nvervolgens het slepen van het betreffende object, en (2) door eerst het\naanklikken van 'wijzig object attributen' en vervolgens door het intypen\nvan de gewenste waarde van de plek op de bank.  In deze fase zijn de\nvolgende objecten te gebruiken voor de experimenten:\n\n<IMG SRC=\"rbulb.xpm\">\tLamp (divergerend).  Deze lamp geeft drie divergerende\n\tlichtstralen, weergegeven door drie zwarte lijnen.  De\n\tlichtstralen zijn draaibaar via 'draaien lichtstralen' of via\n\t'wijzig object attributen'.\n\n<IMG SRC=\"biglamp.xpm\">\tLamp (grote lichtbron).  Deze lamp schijnt alle kanten op.\n\n<IMG SRC=\"poslens.xpm\"> \tLenzen.  Er zijn twee verschillende lenzen in deze fase.\n\n<IMG SRC=\"shield.xpm\">\tVoorwerp.  Dit is een plaat met gaatjes in de vorm van de letter\n\tL.  Als de plaat beschenen wordt door een grote lichtbron die\n\talle kanten op schijnt dan kun je de gaatjes beschouwen als\n\tafzonderlijke puntbronnen.\n\n<IMG SRC=\"shield2.xpm\">\tScherm. Op het scherm kunnen voorwerpen afgebeeld worden.\n\n<IMG SRC=\"eye.xpm\">\tOog.  Door het oog op de bank te plaatsen wordt zichtbaar wat je\n\tziet als je vanaf de rechterkant van de bank in de lens kijkt.\n\tDe plek waar het zicht op de lens wordt weergegeven is de plek\n\twaar het voorwerp vandaan lijkt te komen.\n\n<B>B. Tools</B>\n\nDe tools gebruik je om objecten te manipuleren.  Je klikt op een\ntoolicon naar keuze, en door vervolgens op een object die de bank staat\nte klikken pas je het tool toe opdat object.\n\n<IMG SRC=\"rotlamp.xpm\">\tDraai een lichtbundel.  Door op 'draai een lichtbundel' te\n\tklikken kun je een lichtstraal draaien.  Je gaat met de muis\n\tnaar de lichtstraal die je wil bewegen, je klikt en houdt de\n\tmuis vast en sleept de straal tot je hem zo hebt verplaatst\n\tzoals je hem wil hebben.\n\n<IMG SRC=\"protractor.xpm\">\tHoekmeter.  Je kan ook de hoek van een lichtstraal meten die de\n\tlichtstraal maakt met deze lijn, die we de hoofdas noemen.  Klik\n\teerst op 'zet gradenboog op lichtstraal' en klik vervolgens op\n\tde lichtstraal waar je de hoek van wil meten.\n\n<IMG SRC=\"extbeam.xpm\">\tHulplijnen.  Het is mogelijk een lichtstraal te verlengen met\n\teen gekleurde hulplijn.  Dit doe je door op 'hulplijn' te\n\tklikken en vervolgens te klikken op de lichtstraal waarlangs je\n\teen hulplijn wil trekken.\n\n<IMG SRC=\"xmove.xpm\"> <IMG SRC=\"ymove.xpm\">\n\tBeweeg een object.  Een object is te verplaatsen door te klikken\n\top 'beweeg een object'.  Vervolgens klik je op het betreffende\n\tobject, je houdt de muis vast en sleept het naar de plek waar je\n\tde lens wil hebben.  Dan pas laat je de muis weer los.\n\n<IMG SRC=\"consline.xpm\">\tMeetlijnen.  Het is mogelijk om afstanden te meten.  Dat doe je\n\tdoor een meetlijn op de bank te plaatsen, op dezelfde manier als\n\tbij een object.  Klikken op 'meetlijnen' en klikken op de plek\n\twaar je de lijn wil hebben.\n\n<IMG SRC=\"ruler.xpm\">\tLengtemeter.  Je kunt de afstand tussen twee meetlijnen meten.\n\tJe klikt op 'lengtemeter', gaat met de muis naar de blauwe\n\tstippellijn door het midden van de lens, de klikt en je ziet een\n\tzwart vierkantje verschijnen.  Houd de muis ingedrukt, sleep de\n\tmuis naar de meetlijn, wacht tot er nog een vierkantje\n\tverschijnt en laat dan pas de muis los.  Op de zwarte\n\tstippellijn verschijnt de afstand.  Deze afstand kun je een naam\n\tgeven, door dubbel op het vakje te klikken.\n\n<IMG SRC=\"dotruler.xpm\">\tMeet afstand tussen puntjes.  Via deze tool kun je de afstand\n\ttussen puntjes meten door eerst op 'meet afstand tussen puntjes'\n\taan te klikken en vervolgens het scherm of voorwerp aan te\n\tklikken.  Door dubbel te klikken op het beige vakje kun je deze\n\twaarde een naam geven.\n\n<IMG SRC=\"tool.xpm\">\tWijzig object attributen.  Via deze tool is het mogelijk\n\tverschillende dingen van een object te veranderen.  Je kunt\n\tbijvoorbeeld de plek van een object veranderen door op 'wijzig\n\tobject attributen' te klikken.  Vervolgens klik je op het\n\tbetreffende object.  Er verschijnt een klein scherm waarin je\n\tprecies in kan toetsen waar je het object wil hebben.  Druk op\n\tapply en op quit.  Dit is ook mogelijk voor andere kenmerken dan\n\tde plaats van het object.\n\n<IMG SRC=\"showgauge.xpm\">\tMeten.  De waarde van een afstand of een hoek verdwijnt van het\n\tscherm als die afstand of hoek gewijzigd wordt.  In plaats van\n\tde waarde komen er vraagtekens in het vakje.  Door op 'meten' te\n\tdrukken verschijnt de nieuwe waarde van de afstand of hoek in\n\thet vakje.\n\t\n<IMG SRC=\"snapr.xpm\">\tVerwijder een object.  Door eerst op 'verwijder een object' te\n\tklikken en vervolgens op een object, meetlijn, of hulplijn te\n\tklikken verdwijnt dat aangeklikte object, die meetlijn of\n\thulplijn.\n\n<B><B>C. Algemene acties</B></B>\n\nDeze acties staan los van objecten.\n\n<IMG SRC=\"theory.xpm\">\tTheorie.  Tijdens het werken in deze fase kun je op elk gewenst\n\tmoment de theorie oproepen, door op 'theorie' te klikken.  Via\n\teen klik op 'exit' kom je weer terug.\n\n\n<IMG SRC=\"assignment.xpm\">\tOpdracht.  Tijdens het werken in deze fase kun je ook op elk\n\tgewenst moment de opdracht oproepen, door op 'opdracht' te\n\tklikken.\n\n<IMG SRC=\"winhelp.xpm\">\tHelp.  Door op 'help' te klikken verschijnt uitleg over de\n\tobjecten en tools van de fase waarin je zit.  De uitleg is\n\tverdeeld over 'objecten', 'tools' en 'algemene acties'.\n\n<IMG SRC=\"idea.xpm\">\tAantekeningen.  Er is de mogelijkheid om aantekeningen te maken.\n\tDat doe je door te klikken op 'aantekeningen'.  Er verschijnen\n\tdrie schermpjes.  De bovenste geeft de huidige situatie op de\n\tbank weer.  Rechtsonder kun je aantekeningen daarbij maken.  Als\n\tje de situatie plus aantekeningen bewaart dan geef je daar een\n\tnaam bij en verschijnt het onder die naam in de lijst\n\tlinksonder.  Door op een naam linksonder te klikken roep je een\n\teerder gemaakte aantekening weer op.\n\n<IMG SRC=\"calc.xpm\">\tRekenmachine.  U krijgt een invulveld waarin U een formule kunt\n\ttypen.  Deze formule kan bestaan uit de tekens +, -, / en *,\n\tgetallen, namen van meetinstrumenten en (haakjes).   De formule\n\twordt, met de huidige waarde op het werkblad gezet, en kan\n\tmet de bewegings, aflees en verwijder tools gemanipuleerd\n\tworden.  Formules worden opgeslagen in aantekeningen.\n\n<IMG SRC=\"snapall.xpm\">\tVerwijder alle objecten.  Door op 'verwijder alle objecten' te\n\tklikken verdwijnen alle objecten op de bank.  De bank is dan\n\tweer leeg.\n\n<B>Fase</B>.  Als je een fase doorlopen hebt kun je door naar de volgende fase.\nJe mag ook terug naar een eerdere fase, maar je kunt geen fase\noverslaan.  Je kunt deze fase verlatenals je minimaal vijf minuten aan\nhet experimenteren bent geweest.\n\n",
     []).

text(help, fase_1,
     "Uitleg van de objecten:\nJe kunt de objecten gebruiken door met de muis op het icoon te klikken\nen vervolgens te klikken op de plek waar je het object wil plaatsen.\nEenmaal op de werkbank zijn de objecten te manipuleren met de\nonderstaande instrumenten.\n\n<IMG SRC=\"poslens.xpm\">Dubbelbolle lens\n\n<IMG SRC=\"lflatposlens.xpm\">Platbolle lens\n\n<IMG SRC=\"neglens.xpm\">Dubbelholle lens\n\n<IMG SRC=\"lflatneglens.xpm\">Platholle lens\n\n<IMG SRC=\"consline.xpm\">Vertikale meetlijn om breedte te meten\n\n<IMG SRC=\"hconsline.xpm\">Horizontale meetlijn om hoogte te meten\n\n\nUitleg instrumenten:\nMet deze instrumenten zijn objecten te manipuleren of metingen te\nverrichten.  Klik op het icoon dat je wil gebruiken en klik vervolgens\nop het object op de werkbank dat je wil manipuleren.\n\n<IMG SRC=\"ruler.xpm\">Meten van afstanden.  Klik op dit icoon en trek vervolgens een lijn\ntussen de twee meetlijnen waar je de afstand tussen wil meten.  De\nafstand verschijnt vanzelf.\n\n<IMG SRC=\"protractor.xpm\">Meet hoek.  Klik op icoon en vervolgens op de lichtstraal waar je de\nhoek van wil weten. Waarde van de hoek verschijnt in graden.\n\n<IMG SRC=\"switch.xpm\">Zet lamp aan. Klik op dit icoon en de lamp gaat aan.\n\n<IMG SRC=\"tool.xpm\">Instellen.  Klik op dit icoon, dan op het object dat je wil\nmanipuleren en een scherm verschijnt waarbij je allerlei dingen kan\ninstellen.\n\n<IMG SRC=\"rotlamp.xpm\">Draai lichtstraal.  Klik op icoon en sleep met de muis de straal in\nde gewenste richting.\n\n<IMG SRC=\"xmove.xpm\">Beweeg horizontaal. Klik op icoon en sleep object met de muis.\n\n<IMG SRC=\"ymove.xpm\">Beweeg vertikaal. Klik op icoon en sleep object met de muis.\n\n<IMG SRC=\"snapr.xpm\">Verwijder object.  Klik op icoon en klik op object dat je wil\nverwijderen.\n\n<IMG SRC=\"snapall.xpm\">Verwijder alles. Klik op icoon en bevestig.\n\n<IMG SRC=\"theory.xpm\">Theorie bekijken. Klik op icoon en de theorie verschijnt.\n\n<IMG SRC=\"assignment.xpm\">Opdracht bekijken. Klik op icoon en opdracht verschijnt.\n\n<IMG SRC=\"winhelp.xpm\">Help. Klik op icoon en help verschijnt.\n",
     []).

text(help, fase_2,
     "Uitleg objecten:\nDe objecten zijn te gebruiken door met de muis op het icoon te klikken\nen vervolgens te klikken op de plek waar je het instrument wil hebben.\nEenmaal op de werkbank zijn de objecten te manipuleren met de\nonderstaande instrumenten.\n\n<IMG SRC=\"ideallensa.xpm\">Lens A.\n\n<IMG SRC=\"ideallensb.xpm\">\n\n<IMG SRC=\"ideallensc.xpm\">\n\n<IMG SRC=\"parlamp.xpm\">\n\n<IMG SRC=\"consline.xpm\">\n\n<IMG SRC=\"hconsline.xpm\">\nUitleg instrumenten:\nMet instrumenten kun je objecten manipuleren of meten. Je kunt de\ninstrumenten gebruiken door met de muis op het icoon te klikken en\nvervolgens te klikken op het object dat je wil manipuleren.\n\n<IMG SRC=\"ruler.xpm\">\n\n<IMG SRC=\"protractor.xpm\">\n\n<IMG SRC=\"extbeam.xpm\">\n\n<IMG SRC=\"showgauge.xpm\">\n\n<IMG SRC=\"switch.xpm\">\n\n\n<IMG SRC=\"tool.xpm\">\n\n<IMG SRC=\"rotlamp.xpm\">\n\n<IMG SRC=\"xmove.xpm\">\n\n<IMG SRC=\"ymove.xpm\">\n\n<IMG SRC=\"snapr.xpm\">\n\n<IMG SRC=\"snapall.xpm\">\n\n<IMG SRC=\"theory.xpm\">\n\n<IMG SRC=\"assignment.xpm\">\n\n<IMG SRC=\"winhelp.xpm\">",
     []).

text(help, fase_3,
     "Uitleg objecten;\nJe kunt objecten gebruiken door met de muis op het icoon te klikken en\nvervolgens te klikken op de plek waar je het object wil hebben.  Eenmaal\nop de werkbank kun je de objecten manipuleren met de onderstaande\ninstrumenten.\n\n<IMG SRC=\"ideallensa.xpm\">\n\n<IMG SRC=\"ideallensb.xpm\">\n\n<IMG SRC=\"ideallensc.xpm\">\n\n<IMG SRC=\"rbulb.xpm\">\n\n<IMG SRC=\"consline.xpm\">\n\n<IMG SRC=\"hconsline.xpm\">\n\n<IMG SRC=\"ruler.xpm\">\n\n<IMG SRC=\"protractor.xpm\">\n\n<IMG SRC=\"extbeam.xpm\">\n\n<IMG SRC=\"showgauge.xpm\">\n\n<IMG SRC=\"calc.xpm\">\n\n<IMG SRC=\"switch.xpm\"> \n\n<IMG SRC=\"tool.xpm\">\n\n<IMG SRC=\"rotlamp.xpm\">\n\n<IMG SRC=\"xmove.xpm\">\n\n<IMG SRC=\"ymove.xpm\">\n\n<IMG SRC=\"snapr.xpm\">\n\n<IMG SRC=\"snapall.xpm\">\n\n<IMG SRC=\"theory.xpm\">\n\n<IMG SRC=\"assignment.xpm\">\n\n<IMG SRC=\"winhelp.xpm\">\n\n",
     []).

text(help, fase_4,
     "Uitleg objecten:\nJe kunt de objecten gebruiken door met de muis op het icoon te klikken\nen vervolgens te klikken op de plek waar je het object wil plaatsen.\nEenmaal op de werkbank kun je het object manipuleren met de\nonderstaande instrumenten.\n\n<IMG SRC=\"ideallens.xpm\">Instelbare lens.\n\n<IMG SRC=\"rbulb.xpm\">\n\n<IMG SRC=\"consline.xpm\">\n\n<IMG SRC=\"hconsline.xpm\">\n\n<IMG SRC=\"ruler.xpm\">\n\n<IMG SRC=\"protractor.xpm\">\n\n<IMG SRC=\"extbeam.xpm\">\n\n<IMG SRC=\"showgauge.xpm\">\n\n<IMG SRC=\"switch.xpm\">\n\n<IMG SRC=\"calc.xpm\">\n\n<IMG SRC=\"tool.xpm\">\n\n<IMG SRC=\"rotlamp.xpm\">\n\n<IMG SRC=\"xmove.xpm\">\n\n<IMG SRC=\"ymove.xpm\">\n\n<IMG SRC=\"snapr.xpm\">\n\n<IMG SRC=\"snapall.xpm\">\n\n<IMG SRC=\"theory.xpm\">\n\n<IMG SRC=\"assignment.xpm\">\n\n<IMG SRC=\"winhelp.xpm\">",
     []).

text(theory, 'fase 1',
     '<B>Theorie</B>\n\nAlle onderdelen van Optica gaan over licht.  Zoals bekend wordt licht\nopgewekt en uitgezonden door lichtbronnen, bijvoorbeeld een gloeilamp,\neen TL-buis of de zon.  Een belangrijk eigenschap van licht is dat het\nzich rechtlijnig voortbeweegt.\n\nMen onderscheidt drie soorten lichtbundels:\n\n- Divergerende lichtbundels: de lichtstralen komen uit één punt.\n- Convergerende lichtbundels: de lichtstralen gaan naar één punt.\n- Evenwijdige lichtbundels: de lichtstralen hebben dezelfde richting.\n\nDe lichtbron die beschikbaar is in fase 1 geeft één smalle, evenwijdige\nlichtbundel, weergegeven door een dunne lijn.\n\nVoor de experimenten die je in Optica gaat doen gebruik je naast de\nlichtbronnen verschillende lenzen.  Een lens is een doorschijnend\nvoorwerp, meestal van glas, dat begrensd wordt door ten minste één\ngebogen oppervlak.  In fase 1 bekijken we relatief dikke lenzen waarbij\nde gebogen oppervlakken bolvormig zijn.  Je hebt bolle, positieve lenzen\nen holle, negatieve lenzen.  De lijn die loodrecht door het midden van\nde lens gaat noemen we de <I>hoofdas</I>.\n',
     [ show_at_open(true)
     ]).

text(theory, 'fase 2',
     "<B>Theorie</B>\n\nAls een bundel lichtstralen evenwijdig aan de hoofdas op een positieve\nlens valt dan blijkt dat de uittredende lichtstralen door één punt op de\nhoofdas gaan. Dit wordt een brandpunt ( <I>f</I> ) van de lens genoemd. De\nbrandpuntsafstand is de afstand van de lens tot het brandpunt.\n\nNegatieve lenzen hebben ook een brandpunt. Als een bundel lichtstralen\nevenwijdig aan de hoofdas op een negatieve lens valt dan gaan de\nuittredende stralen niet door één punt maar lijkt het alsof de\nuittredende lichtstralen uit één punt op de hoofdas komen.  Dit punt\nwordt het brandpunt van de negatieve lens genoemd en krijgt een\nnegatieve waarde.\n\nDe lenzen die we in deze fase bekijken zijn zogenaamde dunne lenzen van\nhooguit enkele milimeters. Deze worden hier voorgesteld als een dikke\nstreep. Een belangrijke eigenschap van dunne lenzen is dat een\nlichtstraal gericht op het midden van de lens ongebroken doorgaat,\nd.w.z. niet van richting verandert.\n",
     [ show_at_open(true)
     ]).

text(theory, 'fase 3',
     "<B>theorie</B>\n\nMet lenzen kun je beelden vormen van voorwerpen.  Voorbeelden hiervan\nzijn fotocamera's en diaprojectors, die voorwerpen uit de werkelijkheid\nafbeelden.\n\nIn deze fase gebruiken we als voorwerp een lampje met een divergerende\nlichtbundel.  In tegenstelling tot de lampjes uit fase 1 en 2 gaan de\nlichtstralen van dit lampje verschillende kanten op.  We noemen zo'n\nlampje een <I>puntbron</I>.  De stralen van dit lampje zijn weergegeven door\ndrie dunne lijnen.\n",
     [ show_at_open(true)
     ]).

text(theory, 'fase 4',
     "<B>Theorie</B>\n\nIn dit onderdeel gebruiken we als voorwerp een metalen plaatje met\ngaatjes in de vorm van een 'L', die vanaf de linkerkant wordt belicht\ndoor een krachtige lichtbron.  De gaatjes in de metalen plaat kun je\ndaardoor opvatten als afzonderlijke puntbronnen.  Ook hier is er geen\nsprake van evenwijdige lichtstralen maar van puntbronnen die alle kanten\nop schijnen.  Let op dat van de krachtige lichtbron de stralen niet\nworden afgebeeld.\n\nVia een lens kunnen deze lichtbronnen afgebeeld worden op een scherm.\nDe afstand van het voorwerp tot de lens wordt voorwerpsafstand\ngenoemd.  De afstand van het beeld tot de lens wordt beeldsafstand\ngenoemd\n",
     [ show_at_open(true)
     ]).

text(theory, 'fase 5',
     "<B>Theorie</B>:\n\nIn fase 5 gebruiken we opnieuw de letter 'L' als voorwerp.  Je hebt voor\nhet experimenteren de drie lenzen A, B en C tot je beschikking.\n\nIn deze fase is het ook mogelijk om vanaf de rechterkant in de lens te\nkijken.  Door het oog op de bank te plaatsen wordt zichtbaar wat je ziet\nals je vanaf de rechterkant van de bank in de lens kijkt.  De plek waar\nhet zicht op de lens wordt weergegeven is de plek waar het voorwerp\nvandaan lijkt te komen.",
     [ show_at_open(true)
     ]).

text(theory, 'fase 6',
     "<B>Theorie</B>\n\nTot nu toe hebben we telkens gekeken naar licht door één lens tegelijk.\nHet is natuurlijk mogelijk om meerdere lenzen achter elkaar te zetten en\neen voorwerp via meerdere lenzen af te beelden.  In deze fase gebruiken\nwe als voorwerp weer het lampje met een divergerende lichtbundel,\nwaarvan de lichtstralen verschillende kanten opgaan.\n\nBij de lenzen in deze fase zijn de brandpuntsafstanden onderaan de lens\nweergegeven.",
     [ show_at_open(true)
     ]).

text(theory, 'fase 7',
     "<B>theorie</B>\n\nOok in deze fase is het mogelijk om meerdere lenzen achter elkaar te\nzetten en een voorwerp via twee lenzen af te beelden.  We gebruiken als\nvoorwerp weer het metalen plaatje met gaatjes in de vorm van een 'L'",
     [ show_at_open(true)
     ]).

text(theory, fase_1,
     "In Optica kun je experimenten doen met licht.  Licht wordt opgewekt en\nuitgezonden door<B><I> <B>lichtbronnen</B></I></B>, bijvoorbeeld een gloeilamp, een TL-buis\nof de zon.  Licht gaat in principe rechtdoor.  Voor de experimenten in\nfase 1 kun je als lichtbron een lamp gebruiken die een smalle\nlichtstraal geeft, weergegeven door een dunne zwarte lijn.  De lamp kan\nje plaatsen op een werkbank (de groene lijn) en naar links en naar\nrechts verschuiven.\nVoor experimenten die je in Optica gaat doen gebruik je naast een\nlichtbron verschillende <B><I><B>lenzen</B></I></B>.  Een lens is een doorschijnend voorwerp,\nmeestal van glas, dat tenminste een gebogen zijkant heeft.  In fase 1\nheb je vier dikke lenzen tot je beschikking waarbij de gebogen zijkanten\nbolvormig zijn.  Er zijn bolle, <B><I><B>positieve</B></I></B> lenzen en holle, <B><I><B>negatieve</B></I></B>\nlenzen.  Ook de lenzen kunnen op de werkbank worden neergezet en naar\nlinks en naar rechts verschoven worden.\nElke lens heeft een <B><I><B>hoofdas</B></I></B>.  Dat is een denkbeeldige lijn die loodrecht\ndoor het midden van een lens gaat.  Deze lijn valt in Optica telkens\nsamen met de groene lijn op het scherm.",
     [ show_at_open(true)
     ]).

text(theory, fase_2,
     "In fase 1 heb je het volgende kunnen ontdekken:\n- Nadat een lichtstraal, afkomstig van een lamp op de hoofdas, door een\npositieve lens is gegaan, breekt de uittredende lichtstraal naar de\nhoofdas toe.  De plaats van het snijpunt van deze lichtstraal met de\nhoofdas wordt bepaald door de afstand tussen de lamp en de lens.  Hoe\ngroter die afstand, hoe dichter het snijpunt bij de lens ligt.  Hoe\nkleiner die afstand, hoe verder het snijpunt van de lens ligt, tot deze\nde hoofdas op een gegeven moment niet meer snijdt.\n\n - De hoek van een enkele lichtstraal, afkomstig van een lamp op de\n hoofdas, heeft geen invloed op de plaats waar de uittredende\n lichtstraal de hoofdas snijdt. \n\n- Een dubbelbolle lens breekt een lichtstraal sterker dan een platbolle.\n\n- Nadat een lichtstraal, afkomstig van een lamp op de hoofdas, door een\nnegatieve lens is gegaan, snijdt de uittredende lichtstraal de hoofdas\nniet.\n\n- Een dubbelholle lens breekt een lichtstraal sterker dan een platholle.\n\nTheorie fase 2:\nDe lichtbron die beschikbaar is in fase 2 kan zowel in de hoogte als in\nde breedte verschoven worden en geeft bovendien meerdere lichtstralen.\nMeerdere lichtstralen vormen een lichtbundel.  Men onderscheidt drie\nsoorten lichtbundels:\n- Divergerende lichtbundels; de lichtstralen komen uit een punt.\n- Convergerende lichtbundels; de lichtstralen gaan naar een punt.\n- Evenwijdige lichtbundels; de lichtstralen hebben dezelfde richting.\nDe lichtbron in fase 2 geeft een evenwijdige lichtbundel van drie\nlichtstralen.  Als een evenwijdige lichtbundel op een <B>positieve</B> lens\nvalt, dan blijkt dat de uittredende lichtstralen door een punt gaan.\nDit wordt het <B>brandpunt</B> <B>f</B> van een positieve lens genoemd.  De\n<B>brandpuntsafstand</B> is de afstand van de lens tot het brandpunt.\n\n",
     [ show_at_open(true)
     ]).

text(theory, fase_3,
     "In fase 2 heb je het volgende kunnen ontdekken:\n- Lenzen A en B zijn positieve lenzen, lens C is een negatieve lens.\n\n- Wanneer een evenwijdige lichtbundel door een positieve lens gaat is de\nhoogte van het snijpunt van de uittredende lichtstralen afhankelijk van\nde hoek die de bundel maakt met de hoofdas van de lens.  Hoe groter de\nhoek, hoe hoger het snijpunt, en andersom.  De afstand van de lens tot\nhet snijpunt is afhankelijk van welke lens je gebruikt.  De afstand van\nde lamp tot de lens is bij een evenwijdige bundel niet van belang voor\nde plaats van het snijpunt.\n\n- Wanneer een evenwijdige lichtbundel door een negatieve lens gaat lijkt\nhet alsof de uittredende stralen uit een punt voor de lens komen.  De\nhoogte van dit punt is afhankelijk van de hoek die de invallende bundel\nmaakt met de hoofdas van de lens.  Hoe groter de hoek, hoe hoger dit\npunt, en andersom.  De afstand van dit punt tot de lens is afhankelijk\nvan de lens die je gebruikt.  De afstand van de lamp tot de lens is bij\neen evenwijdige bundel niet van belang voor de plaats van het brandpunt.\n\n- Elke lens heeft een vaste brandpuntsafstand.  Voor de lenzen A, B en C\nis de brandpuntsafstand respectievelijk 8, 4 en -8 cm.\n\nTheorie fase 3:\nFase 3 gaat over <B>beeldvorming</B>.  Met lenzen kun je namelijk beelden\nvormen van voorwerpen.  Een fotocamera bijvoorbeeld kan voorwerpen uit\nde werkelijkheid afbeelden op een lichtgevoelige film, een diaprojector\nbeeldt voorwerpen, dia's, af op een scherm.  In deze fase gebruik je als\n<B>voorwerp</B> een lamp met een divergerende lichtbundel, ook wel puntbron\ngenoemd.  De lichtstralen van deze lamp lopen uit elkaar, en niet\nevenwijdig zoals bij de lamp in fase 2.  De <B>voorwerpsafstand</B> <B>v</B> is de\nafstand van het voorwerp (hier de puntbron) tot de lens.\nAls een divergerende lichtbundel op een lens valt dan gaan in sommige\ngevallen de uittredende lichtstralen door een punt.  Dit snijpunt wordt\neen reeel <B>beeldpunt</B> genoemd.  In andere gevallen gaan de uittredende\nlichtstralen niet door een punt maar lijkt het alsof de uittredende\nstralen <B>uit</B> <B>een</B> <B>punt</B> <B>komen</B>.  Dit punt wordt het <B>virtueel</B> <B>beeldpunt</B>\ngenoemd.  De <B>beeldsafstand</B> <B>b</B> is de afstand van de lens tot het reeel of\nvirtueel beeldpunt,\nDe afstand van het beeld tot de hoofdas hoeft niet gelijk te zijn\naan de afstand van het voorwerp tot de hoofdas. Ligt het beeldpunt\nverder van de hoofdas dan het voorwerp dan is er sprake van een\n<B>vergroting</B> <B>N</B> met een waarde groter dan 1.  Ligt het beeldpunt dichterbij\nde hoofdas dan het voorwerp dan is er sprake van een vergroting met een\nwaarde kleiner dan 1.",
     [ show_at_open(true)
     ]).

text(theory, fase_4,
     "In fase 3 heb je het volgende kunnen ontdekken:\n\n- Wanneer een divergerende lichtbundel door een positieve lens gaat en\nde voorwerpsafstand <B>v</B> is groter dan de brandpuntsafstand <B>f</B> dan is het\nbeeldpunt reeel en ligt aan de andere kant van de hoofdas dan het\nvoorwerp (de lamp).\nAls v &gt; 2f dan ligt het beeldpunt dichter bij de hoofdas dan het\nvoorwerp. De vergroting is dan kleiner dan 1.\nAls v = 2f dan ligt het beeldpunt even ver van de hoofdas als het\nvoorwerp. De vergroting is dan 1.\nAls 2f &gt; v &gt; f dan ligt het beeldpunt verder van de hoofdas dan het\nvoorwerp. De vergroting is dan groter dan 1.\nAls f &gt; v dan is het beeldpunt virtueel en ligt aan dezelfde kant van de\nhoofdas als het voorwerp.  Het beeldpunt ligt verder van de hoofdas af\ndan het voorwerp. De vergroting is groter dan 1.\n\n- Wanneer een divergerende lichtbundel door een negatieve lens gaat is\nhet beeldpunt virtueel en ligt aan dezelfde kant van de hoofdas als het\nvoorwerp. De vergroting is kleiner dan 1.\n\n- De hoek van de invallende stralen heeft geen invloed op de plaats van\nhet reeel en virtueel beeldpunt.\n\n- De verhouding tussen de voorwerpsafstand v en de beeldsafstand b\nis gelijk aan de verhouding tussen de afstand van het voorwerp tot de\nhoofdas en de afstand van het beeldpunt tot de hoofdas.  Met andere\nwoorden, de vergroting N = b/v\n\nTheorie fase 4:\nTot nu toe heb je gekeken naar licht door een lens tegelijk.  De\nsamenhang tussen de voorwerpsafstand, beeldsafstand en\nbrandpuntsafstand is te omschrijven met de lenzenformule:\n1/v + 1/b =1/f.\nHet is natuurlijk mogelijk een voorwerp af te beelden via meerdere\nlenzen, ook wel <B>lenzenstelsel</B> genoemd.  Fase 4 gaat over <B>beeldvorming</B>\nmet lenzenstelsels.  Ook in deze fase gebruik je als voorwerp de lamp\nmet de divergerende lichtbundel.  Een lenzenstelsel vormt op dezelfde\nmanier beelden als een enkele lens.  Ook bij een lenzenstelsel is er dus\nsprake van vergroting, van een voorwerpsafstand en beeldsafstand,  van\neen gemeenschappelijke brandpuntsafstand en geldt er de\nvergrotingsformule en de lenzenformule.  Een lenzenstelsel kun je daarom\n<B>vervangen</B> door een enkele lens met de goede brandpuntsafstand en op de\ngoede plaats.",
     [ show_at_open(true)
     ]).

