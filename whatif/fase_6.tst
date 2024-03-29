/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 13:40:15 1997
*/

question(1, '6-1',
	 'Waar komen de lichtstralen uiteindelijk samen
als we het lampje naar boven schuiven?',
	 [ 'naar boven',
	   'naar beneden',
	   'blijven op hetzelfde punt'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0)),
		 m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14.7),
			   show_gauge(true)),
		 m2 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(9.75),
			   show_gauge(true))
	       ])).
question(2, '6-2',
	 'Waar komen de lichtstralen uiteindelijk samen
als we lens B een stukje naar links
verschuiven?',
	 [ 'dichterbij lens A',
	   'verder van lens A vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0)),
		 m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14.7),
			   show_gauge(true)),
		 m2 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(9.75),
			   show_gauge(true))
	       ])).
question(3, '6-3',
	 'Waar komen de lichtstralen uiteindelijk samen als we lens A een stukje naar links verschuiven?',
	 [ 'dichterbij lens B',
	   'verder van lens B vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0)),
		 m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(5.9),
			   show_gauge(true)),
		 m2 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(12.9),
			   show_gauge(true))
	       ])).
question(4, '6-4',
	 'Waar komen de lichtstralen uiteindelijk samen
als we het lampje iets omhoog laten schijnen?',
	 [ 'naar beneden',
	   'naar boven',
	   'blijven op hetzelfde punt'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0)),
		 m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(16.95),
			   show_gauge(true)),
		 m2 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(12.75),
			   show_gauge(true))
	       ])).
question(5, '6-5',
	 'Waar komen de lichtstralen uiteindelijk samen
als we lens A en lens B van plaats laten
verwisselen?',
	 [ 'dichterbij lens A',
	   'verder van lens A vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l1 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(0)),
		 m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(15.55),
			   show_gauge(true)),
		 m2 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(10),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(10.05),
			   show_gauge(true))
	       ])).
question(6, '6-6',
	 'Als we lens C naar links bewegen, waar komt
de lichtbundel dan samen?',
	 [ 'dichter bij lens A',
	   'verder van lens A af',
	   'op hetzelfde punt'
	 ],
	 state(state, '',
	       [ l1  = lamp3(switch(true),
			     angle(0),
			     divergence(5),
			     pos_x(0),
			     pos_y(0)),
		 m19 = lens(label('A'),
			    radius(5),
			    thickness(0.1),
			    focal_distance(5),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(15.95),
			    show_gauge(true),
			    instrument_name(lens)),
		 m20 = lens(label('C'),
			    radius(5),
			    thickness(0.1),
			    focal_distance(-5),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(7.5),
			    show_gauge(true),
			    instrument_name(lens))
	       ])).
question(7, '6-7',
	 'Als we de lichtbundel meer naar onder laten
schijnen, waar komt deze dan samen?',
	 [ 'meer naar onder',
	   'zelfde punt',
	   'meer naar boven'
	 ],
	 state(state, '',
	       [ l1  = lamp3(switch(true),
			     angle(-19.1988),
			     divergence(5),
			     pos_x(-0.45),
			     pos_y(3.55)),
		 m19 = lens(label('A'),
			    radius(5),
			    thickness(0.1),
			    focal_distance(5),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(13.5),
			    show_gauge(true),
			    instrument_name(lens)),
		 m20 = lens(label('D'),
			    radius(5),
			    thickness(0.1),
			    focal_distance(-10),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(3.55),
			    show_gauge(true),
			    instrument_name(lens))
	       ])).
