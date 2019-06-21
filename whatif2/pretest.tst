/*  Questionaire created by optica toolkit
    Date: Tue Mar 24 16:15:48 1998
*/

question(1, 'pre1.01',
	 'De lamp wordt iets naar rechts bewogen.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(2, 'pre1.02',
	 'De lamp wordt iets naar links bewogen.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(15),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(3),
			    instrument_name(lamp1))
	       ])).
question(3, 'pre1.03',
	 'De lens wordt iets naar rechts bewogen.
Waar zal de uitredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(4, 'pre1.04',
	 'De lens wordt iets naar links bewogen.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m4 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(4),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(5, 'pre1.05',
	 'De lichtstraal wordt iets meer naar beneden gericht.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(6, 'pre1.06',
	 'De lichtstraal wordt iets meer naar boven gericht.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(7, 'pre1.07',
	 'De afgebeelde lens wordt vervangen door een dubbelbolle lens.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Verder van de lens vandaan.',
	   'De uittredende straal snijdt de hoofdas niet meer.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(8, 'pre1.08',
	 'De afgebeelde lens wordt vervangen door een dubbelholle lens.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Verder van de lens vandaan.',
	   'De uittredende straal snijdt de hoofdas niet meer.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(9, 'pre1.09',
	 'De afgebeelde lens wordt vervangen door een platbolle lens.
Waar zal de uittredende lichtstraal de hoofdas snijden?',
	 [ 'Dichterbij de lens.',
	   'Verder van de lens vandaan.',
	   'De uittredende straal snijdt de hoofdas niet meer.'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(10),
			   sfere_right(10),
			   breaking_index(1.51),
			   pos_x(3.5),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(10, 'pre1.10',
	 'De afgebeelde lens wordt vervangen door een platholle lens.
Wat zal er gebeuren met de hoek die de uittredende lichtstraal maakt met de hoofdas?',
	 [ 'Deze wordt groter.',
	   'Deze blijft gelijk.',
	   'Deze wordt kleiner'
	 ],
	 state(state, '',
	       [ m6 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-3),
			   sfere_left(-10),
			   sfere_right(-10),
			   breaking_index(1.51),
			   pos_x(6),
			   show_gauge(false),
			   instrument_name(lens)),
		 l2 = lamp1(switch(true),
			    angle(10),
			    pos_y(0),
			    pos_x(0),
			    instrument_name(lamp1))
	       ])).
question(11, 'pre2.01',
	 'De lamp wordt iets naar rechts bewogen.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(12, 'pre2.02',
	 'De lamp wordt iets naar links bewogen.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(13, 'pre2.03',
	 'De lamp wordt iets naar boven bewogen.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Boven de hoofdas.',
	   'Op de hoofdas.',
	   'Onder de hoofdas.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(14, 'pre2.04',
	 'De lamp worden iets meer naar beneden bewogen.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Boven de hoofdas.',
	   'Op de hoofdas.',
	   'Onder de hoofdas.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(15, 'pre2.05',
	 'De lichtstralen van de lamp worden iets meer naar boven gericht.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Boven de hoofdas.',
	   'Op de hoofdas.',
	   'Onder de hoofdas.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(16, 'pre2.06',
	 'De lichtstralen van de lamp worden iets meer naar beneden gericht.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Boven de hoofdas.',
	   'Op de hoofdas.',
	   'Onder de hoofdas.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(17, 'pre2.07',
	 'De lichtstralen van de lamp worden iets meer naar boven gericht.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(18, 'pre2.08',
	 'De lichtstralen van de lamp worden iets meer naar beneden gericht.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Even ver van de lens vandaan.',
	   'Verder van de lens vandaan.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(19, 'pre2.09',
	 'De afgebeelde lens wordt vervangen door een lens met een brandpuntsafstand van 3 cm.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Verder van de lens vandaan.',
	   'De uittredende stralen zullen elkaar niet gaan snijden.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(7),
			   show_gauge(true),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(20, 'pre2.10',
	 'De afgebeelde lens wordt vervangen door een lens met een negatieve brandpuntsafstand.
Waar zullen de uittredende lichtstralen elkaar snijden?',
	 [ 'Dichterbij de lens.',
	   'Verder van de lens vandaan.',
	   'De uittredende stralen zullen elkaar niet snijden.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(10),
			   show_gauge(false),
			   instrument_name(lens)),
		 l1 = parlamp(switch(true),
			      angle(0),
			      separation(1),
			      pos_x(2),
			      pos_y(0),
			      instrument_name(parlamp))
	       ])).
question(21, 'pre3.01',
	 'De lens wordt iets naar rechts bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(11),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(22, 'pre3.02',
	 'De lens wordt iets naar links bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(23, 'pre3.03',
	 'De lamp wordt iets naar links bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt dichter bij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een reeel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(13),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(4),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(24, 'pre3.04',
	 'De lamp wordt iets naar rechts bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een reeel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(13),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(4),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(25, 'pre3.05',
	 'De lamp wordt iets naar rechts bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een reeel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(5),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(26, 'pre3.06',
	 'De lamp wordt iets naar links bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens af te liggen.',
	   'Wordt een reeel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(5),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(27, 'pre3.07',
	 'De lamp wordt iets naar boven bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(28, 'pre3.08',
	 'De lamp wordt iets naar beneden bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(11),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(29, 'pre3.09',
	 'De lamp wordt iets naar boven bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(-6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(13),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(4),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(30, 'pre3.10',
	 'De lamp wordt iets naar beneden bewogen.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(5),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(31, 'pre3.11',
	 'De lichtstralen van de lamp worden iets meer naar boven gericht.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(8),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(32, 'pre3.12',
	 'De lichtstralen van de lamp worden iets meer naar beneden gericht.
Wat zal er gebeuren met het virtueel beeldpunt?',
	 [ 'Komt boven de hoofdas te liggen.',
	   'Blijft op de hoofdas liggen.',
	   'Komt onder de hoofdas liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(5),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(33, 'pre3.13',
	 'De afgebeelde lens wordt vervangen door een lens met een brandpuntsafstand van 3 cm.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichter bij de lens te liggen.',
	   'Komt verder van de lens vandaan te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(11),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(34, 'pre3.14',
	 'De afgebeelde lens wordt vervangen door een lens met een brandpuntsafstand van 6 cm.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens vandaan te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(35, 'pre3.15',
	 'De afgebeelde lens wordt vervangen door een lens met een brandpuntsafstand van 6 cm.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens vandaan te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(6.5),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(36, 'pre3.16',
	 'De afgebeelde lens wordt vervangen door een lens met een negatieve brandpuntsafstand.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de lens te liggen.',
	   'Komt verder van de lens vandaan te liggen.',
	   'Wordt een virtueel beeldpunt.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(11),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(2),
			    pos_y(0),
			    instrument_name(lamp3))
	       ])).
question(37, 'pre3.17',
	 'De lens wordt iets naar links bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de hoofdas te liggen.',
	   'Blijft op dezelfde afstand van de hoofdas liggen.',
	   'Komt verder van de hoofdas af te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(6),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(22),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(0),
			    pos_y(-1),
			    instrument_name(lamp3))
	       ])).
question(38, 'pre3.18',
	 'De lens wordt iets naar rechts bewogen.
Wat zal er gebeuren met het beeldpunt?',
	 [ 'Komt dichterbij de hoofdas te liggen.',
	   'Blijft op dezelfde afstand van de hoofdas liggen.',
	   'Komt verder van de hoofdas af te liggen.'
	 ],
	 state(state, '',
	       [ m1 = lens(label(''),
			   radius(5),
			   thickness(0.1),
			   focal_distance(3),
			   sfere_left(0),
			   sfere_right(0),
			   breaking_index(1.51),
			   pos_x(14),
			   show_gauge(true),
			   instrument_name(lens)),
		 l2 = lamp3(switch(true),
			    angle(0),
			    divergence(5),
			    pos_x(3),
			    pos_y(-1),
			    instrument_name(lamp3))
	       ])).
