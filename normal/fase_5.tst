question(1, 'item 5-1',
	 'Wat kun je in bovenstaande situatie zeggen
over het beeld van het voorwerp als we rechts
van de lens een beeldscherm plaatsen?',
	 [ 'Er is geen beeld',
	   'Het beeld is kleiner dan het voorwerp',
	   'Het beeld is groter dan het voorwerp',
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
			   pos_x(9.05),
			   show_gauge(true),
			   instrument_name(lens)),
		 s1 = shield(pos_x(4.95),
			     unit(1),
			     instrument_name(shield)),
		 c1 = construction_line(pos_x(0),
					instrument_name(consline)),
		 d1 = ruler(from(s1), to(c1), pos_y(6.25)),
		 d2 = ruler(from(s1), to(m1), pos_y(-6.85))
	       ])).
