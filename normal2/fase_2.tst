/*  Questionaire created by optica toolkit
    Date: Tue Mar 24 16:23:56 1998
*/

question(1, '2.11',
	 'Wanneer komt het snijpunt van de uittredende lichtstralen dichter bij de lens te liggen?',
	 [ 'Als je de invallende lichtstralen meer naar beneden richt.',
	   'Als je de lamp een stukje naar rechts beweegt.',
	   'Als je de lens vervangt door lens B.'
	 ],
	 state(state, '',
	       [ m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(8),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(2, '2.12',
	 'Wanneer komt het snijpunt van de uittredende lichtstralen verder van de lens af te liggen?',
	 [ 'Als je de invallende lichtstralen iets naar boven richt.',
	   'Als je de lamp een stukje naar links beweegt.',
	   'Als je de lens vervangt door lens A.'
	 ],
	 state(state, '',
	       [ m1 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(4),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(3, '2.13',
	 'Wanneer komt het snijpunt van de uittredende lichtstralen boven de hoofdas te liggen?',
	 [ 'Als je de invallende lichtstralen meer naar boven richt.',
	   'Als je de lamp een stukje naar beneden beweegt.',
	   'Als je de lens een stukje naar rechts beweegt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(4),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(4, '2.14',
	 'Wanneer komt het snijpunt van de uittredende lichtstralen onder de hoofdas te liggen?',
	 [ 'Als je de stralen van de invallende lichtstralen naar beneden richt.',
	   'Als je de lamp een stukje naar boven beweegt.',
	   'Als je de lens een stukje naar links beweegt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(8),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(5, '2.15', 'Wat is de brandpuntsafstand van lens A?',
	 [ '8 cm',
	   '4 cm',
	   '-4 cm'
	 ],
	 state(state, '',
	       [ m1 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens))
	       ])).
question(6, '2.16', 'Wat is de brandpuntsafstand van lens B?',
	 [ '8 cm',
	   '4 cm',
	   '-4 cm'
	 ],
	 state(state, '',
	       [ m1 = lens(label('B'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens))
	       ])).
question(7, '2.17', 'Wat is de brandpuntsafstand van lens C?',
	 [ '-8 cm',
	   '8 cm',
	   '-4cm'
	 ],
	 state(state, '',
	       [ m1 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens))
	       ])).
