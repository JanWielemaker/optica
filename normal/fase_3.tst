question(1, 'item 3-1',
	 'Welke afstand geeft weer waar een
divergerende lichtbundel samenkomt?  Het
lampje staat 1 centimeter boven de hoofdas.',
	 [ 'Afstand A',
	   'Afstand B',
	   'Afstand C',
	   'weet niet'
	 ],
	 state(state, '',
	       [ m16 = lens(label(''),
			    radius(5),
			    thickness(0.1),
			    focal_distance(6),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(11.95),
			    show_gauge(true),
			    instrument_name(lens)),
		 l17 = lamp3(switch(false),
			     angle(0),
			     divergence(5),
			     pos_x(-0.05),
			     pos_y(1),
			     instrument_name(lamp3)),
		 c3  = construction_line(pos_x(17.95),
					 instrument_name(consline)),
		 c4  = construction_line(pos_x(23.9),
					 instrument_name(consline)),
		 c5  = construction_line(pos_x(29.95),
					 instrument_name(consline)),
		 d12 = ruler(from(c3),
			     to(m16),
			     pos_y(6.65),
			     varname('A')),
		 d13 = ruler(from(m16),
			     to(c4),
			     pos_y(5.8),
			     varname('B')),
		 d14 = ruler(from(m16),
			     to(c5),
			     pos_y(4.6),
			     varname('C')),
		 d15 = ruler(from(m16),
			     to(centerline),
			     pos_y(6.2))
	       ])).
question(2, 'item 3-2',
	 'Op welke afstand van de lens komt de
lichtbundel samen als het lampje 3 centimeter
onder de hoofdas staat en de middelste
lichtstraal in de bundel in een hoek van 30
graden op de lens gericht staat?',
	 [ 'Afstand A',
	   'Afstand B',
	   'Afstand C',
	   'weet niet'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(25),
			    divergence(5),
			    pos_x(0),
			    pos_y(-3),
			    instrument_name(lamp3)),
		 m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(9.95),
			   show_gauge(true),
			   instrument_name(lens)),
		 d1 = ruler(from(m1),
			    to(centerline),
			    pos_y(6.1)),
		 c1 = construction_line(pos_x(19.95),
					instrument_name(consline)),
		 c2 = construction_line(pos_x(24.95),
					instrument_name(consline)),
		 c3 = construction_line(pos_x(29.95),
					instrument_name(consline)),
		 d2 = ruler(from(c1),
			    to(m1),
			    pos_y(6.75),
			    varname('A')),
		 d5 = ruler(from(m1),
			    to(c2),
			    pos_y(5.8),
			    varname('B')),
		 d6 = ruler(from(m1),
			    to(c3),
			    pos_y(5.35),
			    varname('C')),
		 a2 = protractor(path('l1-beam2'),
				 segment(1),
				 location(2.55))
	       ])).
