/*  $Id: dcg_basics.pl,v 1.1 2000/02/07 10:29:55 jan Exp $

    Part of SWI-Prolog
    Designed and implemented by Jan Wielemaker

    Copyright (C) 1999 SWI, University of Amsterdam. All rights reserved.
*/

:- module(dcg_basics,
	  [ blank/2,			% <blank>
	    blanks/2,			% <blank>*
	    nonblanks/3,		% <nonblank>* --> chars		(long)
	    blanks_to_nl/2,		% [space,tab,ret]*nl
	    string/3,			% <any>* -->chars 		(short)
	    string_without/4,		% Exclude, -->chars 		(long)
	    digits/3,			% [0-9]* -->chars
	    digits1/3,			% [0-9]+ -->chars
	    digit/3,			% [0-9] --> char
	    integer/3,			% [0-9]+ --> integer
	    number/3,			% [0-9]+(.[0-9]+)?(e[0-9]+)? --> number
	    eos/2,			% demand end-of-string
					% generation (TBD)
	    atom/3			% generate atom
	  ]).

:- set_feature(character_escapes, true).

string_without(Not, [C|T]) -->
	[C],
	{ \+ memberchk(C, Not)
	}, !,
	string_without(Not, T).
string_without(_, []) -->
	[].

string(String, In, Rest) :-
	append(String, Rest, In).

blanks -->
	blank, !,
	blanks.
blanks -->
	[].

blank -->
	[C],
	{ code_type(C, space)
	}.

nonblanks([H|T]) -->
	[H],
	{ code_type(H, graph)
	}, !,
	nonblanks(T).
nonblanks([]) -->
	[].

blanks_to_nl -->
	"\n", !.
blanks_to_nl -->
	blank, !,
	blanks_to_nl.
blanks_to_nl -->
	eos.

%	digits(?Chars)
%	digit(?Char)
%	integer(?Integer)

digits([H|T]) -->
	digit(H), !,
	digits(T).
digits([]) -->
	[].

digit(C) -->
	[C],
	{ code_type(C, digit)
	}.

digits1([H|T]) -->
	digit(H),
	digits(T).

integer(I) -->
	{ integer(I),
	  number_codes(I, Chars)
	},
	string(Chars).
integer(I) -->
	digits1(Chars),
	{ number_codes(I, Chars)
	}.

number(F) -->
	{ number(F),
	  number_codes(F, Codes)
	},
	string(Codes).
number(F) -->
	digits1(P0),
	(   "."
	->  digits1(P1),
	    { append(P0, [0'.|P1], P2)
	    }
	;   { P2 = P0 }
	),
	(   exponent
	->  digits1(P3),
	    { append(P2, [0'e|P3], P4)
	    }
	;   { P4 = P2
	    }
	),
	{ number_codes(F, P4)
	}.

exponent -->
	"e".
exponent -->
	"E".

eos([], []).

		 /*******************************
		 *	     GENERATION		*
		 *******************************/

atom(Atom) -->
	{ atomic(Atom),
	  atom_codes(Atom, Codes)
	},
	string(Codes).





