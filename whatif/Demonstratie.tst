/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 11:02:31 1997
*/

question(1, 'oefenvraag 1',
	 'Als we het lampje naar boven schuiven, waar
raakt de lichtstraal dan de as?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(8),
			   sfere_left(20),
			   sfere_right(20),
			   breaking_index(1.51),
			   pos_x(10.15),
			   show_gauge(true)),
		 l1 = lamp1(switch(true),
			    angle(0),
			    pos_y(1.85),
			    pos_x(1.95))
	       ])).
question(2, 'oefenvraag 2',
	 'Als we het beeldscherm een stukje naar rechts
verschuiven, hoe moeten we dan het voorwerp
schuiven om het beeld scherp te houden?',
	 [ 'beeld blijft scherp',
	   'voorwerp naar links schuiven',
	   'voorwerp naar rechts schuiven'
	 ],
	 state(state, '',
	       [ l2 = biglamp,
		 s1 = shield(pos_x(6.45), unit(1)),
		 s2 = shield2(pos_x(26.6)),
		 m2 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(15.7),
			   show_gauge(true))
	       ])).
