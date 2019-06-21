question(1, 'item 4-1',
	 'Als je van links af een lamp laat schijnen
door de gaatjes van de L, wat is dan de
vergroting die je vindt op het (scherpe)
beeld rechts?',
	 [ '2',
	   '0,5',
	   '1',
	   'weet niet'
	 ],
	 state(state, '',
	       [ s1 = shield(pos_x(7.3), unit(1)),
		 m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(17.3),
			   show_gauge(true)),
		 s2 = shield2(pos_x(27.25)),
		 d1 = ruler(from(s1), to(m1), pos_y(1.5)),
		 d2 = ruler(from(m1), to(s2), pos_y(3.4))
	       ])).
question(2, 'item 4-2',
	 'Als we van links af een lamp laten schijnen,
hoe ver moet dan een voorwerp van de lens af
staan om een scherp beeld te krijgen?',
	 [ '10 centimeter',
	   '8 centimeter',
	   '5 centimeter',
	   'weet niet'
	 ],
	 state(state, '',
	       [ s4  = shield2(pos_x(25.5)),
		 m3  = lens(label(''),
			    radius(5),
			    thickness(0.1),
			    focal_distance(5),
			    sfere_left(*),
			    sfere_right(*),
			    breaking_index(1.51),
			    pos_x(15.5),
			    show_gauge(true)),
		 d14 = ruler(from(m3), to(s4), pos_y(6.2))
	       ])).
question(3, 'item 4-3',
	 'Wat kun je in bovenstaande situatie zeggen
over het beeld van het voorwerp?',
	 [ 'In deze situatie is er geen beeld',
	   'In deze situatie is het beeld kleiner dan het
voorwerp',
	   'In deze situatie is het beeld groter dan het
voorwerp',
	   'weet niet'
	 ],
	 state(state, '',
	       [ l1 = biglamp(instrument_name(biglamp)),
		 m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(19.9),
			   show_gauge(true),
			   instrument_name(lens)),
		 s1 = shield(pos_x(5.05),
			     unit(1),
			     instrument_name(shield)),
		 d1 = ruler(from(m1), to(s1), pos_y(-6.7)),
		 c1 = construction_line(pos_x(0),
					instrument_name(consline)),
		 d2 = ruler(from(s1), to(c1), pos_y(5.95))
	       ])).
question(4, 'item 4-4',
	 'Wat kun je in bovenstaande situatie zeggen
over het beeld van het voorwerp?',
	 [ 'In deze situatie is er geen beeld',
	   'In deze situatie is het beeld kleiner dan het
voorwerp',
	   'In deze situatie is het beeld groter dan het
voorwerp',
	   'weet niet'
	 ],
	 state(state, '',
	       [ l1 = biglamp(instrument_name(biglamp)),
		 m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(13.95),
			   show_gauge(true),
			   instrument_name(lens)),
		 s1 = shield(pos_x(4.95),
			     unit(1),
			     instrument_name(shield)),
		 d1 = ruler(from(m1), to(s1), pos_y(-6.7)),
		 c1 = construction_line(pos_x(0),
					instrument_name(consline)),
		 d2 = ruler(from(s1), to(c1), pos_y(5.95))
	       ])).
