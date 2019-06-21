/*  Questionaire created by optica toolkit
    Date: Tue Mar 04 16:13:41 1997
*/

question(1, 'item 7-1',
	 'Hoe kan in deze situatie het onscherpe beeld
gecorrigeerd worden?',
	 [ 'Door een sterke, negatieve lens tussen het
voorwerp en de lens te plaatsen',
	   'Door een sterke, positieve lens tussen het
voorwerp en de lens te plaatsen',
	   'Het beeld kan niet gecorrigeerd worden in
deze situatie',
	   'weet niet'
	 ],
	 state(state, '',
	       [ l8 = biglamp(instrument_name(biglamp)),
		 m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(2),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(17.8),
			   show_gauge(true),
			   instrument_name(lens)),
		 s3 = shield2(pos_x(20.3),
			      instrument_name(shield2)),
		 d5 = ruler(from(s3), to(m3), pos_y(6.4)),
		 s4 = shield(pos_x(3.85),
			     unit(1),
			     instrument_name(shield)),
		 d6 = ruler(from(s4), to(m3), pos_y(-6.95))
	       ])).
question(2, 'item 7-2',
	 'Het lampje heeft een divergerende
lichtbundel.  Als je van rechts af in de lens
kijkt, waar lijken de lichtstralen dan
vandaan te komen?',
	 [ 'vanuit het lampje zelf',
	   'vanuit de linkse lens (lens 1)',
	   'vanuit een punt tussen lens 1 en 2 in'
	 ],
	 state(state, '',
	       [ m3 = lens(label('1'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(8.45),
			   show_gauge(true),
			   instrument_name(lens)),
		 m4 = lens(label('2'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(18.4),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(false),
			    angle(0),
			    divergence(5),
			    pos_x(3.5),
			    pos_y(0),
			    instrument_name(lamp3)),
		 d4 = ruler(from(centerline),
			    to(m3),
			    pos_y(-6.8)),
		 d5 = ruler(from(m3), to(m4), pos_y(-6.5)),
		 e1 = eye(pos_x(26.95), instrument_name(eye))
	       ])).
