/*  $Id: model.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Designed and implemented by Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(optica_model,
	  [ scene_parms/4,		% +Window, -Lenses, -Scale, -MaxX
	    beam/3,			% +Beam0, +Lenses, -Beam
	    beam/4,			% +Beam0, +Lenses, +Options -Beam
	    draw_beam/3			% +Window, +Path, +Beam0
	  ]).
:- use_module(library(pce)).
:- require([ acos/2
	   , asin/2
	   , atan/2
	   , chain_list/2
	   , cos/2
	   , maplist/3
	   , pow/3
	   , round/2
	   , sign/2
	   , sin/2
	   , sqrt/2
	   , tan/2
	   ]).


		 /*******************************
		 *	    ARITHMETIC		*
		 *******************************/

should_eq(L, R) :-
	VL is L,
	VR is R,
	format('~w =? ~w~n    --> ~w = ~w~n', [L, R, VL, VR]).

%	beam(X, Y, Alpha)
%

beam(B0, Lenses, B) :-
	beam(B0, Lenses, [], B).

%	beam(+B0, +Lenses, +Options, -BeamList)
%
%	Compute the flow of a given beam through a set of lenses.
%	Options is a list containing
%
%		large_lenses(Bool).

beam(B, [], _, [B]) :- !.
beam(beam(X1, Y1, r(Alpha,L)), _, _, [beam(X1, Y1, r(Alpha,L))]) :- !.
beam(beam(X1, Y1, Alpha), [l(X2, F, H)|T], Opts,
     [beam(X1,Y1,Alpha,X2,Y2)|BT]) :-
	number(F),
	X2 >= X1,
	Y2 is Y1 + (tan(Alpha) * (X2-X1)),
	check_on_lens(Y2, H, Opts), !,
	NAlpha is -atan(tan(-Alpha) + Y2 / F),
	beam(beam(X2, Y2, NAlpha), T, Opts, BT).
beam(B0, [l(_, sferes(S1,S2), H)|T], Opts, [RB1,RB2|BT]) :-
	beam_on_sfere(B0, S1, H, RB1, Opts, B1),
	beam_on_sfere(B1, S2, H, RB2, Opts, B2), !,
	beam(B2, T, Opts, BT).
beam(B, [_|T], Opts, Bs) :-
	beam(B, T, Opts, Bs).

check_on_lens(Y, H, _Opts) :-
	abs(Y) < H, !.
check_on_lens(_, _, Opts) :-
	memberchk(large_lenses(true), Opts).

pce_ifhostproperty(prolog(swi), [
(:- format_predicate(h, format_angle(_,_))),

(format_angle(_Arg, A) :-
	Grads is round(A * 180 / pi),
	format('~d', Grads))]).

beam_on_sfere(beam(X1, Y0, r(A,L)), _, _, -, _, beam(X1, Y0, r(A,L))) :- !.
beam_on_sfere(beam(X1, Y0, Alpha),
	      s(CX, _CY, R, LR, BI),	% sfere
	      H,
	      beam(X1,Y0,Alpha,X2,Y2),
	      Opts,
	      beam(X2, Y2, NAlpha)) :-
	Cl is tan(Alpha),
	Xc is CX - X1,
	A is 1 + Cl^2,
	B is 2*Cl*Y0 - 2*Xc,
	C is Y0^2 + Xc^2 - R^2,
	SQRT is B^2 - 4*A*C,
	SQRT > 0,			% line doesn't hit circle
	DX is (-B + LR*sqrt(SQRT))/(2*A),
	Y2 is Y0 + DX * Cl,
	check_on_lens(Y2, H, Opts),
	X2 is X1 + DX,
	X2 > X1,

	(   LR < 0
	->  Beta is acos(min(1, (CX-X2)/R)), % avoid exception on rounding!
	    AI is Alpha + Beta * sign(Y2),
	    SinA is sin(AI) / BI,
	    (	abs(SinA) =< 1
	    ->  AR is asin(SinA),
		NAlpha is AR - Beta * sign(Y2)
	    ;	NAlpha is Beta + AI	% total reflection
	    )
	;   Beta is acos((X2-CX)/R) * sign(Y2),
	    AI is Alpha - Beta,
	    SinA is sin(AI) / BI,
	    (   abs(SinA) =< 1
	    ->  AR is asin(SinA),
		NAlpha is Beta + AR
	    ;	NAlphaA is pi + Beta - AI, % total reflection
	        NAlpha = r(NAlphaA, 1)
	    )
	).
beam_on_sfere(beam(X1, Y0, Alpha),
	      f(X2, BI),		% (vertical) flat
	      H,
	      beam(X1,Y0, Alpha, X2,Y2),
	      Opts,
	      beam(X2, Y2, NAlpha)) :-
	X2 >= X1,
	Y2 is Y0 + (X2 - X1) * tan(Alpha),
	check_on_lens(Y2, H, Opts),
	Asin is sin(Alpha)/BI,
	(   abs(Asin) =< 1
	->  NAlpha is asin(sin(Alpha)/BI)
	;   NAlphaA is pi - Alpha,
	    NAlpha = r(NAlphaA, 1)
	).


make_path([], _, _, _).
make_path([beam(X1,Y1,Alpha,X2,Y2)|T], Scale, MaxX, P) :- !,
	(   get(P?points, size, 0)
	->  append_path(P, X1, Y1, Scale)
	;   true
	),
	append_path(P, Alpha, X2, Y2, Scale),
	make_path(T, Scale, MaxX, P).
make_path([beam(X1, Y1, Alpha)|_], Scale, MX, P) :-
	(   get(P?points, size, 0)
	->  append_path(P, X1, Y1, Scale)
	;   true
	),
	(   Alpha = r(A, L)		% total reflection
	->  X2 is X1 + cos(A) * L,
	    Y2 is Y1 + sin(A) * L,
	    send(P, arrows, second)
	;   X2 = MX,
	    Y2 is Y1 + (X2 - X1) * tan(Alpha),
	    A = Alpha
	),
	append_path(P, A, X2, Y2, Scale).

append_path(P, X, Y, scale(ScaleX, ScaleY)) :-
	DX is round(X/ScaleX),
	DY is round(Y/ScaleY),
	send(P, append, point(DX, DY)).

append_path(P, Alpha, X, Y, scale(ScaleX, ScaleY)) :-
	DX is round(X/ScaleX),
	DY is round(Y/ScaleY),
	send(P, append, point(DX, DY), Alpha).


:- dynamic
	scene_cache/5.

scene_parms(Window, LensTerms, Scale, MaxX) :-
	get(Window, scene_id, Id),
	scene_cache(Window, Id, LensTerms, Scale, MaxX), !,
	Scale \== [].
scene_parms(Window, LensTerms, Scale, MaxX) :-
	get(Window, scene_id, Id),
	retractall(scene_cache(Window, _, _, _, _)),
	get(Window?graphicals, find_all,
	    message(@arg1, instance_of, lens),
	    LensChain),
	chain_list(LensChain, Lenses),
	get(Window, scale_x, ScaleX),
	get(Window, scale_y, ScaleY),
	Scale = scale(ScaleX, ScaleY),
	maplist(lensterm(Scale), Lenses, LensTerms0), !,
	sort(LensTerms0, LensTerms),
	get(Window, visible, area(X, _, W, _)),
	MaxX is (X + W) * ScaleX,
	asserta(scene_cache(Window, Id, LensTerms, Scale, MaxX)).
scene_parms(Window, _, _, _) :-
	get(Window, scene_id, Id),
	asserta(scene_cache(Window, Id, [], [], [])),
	fail.

draw_beam(Window, Path, Beam) :-
	send(Path, clear),
	send(Path, arrows, none),
	(   scene_parms(Window, LensTerms, Scale, MaxX)
	->  beam(Beam, LensTerms, Beams), !,
	    make_path(Beams, Scale, MaxX, Path),
	    send(Window, display, Path)
	;   true			% illegal scene
	).


lensterm(_, Lens, _) :-
	get(Lens, valid, @off), !,
	fail.
lensterm(Scale, Lens, l(RX, F, H)) :-
	get(Lens, focal_distance, F),
	F \== @default, !,
	get(Lens, x, X),
	get(Lens, radius, H),
	arg(1, Scale, ScaleX),
	RX is X * ScaleX.
lensterm(Scale, Lens, l(RX, sferes(SL, SR), H)) :-
	get(Lens, x, X),
	get(Lens, radius, H),
	arg(1, Scale, ScaleX),
	RX is X * ScaleX,
	sfere(Lens, Scale, left, SL),
	sfere(Lens, Scale, right, SR).

lr(Lens, left, LR, B, B) :- !,
	get(Lens, sfere_left, S),
	(   S == @default
	->  LR = -1
	;   LR is -sign(S)
	).
lr(Lens, right, LR, B0, B) :- !,
	get(Lens, sfere_right, S),
	(   S == @default
	->  LR = 1
	;   LR is sign(S)
	),
	B is 1/B0.

sfere(Lens, scale(ScaleX, ScaleY), Which, s(X,Y,R,LR,BI)) :-
	get(Lens, circle, Which, tuple(point(XP,YP), RP)), !,
	get(Lens, breaking_index, BI0),
	X is XP * ScaleX,
	Y is YP * ScaleY,
	R is RP * abs(ScaleY),
	lr(Lens, Which, LR, BI0, BI).
sfere(Lens, scale(ScaleX, _), Which, f(X, BI)) :-
	get(Lens, breaking_index, BI0),
	get(Lens, x, PX),
	get(Lens, thickness, T0),
	get(Lens, sfere_left,  SL),
	get(Lens, sfere_right, SR),
	(   DT is SR+SL,
	    DT < 0
	->  T is T0 - DT
	;   T is T0
	),
	lr(Lens, Which, _LR, BI0, BI),
	(   Which == left
	->  X is PX*ScaleX - T/2
	;   X is PX*ScaleX + T/2
	).
	
