/*  Questionaire created by optica toolkit
    Date: Wed Mar 05 11:29:09 1997
*/

question(1, 'item 1-1',
	 'Het lampje staat 4 centimeter boven de
hoofdas.  Als we het 2 centimeter naar onder
bewegen, wat kun je dan zeggen over de plaats
waar de lichtstraal de hoofdas raakt?',
	 [ 'Niets, want het ligt aan het soort lens wat er gebeurt',
	   'De lichtstraal raakt nog steeds op dezelfde plaats de hoofdas',
	   'De lichtstraal raakt de hoofdas 2 centimeter verder dan eerst',
	   'weet niet'
	 ],
	 state(state, '',
	       [ m3 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(5),
			   sfere_left(*),
			   sfere_right(*),
			   breaking_index(1.51),
			   pos_x(11),
			   show_gauge(false),
			   instrument_name(lens)),
		 l3 = lamp1(switch(true),
			    angle(0),
			    pos_y(4),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
