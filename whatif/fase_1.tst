/*  Questionaire created by optica toolkit
    Date: Thu Feb 27 14:23:04 1997
*/

question(1, '1-1',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens vervangen door een dubbelbolle?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m2 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(8),
			   sfere_left(40),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10.4),
			   show_gauge(true)),
		 l1 = lamp1(switch(true),
			    angle(0),
			    pos_y(3.55),
			    pos_x(0.05))
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
	       [ m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(9.45),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(25),
			    pos_y(0),
			    pos_x(0))
	       ])).
question(3, '1-3',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens een stukje naar links bewegen?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(9.45),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(25),
			    pos_y(0),
			    pos_x(0))
	       ])).
question(4, '1-4',
	 'Hoe schijnt de lichtstraal als we de lens een
stukje naar links bewegen?',
	 [ rechtuit,
	   'gebroken naar onder',
	   'gebroken naar boven'
	 ],
	 state(state, '',
	       [ m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(9.45),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(-20.1858),
			    pos_y(3.45),
			    pos_x(0))
	       ])).
question(5, '1-5',
	 'Waar raakt de lichtstraal de hoofdas als we
de lens vervangen door een dubbelholle?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(8),
			   sfere_left(-20),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(9.45),
			   show_gauge(true)),
		 l2 = lamp1(switch(true),
			    angle(0),
			    pos_y(3.45),
			    pos_x(0))
	       ])).
