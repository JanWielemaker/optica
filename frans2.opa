/*  Saved optica configurations
    Saved at Mon Mar 23 13:08:55 1998
*/

auto_hide_gauge_values(true).

auto_switch_off(false).

auto_switch_on(true).

config_file_time_stamp(8.58356e+008).

config_file_time_stamp(8.8772e+008).

config_file_time_stamp(8.8772e+008).

config_file_time_stamp(8.87721e+008).

config_file_time_stamp(8.87722e+008).

config_file_time_stamp(8.87747e+008).

config_file_time_stamp(8.87748e+008).

config_file_time_stamp(8.87748e+008).

config_file_time_stamp(8.87793e+008).

config_file_time_stamp(8.8946e+008).

config_file_time_stamp(8.8946e+008).

config_file_time_stamp(8.89528e+008).

config_file_time_stamp(8.90058e+008).

config_file_time_stamp(8.90058e+008).

config_file_time_stamp(8.90061e+008).

config_file_time_stamp(8.90065e+008).

config_file_time_stamp(8.90066e+008).

config_file_time_stamp(8.90067e+008).

config_file_time_stamp(8.90067e+008).

config_file_time_stamp(8.90071e+008).

config_file_time_stamp(8.90215e+008).

config_file_time_stamp(8.90225e+008).

config_file_time_stamp(8.90233e+008).

config_file_time_stamp(8.90238e+008).

config_file_time_stamp(8.90309e+008).

config_file_time_stamp(8.9031e+008).

config_file_time_stamp(8.9031e+008).

config_file_time_stamp(8.90313e+008).

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

language(dutch).

log(true).

log_directory(log).

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

text(assignment, fase_1,
     "Probeer door het uitvoeren van experimenten te achterhalen wat er
gebeurt als een lichtstraal door een van de dikke lenzen gaat. 
Wanneer snijdt de uittredende lichtstraal de hoofdas en waardoor wordt
de plaats van dit snijpunt bepaald?
Wat is het verschil tussen de vier dikke lenzen?",
     [ show_at_open(true)
     ]).

text(assignment, fase_2,
     "Probeer door het uitvoeren van experimenten te achterhalen waardoor de
plaats van het snijpunt van de uittredende lichtstralen wordt bepaald
als een evenwijdige lichtbundel op de lens valt.
Wat zijn de brandpuntsafstanden van de drie lenzen?",
     [ show_at_open(true)
     ]).

text(assignment, fase_3,
     "Probeer door het uitvoeren van experimenten te achterhalen wanneer de
uittredende lichtstralen elkaar gaan snijden als een divergerende
lichtbundel op een lens valt.
In hoeverre is dat afhankelijk van de brandpuntsafstand van de lens?
Waardoor wordt de plaats van het reeel en virtueel beeldpunt bepaald?
Welke regel kun je vinden voor de vergroting?",
     [ show_at_open(true)
     ]).

text(assignment, fase_4,
     "Probeer door het uitvoeren van experimenten te achterhalen hoe beelden
gevormd worden door meerdere lenzen achter elkaar.
Hoe werken de lenzen samen?
Op welke manier kan je de plaats en de brandpuntsafstand van de lens
bepalen die een lenzenstelsel vervangt?",
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

text(help, fase_1,
     "Uitleg van de objecten:
Je kunt de objecten gebruiken door met de muis op het icoon te klikken
en vervolgens te klikken op de plek waar je het object wil plaatsen.
Eenmaal op de werkbank zijn de objecten te manipuleren met de
onderstaande instrumenten.

<IMG SRC=""poslens.xpm"">Dubbelbolle lens

<IMG SRC=""lflatposlens.xpm"">Platbolle lens

<IMG SRC=""neglens.xpm"">Dubbelholle lens

<IMG SRC=""lflatneglens.xpm"">Platholle lens

<IMG SRC=""consline.xpm"">Vertikale meetlijn om breedte te meten

<IMG SRC=""hconsline.xpm"">Horizontale meetlijn om hoogte te meten


Uitleg instrumenten:
Met deze instrumenten zijn objecten te manipuleren of metingen te
verrichten.  Klik op het icoon dat je wil gebruiken en klik vervolgens
op het object op de werkbank dat je wil manipuleren.

<IMG SRC=""ruler.xpm"">Meten van afstanden.  Klik op dit icoon en trek vervolgens een lijn
tussen de twee meetlijnen waar je de afstand tussen wil meten.  De
afstand verschijnt vanzelf.

<IMG SRC=""protractor.xpm"">Meet hoek.  Klik op icoon en vervolgens op de lichtstraal waar je de
hoek van wil weten. Waarde van de hoek verschijnt in graden.

<IMG SRC=""switch.xpm"">Zet lamp aan. Klik op dit icoon en de lamp gaat aan.

<IMG SRC=""tool.xpm"">Instellen.  Klik op dit icoon, dan op het object dat je wil
manipuleren en een scherm verschijnt waarbij je allerlei dingen kan
instellen.

<IMG SRC=""rotlamp.xpm"">Draai lichtstraal.  Klik op icoon en sleep met de muis de straal in
de gewenste richting.

<IMG SRC=""xmove.xpm"">Beweeg horizontaal. Klik op icoon en sleep object met de muis.

<IMG SRC=""ymove.xpm"">Beweeg vertikaal. Klik op icoon en sleep object met de muis.

<IMG SRC=""snapr.xpm"">Verwijder object.  Klik op icoon en klik op object dat je wil
verwijderen.

<IMG SRC=""snapall.xpm"">Verwijder alles. Klik op icoon en bevestig.

<IMG SRC=""theory.xpm"">Theorie bekijken. Klik op icoon en de theorie verschijnt.

<IMG SRC=""assignment.xpm"">Opdracht bekijken. Klik op icoon en opdracht verschijnt.

<IMG SRC=""winhelp.xpm"">Help. Klik op icoon en help verschijnt.
", []).

text(help, fase_2,
     "Uitleg objecten:
De objecten zijn te gebruiken door met de muis op het icoon te klikken
en vervolgens te klikken op de plek waar je het instrument wil hebben.
Eenmaal op de werkbank zijn de objecten te manipuleren met de
onderstaande instrumenten.

<IMG SRC=""ideallensa.xpm"">Lens A.

<IMG SRC=""ideallensb.xpm"">

<IMG SRC=""ideallensc.xpm"">

<IMG SRC=""parlamp.xpm"">

<IMG SRC=""consline.xpm"">

<IMG SRC=""hconsline.xpm"">
Uitleg instrumenten:
Met instrumenten kun je objecten manipuleren of meten. Je kunt de
instrumenten gebruiken door met de muis op het icoon te klikken en
vervolgens te klikken op het object dat je wil manipuleren.

<IMG SRC=""ruler.xpm"">

<IMG SRC=""protractor.xpm"">

<IMG SRC=""extbeam.xpm"">

<IMG SRC=""showgauge.xpm"">

<IMG SRC=""switch.xpm"">


<IMG SRC=""tool.xpm"">

<IMG SRC=""rotlamp.xpm"">

<IMG SRC=""xmove.xpm"">

<IMG SRC=""ymove.xpm"">

<IMG SRC=""snapr.xpm"">

<IMG SRC=""snapall.xpm"">

<IMG SRC=""theory.xpm"">

<IMG SRC=""assignment.xpm"">

<IMG SRC=""winhelp.xpm"">", []).

text(help, fase_3,
     "Uitleg objecten;
Je kunt objecten gebruiken door met de muis op het icoon te klikken en
vervolgens te klikken op de plek waar je het object wil hebben.  Eenmaal
op de werkbank kun je de objecten manipuleren met de onderstaande
instrumenten.

<IMG SRC=""ideallensa.xpm"">

<IMG SRC=""ideallensb.xpm"">

<IMG SRC=""ideallensc.xpm"">

<IMG SRC=""rbulb.xpm"">

<IMG SRC=""consline.xpm"">

<IMG SRC=""hconsline.xpm"">

<IMG SRC=""ruler.xpm"">

<IMG SRC=""protractor.xpm"">

<IMG SRC=""extbeam.xpm"">

<IMG SRC=""showgauge.xpm"">

<IMG SRC=""calc.xpm"">

<IMG SRC=""switch.xpm""> 

<IMG SRC=""tool.xpm"">

<IMG SRC=""rotlamp.xpm"">

<IMG SRC=""xmove.xpm"">

<IMG SRC=""ymove.xpm"">

<IMG SRC=""snapr.xpm"">

<IMG SRC=""snapall.xpm"">

<IMG SRC=""theory.xpm"">

<IMG SRC=""assignment.xpm"">

<IMG SRC=""winhelp.xpm"">

", []).

text(help, fase_4,
     "Uitleg objecten:
Je kunt de objecten gebruiken door met de muis op het icoon te klikken
en vervolgens te klikken op de plek waar je het object wil plaatsen.
Eenmaal op de werkbank kun je het object manipuleren met de
onderstaande instrumenten.

<IMG SRC=""ideallens.xpm"">Instelbare lens.

<IMG SRC=""rbulb.xpm"">

<IMG SRC=""consline.xpm"">

<IMG SRC=""hconsline.xpm"">

<IMG SRC=""ruler.xpm"">

<IMG SRC=""protractor.xpm"">

<IMG SRC=""extbeam.xpm"">

<IMG SRC=""showgauge.xpm"">

<IMG SRC=""switch.xpm"">

<IMG SRC=""calc.xpm"">

<IMG SRC=""tool.xpm"">

<IMG SRC=""rotlamp.xpm"">

<IMG SRC=""xmove.xpm"">

<IMG SRC=""ymove.xpm"">

<IMG SRC=""snapr.xpm"">

<IMG SRC=""snapall.xpm"">

<IMG SRC=""theory.xpm"">

<IMG SRC=""assignment.xpm"">

<IMG SRC=""winhelp.xpm"">", []).

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

text(theory, fase_1,
     "In Optica kun je experimenten doen met licht.  Licht wordt opgewekt en
uitgezonden door<B><I> <B>lichtbronnen</B></I></B>, bijvoorbeeld een gloeilamp, een TL-buis
of de zon.  Licht gaat in principe rechtdoor.  Voor de experimenten in
fase 1 kun je als lichtbron een lamp gebruiken die een smalle
lichtstraal geeft, weergegeven door een dunne zwarte lijn.  De lamp kan
je plaatsen op een werkbank (de groene lijn) en naar links en naar
rechts verschuiven.
Voor experimenten die je in Optica gaat doen gebruik je naast een
lichtbron verschillende <B><I><B>lenzen</B></I></B>.  Een lens is een doorschijnend voorwerp,
meestal van glas, dat tenminste een gebogen zijkant heeft.  In fase 1
heb je vier dikke lenzen tot je beschikking waarbij de gebogen zijkanten
bolvormig zijn.  Er zijn bolle, <B><I><B>positieve</B></I></B> lenzen en holle, <B><I><B>negatieve</B></I></B>
lenzen.  Ook de lenzen kunnen op de werkbank worden neergezet en naar
links en naar rechts verschoven worden.
Elke lens heeft een <B><I><B>hoofdas</B></I></B>.  Dat is een denkbeeldige lijn die loodrecht
door het midden van een lens gaat.  Deze lijn valt in Optica telkens
samen met de groene lijn op het scherm.",
     [ show_at_open(true)
     ]).

text(theory, fase_2,
     "In fase 1 heb je het volgende kunnen ontdekken:
- Nadat een lichtstraal, afkomstig van een lamp op de hoofdas, door een
positieve lens is gegaan, breekt de uittredende lichtstraal naar de
hoofdas toe.  De plaats van het snijpunt van deze lichtstraal met de
hoofdas wordt bepaald door de afstand tussen de lamp en de lens.  Hoe
groter die afstand, hoe dichter het snijpunt bij de lens ligt.  Hoe
kleiner die afstand, hoe verder het snijpunt van de lens ligt, tot deze
de hoofdas op een gegeven moment niet meer snijdt.

 - De hoek van een enkele lichtstraal, afkomstig van een lamp op de
 hoofdas, heeft geen invloed op de plaats waar de uittredende
 lichtstraal de hoofdas snijdt. 

- Een dubbelbolle lens breekt een lichtstraal sterker dan een platbolle.

- Nadat een lichtstraal, afkomstig van een lamp op de hoofdas, door een
negatieve lens is gegaan, snijdt de uittredende lichtstraal de hoofdas
niet.

- Een dubbelholle lens breekt een lichtstraal sterker dan een platholle.

Theorie fase 2:
De lichtbron die beschikbaar is in fase 2 kan zowel in de hoogte als in
de breedte verschoven worden en geeft bovendien meerdere lichtstralen.
Meerdere lichtstralen vormen een lichtbundel.  Men onderscheidt drie
soorten lichtbundels:
- Divergerende lichtbundels; de lichtstralen komen uit een punt.
- Convergerende lichtbundels; de lichtstralen gaan naar een punt.
- Evenwijdige lichtbundels; de lichtstralen hebben dezelfde richting.
De lichtbron in fase 2 geeft een evenwijdige lichtbundel van drie
lichtstralen.  Als een evenwijdige lichtbundel op een <B>positieve</B> lens
valt, dan blijkt dat de uittredende lichtstralen door een punt gaan.
Dit wordt het <B>brandpunt</B> <B>f</B> van een positieve lens genoemd.  De
<B>brandpuntsafstand</B> is de afstand van de lens tot het brandpunt.

",
     [ show_at_open(true)
     ]).

text(theory, fase_3,
     "In fase 2 heb je het volgende kunnen ontdekken:
- Lenzen A en B zijn positieve lenzen, lens C is een negatieve lens.

- Wanneer een evenwijdige lichtbundel door een positieve lens gaat is de
hoogte van het snijpunt van de uittredende lichtstralen afhankelijk van
de hoek die de bundel maakt met de hoofdas van de lens.  Hoe groter de
hoek, hoe hoger het snijpunt, en andersom.  De afstand van de lens tot
het snijpunt is afhankelijk van welke lens je gebruikt.  De afstand van
de lamp tot de lens is bij een evenwijdige bundel niet van belang voor
de plaats van het snijpunt.

- Wanneer een evenwijdige lichtbundel door een negatieve lens gaat lijkt
het alsof de uittredende stralen uit een punt voor de lens komen.  De
hoogte van dit punt is afhankelijk van de hoek die de invallende bundel
maakt met de hoofdas van de lens.  Hoe groter de hoek, hoe hoger dit
punt, en andersom.  De afstand van dit punt tot de lens is afhankelijk
van de lens die je gebruikt.  De afstand van de lamp tot de lens is bij
een evenwijdige bundel niet van belang voor de plaats van het brandpunt.

- Elke lens heeft een vaste brandpuntsafstand.  Voor de lenzen A, B en C
is de brandpuntsafstand respectievelijk 8, 4 en -8 cm.

Theorie fase 3:
Fase 3 gaat over <B>beeldvorming</B>.  Met lenzen kun je namelijk beelden
vormen van voorwerpen.  Een fotocamera bijvoorbeeld kan voorwerpen uit
de werkelijkheid afbeelden op een lichtgevoelige film, een diaprojector
beeldt voorwerpen, dia's, af op een scherm.  In deze fase gebruik je als
<B>voorwerp</B> een lamp met een divergerende lichtbundel, ook wel puntbron
genoemd.  De lichtstralen van deze lamp lopen uit elkaar, en niet
evenwijdig zoals bij de lamp in fase 2.  De <B>voorwerpsafstand</B> <B>v</B> is de
afstand van het voorwerp (hier de puntbron) tot de lens.
Als een divergerende lichtbundel op een lens valt dan gaan in sommige
gevallen de uittredende lichtstralen door een punt.  Dit snijpunt wordt
een reeel <B>beeldpunt</B> genoemd.  In andere gevallen gaan de uittredende
lichtstralen niet door een punt maar lijkt het alsof de uittredende
stralen <B>uit</B> <B>een</B> <B>punt</B> <B>komen</B>.  Dit punt wordt het <B>virtueel</B> <B>beeldpunt</B>
genoemd.  De <B>beeldsafstand</B> <B>b</B> is de afstand van de lens tot het reeel of
virtueel beeldpunt,
De afstand van het beeld tot de hoofdas hoeft niet gelijk te zijn
aan de afstand van het voorwerp tot de hoofdas. Ligt het beeldpunt
verder van de hoofdas dan het voorwerp dan is er sprake van een
<B>vergroting</B> <B>N</B> met een waarde groter dan 1.  Ligt het beeldpunt dichterbij
de hoofdas dan het voorwerp dan is er sprake van een vergroting met een
waarde kleiner dan 1.",
     [ show_at_open(true)
     ]).

text(theory, fase_4,
     "In fase 3 heb je het volgende kunnen ontdekken:

- Wanneer een divergerende lichtbundel door een positieve lens gaat en
de voorwerpsafstand <B>v</B> is groter dan de brandpuntsafstand <B>f</B> dan is het
beeldpunt reeel en ligt aan de andere kant van de hoofdas dan het
voorwerp (de lamp).
Als v &gt; 2f dan ligt het beeldpunt dichter bij de hoofdas dan het
voorwerp. De vergroting is dan kleiner dan 1.
Als v = 2f dan ligt het beeldpunt even ver van de hoofdas als het
voorwerp. De vergroting is dan 1.
Als 2f &gt; v &gt; f dan ligt het beeldpunt verder van de hoofdas dan het
voorwerp. De vergroting is dan groter dan 1.
Als f &gt; v dan is het beeldpunt virtueel en ligt aan dezelfde kant van de
hoofdas als het voorwerp.  Het beeldpunt ligt verder van de hoofdas af
dan het voorwerp. De vergroting is groter dan 1.

- Wanneer een divergerende lichtbundel door een negatieve lens gaat is
het beeldpunt virtueel en ligt aan dezelfde kant van de hoofdas als het
voorwerp. De vergroting is kleiner dan 1.

- De hoek van de invallende stralen heeft geen invloed op de plaats van
het reeel en virtueel beeldpunt.

- De verhouding tussen de voorwerpsafstand v en de beeldsafstand b
is gelijk aan de verhouding tussen de afstand van het voorwerp tot de
hoofdas en de afstand van het beeldpunt tot de hoofdas.  Met andere
woorden, de vergroting N = b/v

Theorie fase 4:
Tot nu toe heb je gekeken naar licht door een lens tegelijk.  De
samenhang tussen de voorwerpsafstand, beeldsafstand en
brandpuntsafstand is te omschrijven met de lenzenformule:
1/v + 1/b =1/f.
Het is natuurlijk mogelijk een voorwerp af te beelden via meerdere
lenzen, ook wel <B>lenzenstelsel</B> genoemd.  Fase 4 gaat over <B>beeldvorming</B>
met lenzenstelsels.  Ook in deze fase gebruik je als voorwerp de lamp
met de divergerende lichtbundel.  Een lenzenstelsel vormt op dezelfde
manier beelden als een enkele lens.  Ook bij een lenzenstelsel is er dus
sprake van vergroting, van een voorwerpsafstand en beeldsafstand,  van
een gemeenschappelijke brandpuntsafstand en geldt er de
vergrotingsformule en de lenzenformule.  Een lenzenstelsel kun je daarom
<B>vervangen</B> door een enkele lens met de goede brandpuntsafstand en op de
goede plaats.",
     [ show_at_open(true)
     ]).

window(full_screen).

