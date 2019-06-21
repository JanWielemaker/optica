/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 12:56:29 1997
*/

question(1, '2-1',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens vervangen door lens B?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'raakt hoofdas niet'
	 ],
	 state(state, '',
	       [ m2 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.4),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(0),
			    pos_y(3.85),
			    pos_x(0.35))
	       ])).
question(2, '2-6',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens vervangen door lens C?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m2 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.4),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(-12.8043),
			    pos_y(3.85),
			    pos_x(0.35))
	       ])).
question(3, '2-2',
	 'Wat gebeurt er met de lichtstraal als we de
lens vervangen door lens C?',
	 [ 'blijft hetzelfde',
	   'breekt naar boven',
	   'breekt naar beneden'
	 ],
	 state(state, '',
	       [ l2 = lamp1(switch(true),
			    angle(-23.8387),
			    pos_y(3.85),
			    pos_x(0.35)),
		 m3 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(4),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.95),
			   show_gauge(true))
	       ])).
question(4, '2-7',
	 'Waar raakt de lichtstraal de hoofdas als we
de lichtstraal meer naar beneden laten
schijnen?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m3 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(true)),
		 l1 = lamp1(switch(true),
			    angle(-11.5346),
			    pos_y(5.15),
			    pos_x(0))
	       ])).
question(5, '2-3',
	 'Hoe buigt de lichtstraal af als we de lens
een stukje naar rechts bewegen?',
	 [ 'buigt sterker af',
	   'buigt zwakker af',
	   'blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l2 = lamp1(switch(true),
			    angle(0),
			    pos_y(2),
			    pos_x(0)),
		 m3 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.95),
			   show_gauge(true))
	       ])).
question(6, '2-4',
	 'Hoe buigt de lichtstraal af als we de lens een stukje naar links bewegen?',
	 [ 'buigt sterker af',
	   'buigt zwakker af',
	   'blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l2 = lamp1(switch(true),
			    angle(8.27589),
			    pos_y(-2.55),
			    pos_x(0)),
		 m3 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.95),
			   show_gauge(true))
	       ])).
question(7, '2-5',
	 'Waar ligt het brandpunt van de lens als we het lampje naar boven schuiven?',
	 [ 'links van de lens',
	   'rechts van de lens',
	   'op de lens'
	 ],
	 state(state, '',
	       [ l2 = lamp1(switch(true),
			    angle(0),
			    pos_y(-1.25),
			    pos_x(0)),
		 m3 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8.95),
			   show_gauge(true))
	       ])).
