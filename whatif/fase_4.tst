/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 13:03:55 1997
*/

question(1, '4-1',
	 'Waar moet het beeldscherm staan om een scherp
beeld te krijgen als lens A vervangen door
lens B?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10.2),
			   show_gauge(true)),
		 s1 = shield(pos_x(3), unit(1)),
		 s2 = shield2(pos_x(26.5))
	       ])).
question(2, '4-2',
	 'Als we de lens vervangen door lens B en het
beeld scherp stellen, hoe verandert dan de
grootte van het plaatje?',
	 [ vergroot,
	   'verandert niet',
	   verkleind
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(15.85),
			   show_gauge(true)),
		 s1 = shield(pos_x(6.4), unit(1)),
		 s2 = shield2(pos_x(26.5))
	       ])).
question(3, '4-3',
	 'Als we de lens naar links verschuiven, hoe
moet dan het beeldscherm neergezet worden om
een scherp beeld te krijgen?',
	 [ 'dichterbij de lens',
	   'verder van de lens vandaan',
	   'plaats blijft hetzelfde'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14.95),
			   show_gauge(true)),
		 s1 = shield(pos_x(3.45), unit(1)),
		 s2 = shield2(pos_x(23.8))
	       ])).
question(4, '4-4',
	 'Als we de L-plaat naar links verschuiven en
dan het beeld scherp stellen, hoe verandert
dan de grootte van het plaatje?',
	 [ vergroot,
	   verkleind,
	   'verandert niet'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14.95),
			   show_gauge(true)),
		 s1 = shield(pos_x(6.1), unit(1)),
		 s2 = shield2(pos_x(26.4))
	       ])).
