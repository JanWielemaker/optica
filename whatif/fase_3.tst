/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 12:59:55 1997
*/

question(1, '3-1',
	 'Vraag: Waar komen de lichtstralen samen als
we het lampje naar boven schuiven?',
	 [ 'naar boven',
	   'naar beneden',
	   'blijven op hetzelfde punt'
	 ],
	 state(state, '',
	       [ m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10.55),
			   show_gauge(true)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0))
	       ])).
question(2, '3-2',
	 'Waar komen de lichtstralen samen als we de lens een stukje naar links verschuiven?',
	 [ 'naar boven',
	   'naar beneden',
	   'blijven op hetzelfde punt'
	 ],
	 state(state, '',
	       [ m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(11.45),
			   show_gauge(true)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(1.95))
	       ])).
question(3, '3-3',
	 'Waar komen de lichtstralen samen als we de
lamp meer naar beneden laten schijnen?',
	 [ 'naar boven',
	   'naar beneden',
	   'blijven op hetzelfde punt'
	 ],
	 state(state, '',
	       [ m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(9.5),
			   show_gauge(true)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(1.95))
	       ])).
question(4, '3-4',
	 'Waar komen de lichtstralen samen als we de
lens vervangen door lens B?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(9.5),
			   show_gauge(true)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0))
	       ])).
question(5, '3-5',
	 'Hoe buigt de onderste lichtstraal af als we
de lens een stukje naar links bewegen?',
	 [ 'naar boven',
	   'naar beneden',
	   'blijft op hetzelfde punt'
	 ],
	 state(state, '',
	       [ m3 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(9.5),
			   show_gauge(true)),
		 l2 = lamp3(switch(true),
			    angle(4.99628),
			    divergence(5),
			    pos_x(0),
			    pos_y(0))
	       ])).
