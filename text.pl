/*  $Id: text.pl,v 1.1.1.1 1999/11/17 16:33:36 jan Exp $

    Part of XPCE
    Designed and implemented by Anjo Anjewierden and Jan Wielemaker
    E-mail: jan@swi.psy.uva.nl

    Copyright (C) 1997 University of Amsterdam. All rights reserved.
*/

:- module(showtext, []).
:- use_module(library(pce)).
:- use_module(util).
:- use_module(log).
:- use_module(configdb).
:- use_module(language).
:- require([ append/3
	   , memberchk/2
	   , string_to_list/2
	   ]).

:- pce_autoload(optica_tool_button, util).

brackets(bold,      '<B>', '</B>').
brackets(italic,    '<I>', '</I>').
brackets(underline, '<U>', '</U>').

:- pce_begin_class(textviewer, frame, "View/edit help and theory").

variable(type,	    name,  get,  "Type of text (theory, problem)").
variable(id,	    name,  get,  "Identifier for it").
variable(file,      file*, get,  "File for storage").
variable(opened_at, int*,  get,  "Clock tick it was opened").
variable(min_open,  real*, both, "Number of seconds the user must read").

initialise(TV, Kind:name, Id:name,
	   Label:label=[char_array], Edit:edit=[bool],
	   File:file=[file]*) :->
	default(File, @nil, TheFile),
	(   Label == @default
	->  (   Edit == @on
	    ->  TheLabel = string('Edit %s of %s', Kind, Id)
	    ;	TheLabel = string('%s of %s', Kind, Id)
	    )
	;   TheLabel = Label
	),
	send(TV, send_super, initialise, TheLabel),
	send(TV, done_message, message(TV, quit)),
	send(TV, slot, type, Kind),
	send(TV, slot, id, Id),
	send(TV, slot, file, TheFile),
	send(TV, append, new(D, dialog)),
	send(new(V, view(size := size(80,25))), below, D),
	send(D, pen, 0),
	send(D, gap, size(0, 0)),
	send(V, style, bold,       style(font := bold)),
	send(V, style, italic,     style(font := italic)),
	send(V, style, underline,  style(underline := @on)),
	send(V, font, normal),
	(   Edit == @on
	->  send(D, append,
		 optica_tool_button(bold,
				    message(TV, style, bold),
				    'bold.xpm',
				    'Make selection bold')),
	    send(D, append,
		 optica_tool_button(italic,
				    message(TV, style, italic),
				    'italic.xpm',
				    'Make selection italic')),
	    send(D,
		 append,
		 optica_tool_button(underline,
				    message(TV, style, underline),
				    'underline.xpm',
				    'Underline selection')),
	    send(D,
		 append,
		 optica_tool_button(image,
				    message(TV, insert_image),
				    'happy.xpm',
				    'Insert an image')),
	    send(D, append,
		 optica_tool_button(save,
				    message(TV, save),
				    'save.xpm',
				    'Save text')),
	    send(TV, editable, @on)
	;   send(TV, editable, @off)
	),
	send(D, append,
	     optica_tool_button(quit,
				message(TV, quit),
				'exit.xpm')),
	send(D?graphicals, for_all, message(@arg1, reference, point(0,32))),
	send(D, append, graphical(0,0,20,0), right),
	send(D, append, new(Rep, label(reporter, '')), right),
	send(Rep, reference, point(0,Rep?height)),
	(   Edit == @on
	->  send(D, append,
		 new(SAO, right_tick_box(show_at_open,
					 message(V, modified, @on))),
		 right),
	    send(SAO, alignment, right)
	;   true
	),
	send(TV, load),
	send(TV, slot, opened_at, @pce?mclock).

editable(TV, Edit:bool) :->
	"Switch editable status"::
	get(TV, member, view, View),
	send(View, editable, Edit),
	send(View, fill_mode, @on),
	get(View, text_cursor, Cursor),
	send(Cursor, displayed, Edit).


quit(TV) :->
	"Quit the tool"::
	(   get(TV, min_open, MinOpen),
	    number(MinOpen),
	    get(TV, opened_at, OpenedAt),
	    get(@pce, mclock, Now),
	    Now < OpenedAt + MinOpen*1000
	->  Min is integer(MinOpen) // 60,
	    Sec is integer(MinOpen) mod 60,
	    sformat(T, '~d:~2d', [Min, Sec]),
	    message(not_read_for_time(T), Message),
	    send(@display, inform, Message),
	    fail
	;   true
	),
	(   get_part(TV/view, editable, @on)
	->  (   get_part(TV/view, modified, @on)
	    ->  send(@display, confirm, 'Contents was modified; quit anyway?')
	    ;   true
	    )
	;   true
	),
	(   get(TV, type, What),
	    logging(view(What))
	->  log(end(view(What)))
	;   true
	),
	send(TV, destroy).


insert_image(TV) :->
	"Insert an image from the icons directory"::
	(   setof(directory(D), config(text_icon_directory(D)), Dirs)
	->  true
	;   Dirs = [directory(local(icons))]
	),
	(   setof(size(W,H), config(text_icon_size(W, H)), Sizes)
	->  true
	;   Sizes = [size(32,32)]
	),
	append(Dirs, Sizes, Options),
	browse_icon(TV, ImageName, Options),
	get(TV, member, view, V),
	send(V, insert_diagram, bitmap(ImageName)).


style(TV, Style:name) :->
	get(TV, member, view, V),
	(   get(V, selection_start, SS),
	    get(V, selection_end, SE),
	    SE > SS
	->  new(_, textfragment(V, SS, SE-SS, Style)),
	    send_part(TV/view, modified(@on))
	;   send(TV, report, error, 'No fragment')
	).

entity(0'&,	'&amp;').
entity(0'<,	'&lt;').
entity(0'>,	'&gt;').

specials_to_hmtl(TB) :-
	entity(Char, HTML),
	char_code(Atom, Char),
	send(regex(Atom), for_all, TB,
	     message(@arg1, replace, @arg2, HTML)),
	fail.
specials_to_hmtl(_).

diagrams_to_html(TB, Diagrams) :-
	send(regex(string('%c[^%c]%c', 1, 1, 1)), for_all, TB,
	     message(@prolog, diagram_to_html, @arg2, @arg1, Diagrams)).

diagram_to_html(TB, Re, Diagrams) :-
	get(Re, register_value, TB, 0, name, Atom),
	atom_codes(Atom, [1, Dia, 1]),
	get(Diagrams, element, Dia, Bitmap),
	get(Bitmap?image, name, Source),
	send(Re, replace, TB, string('<IMG SRC="%s">', Source)).

save(TV) :->
	"Save to config database"::
	get(TV, type, Kind),
	get(TV, id, Id),
	get(TV, member, view, V),
	get(V, editor, E),
	get(E, clone, Clone),
	get(Clone, text_buffer, TB),
	specials_to_hmtl(TB),
	(   get(E, attribute, diagrams, Diagrams)
	->  diagrams_to_html(TB, Diagrams)
	;   true
	),
	send(Clone, for_all_fragments, message(@arg1, save)),
	get(Clone?contents, value, AsAtom),
	atom_codes(AsAtom, Chars),		% Should be in XPCE interface
	string_to_list(String, Chars),
	(   get_part(TV/dialog/show_at_open, selection, @on)
	->  Options = [ show_at_open(true) ]
	;   Options = []
	),
	(   get(TV, file, File),
	    File \== @nil
	->  send(File, open, write),
	    send(File, append, String),
	    send(File, close)
	;   del_config(text(Kind, Id, _)),		% compatibility
	    del_config(text(Kind, Id, _, _)),
	    add_config(text(Kind, Id, String, Options)),
	    free(Clone),
	    send(TV, report, status, 'Saved')
	),
	send_part(TV/view, modified(@off)).

load(TV) :->
	"Load default"::
	get(TV, type, Kind),
	get(TV, id, Id),
	get(TV, file, File),
	get(TV, member, view, V),
	send(V, clear),
	(   (   File \== @nil
	    ->	Options = [],
		(   send(File, open, read)
		->  get(File, read, string(Text)),
		    send(File, close)
		;   Text = ''
		)
	    ;	config(text(Kind, Id, Text))	% compatibility
	    ->  Options = []
	    ;	config(text(Kind, Id, Text, Options))
	    )
	->  send(V, insert, Text),
	    get(V, text_buffer, TB),
	    send(regex('<[^<>]*>'), for_all, TB,
		 message(TV, html_tag,
			 ?(@arg1, register_value, @arg2, 0, name),
			 ?(@arg1, register_start),
			 @arg1, @arg2)),
	    send(regex('&[^;]*;'), for_all, TB,
		 message(TV, html_entity,
			 ?(@arg1, register_value, @arg2, 0, name),
			 @arg1,
			 TB))
	;   Options = []
	),
	send(V, modified, @off),
	send(V, caret, 0),
	send(V, scroll_to, 0),
	(   memberchk(show_at_open(Show), Options),
	    send_part(TV/dialog/show_at_open, selection(Show))
	;   true
	).

html_tag(TV, Tag:name, From:int, Re:regex, TB:text_buffer) :->
	"Handle an HTML tag"::
	send(Re, replace, TB, ''),
	(   brackets(_, Tag, _)
	->  push_tag(TV, Tag, From)
	;   brackets(Style, Open, Tag),
	    pop_tag(TV, Open, OpenPos)
	->  new(_, textfragment(TB, OpenPos, From-OpenPos, Style))
	;   atom_codes(Tag, Chars),
	    phrase(image_tag(TB, From), Chars)
	).

html_entity(_TV, Ent:name, RE:regex, TB:text_buffer) :->
	(   entity(Char, Ent)
	->  char_code(Atom, Char),
	    send(RE, replace, TB, Atom)
	;   true
	).

:- dynamic
	tag/2.

push_tag(_, Tag, From) :-
	asserta(tag(Tag, From)).
pop_tag(TV, Open, Pos) :-
	tag(O,P), !,
	(   Open == O,
	    retract(tag(O,P))
	->  Pos = P
	;   send(TV, report, error, 'Tag mismatch'),
	    fail
	).

image_tag(TB, Pos) -->
	"<IMG SRC=""",
	string(ImageChars),
	""">", !,
	{ name(ImageName, ImageChars),
	  get(TB?editors, head, E),
	  send(E, caret, Pos),
	  send(E, insert_diagram, bitmap(image(ImageName)))
	}.

string([]) -->
	[].
string([H|T]) -->
	[H],
	string(T).

:- pce_end_class.

:- pce_begin_class(textfragment, fragment, "Fragment in textviewer").

initialise(F, TB:text_buffer, S:int, L:int, Style:name) :->
	send(F, send_super, initialise, TB, S, L, Style),
	send(F, include, start, @off),
	send(F, include, end, @off).

save(F) :->
	get(F, style, Name),
	brackets(Name, Start, End),
	send(F, insert, 0, Start),
	send(F, insert, @default, End).

emptied(F) :->
	"Delete empty fragments"::
	free(F).

:- pce_end_class.
