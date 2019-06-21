/*  Questionaire created by optica toolkit
    Date: Mon Mar 03 13:08:51 1997
*/

question(1, '5-1',
	 'Hoe moet het voorwerp bewogen worden om een
beeld te laten verdwijnen?',
	 [ 'plaats blijft hetzelfde',
	   'het beeld kan niet verdwijnen',
	   'er is nooit een beeld'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('C'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-4),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14.95),
			   show_gauge(true)),
		 s1 = shield(pos_x(7.5), unit(1))
	       ])).
question(2, '5-2',
	 'Als we de L-plaat naar rechts bewegen zodat
deze op 10 centimeter van de lens staat, wat
is dan dan de grootte van het beeld?',
	 [ 'kleiner dan het voorwerp',
	   'even groot als het voorwerp',
	   'groter dan het voorwerp'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(2),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14.95),
			   show_gauge(true)),
		 s1 = shield(pos_x(2.95), unit(1)),
		 d1 = ruler(from(s1), to(m3), pos_y(-1.6))
	       ])).
question(3, '5-3',
	 'De L-plaat staat op 10 centimeter van de lens.
Hoe verandert de grootte van het beeld als we
het voorwerp een klein stukje naar rechts
bewegen?',
	 [ 'wordt kleiner',
	   'blijft even groot',
	   'wordt groter'
	 ],
	 state(state, '',
	       [ l3 = biglamp,
		 m3 = lens(label('A'),
			   radius(5),
			   thickness(0.1),
			   focal_distance(2),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14.95),
			   show_gauge(true)),
		 s1 = shield(pos_x(4.95), unit(1)),
		 d1 = ruler(from(s1), to(m3), pos_y(-1.6))
	       ])).
question(4, '5-4',
	 'Als we het voorwerp, dat ongeveer 5
centimeter van lens A staat, nog iets naar
rechts bewegen, waar bevindt zich dan het
beeld van het voorwerp?',
	 [ 'er is geen beeld',
	   'beeld is onzichtbaar en bevindt zich links
van de lens',
	   'beeld is onzichtbaar en bevindt zich rechts
van de lens'
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
		 s1 = shield(pos_x(9.95), unit(1)),
		 d1 = ruler(from(s1), to(m3), pos_y(-1.6))
	       ])).
question(5, '5-5',
	 'Als we het voorwerp, dat ongeveer 5
centimeter van lens A staat, nog iets naar
rechts bewegen, hoe groot wordt dan het beeld
in vergelijking met het voorwerp?',
	 [ 'er is geen beeld',
	   'beeld wordt kleiner dan voorwerp',
	   'beeld wordt groter dan voorwerp'
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
		 s1 = shield(pos_x(9.95), unit(1)),
		 d1 = ruler(from(s1), to(m3), pos_y(-1.6))
	       ])).
