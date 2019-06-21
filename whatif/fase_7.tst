/*  Questionaire created by optica toolkit
    Date: Fri Nov  5 15:51:40 1999
*/

question(1, '1', 'Wde ejfejpofew',
	 [ '1',
	   '1.5'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(9.8),
			   show_gauge(true),
			   instrument_name(lens)),
		 l1 = lamp1(switch(true),
			    angle(0),
			    pos_y(3.7),
			    pos_x(3.55),
			    instrument_name(lamp1))
	       ])).
