/*  Questionaire created by optica toolkit
    Date: Wed Feb 12 12:39:23 1997
*/

question(1, '1-1',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens vervangen door een dubbelbolle?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l1 = lamp1(switch(true),
			    angle(0),
			    pos_y(3.15)),
		 'L1' = thicklens(radius(5),
				thickness(0),
				sfere_left(2),
				sfere_right(0),
				breaking_index(1.51),
				pos_x(8.75)),
		 c1 = construction_line(pos_x(20.75)),
		 d1 = ruler(from('L1'), to(c1), pos_y(6.1))
	       ])).
question(2, '1-2',
	 'Waar raakt de lichtstraal de hoofdas als we
de hoek tussen de lichtstraal en de lens
verkleinen?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ f1 = poslens(radius(5),
			      thickness(0.1),
			      focal_distance(5),
			      pos_x(10)),
		 l1 = lamp1(switch(true),
			    angle(25),
			    pos_y(-0)),
		 c1 = construction_line(pos_x(20)),
		 c2 = construction_line(pos_x(0)),
		 d1 = ruler(from(c2), to(f1), pos_y(5.65)),
		 d2 = ruler(from(f1), to(c1), pos_y(5.25))
	       ])).
question(3, '1-3',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens een stukje naar links bewegen?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ f1 = poslens(radius(5),
			      thickness(0.1),
			      focal_distance(5),
			      pos_x(10)),
		 l1 = lamp1(switch(true),
			    angle(25),
			    pos_y(-0)),
		 c1 = construction_line(pos_x(20)),
		 c2 = construction_line(pos_x(0)),
		 d1 = ruler(from(c2), to(f1), pos_y(5.65)),
		 d2 = ruler(from(f1), to(c1), pos_y(5.25))
	       ])).
question(4, '1-4',
	 'Hoe schijnt de lichtstraal als we de lens een
stukje naar links bewegen?',
	 [ rechtuit,
	   'gebroken naar onder',
	   'gebroken naar boven'
	 ],
	 state(state, '',
	       [ f2 = neglens(radius(5),
			      thickness(0.1),
			      focal_distance(-5),
			      pos_x(12)),
		 c3 = construction_line(pos_x(0)),
		 d3 = ruler(from(c3), to(f2), pos_y(6.15)),
		 l2 = lamp1(switch(true),
			    angle(-18.9899),
			    pos_y(4.1))
	       ])).
question(5, '1-5',
	 'Waar komt de lichtstraal terecht als we de
lens vervangen door een met de bolling aan de
rechterkant?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ 'L1' = thicklens(radius(5),
				thickness(0),
				sfere_left(5),
				sfere_right(0),
				breaking_index(1.51),
				pos_x(17.05)),
		 l3 = lamp1(switch(true),
			    angle(15),
			    pos_y(-0)),
		 c4 = construction_line(pos_x(27)),
		 d4 = ruler(from('L1'), to(c4), pos_y(6.1)),
		 a1 = protractor(path('l3-beam'),
				 segment(1),
				 location(4.9))
	       ])).
