:- op(200, xfx, **).

:- prolog_load_context(directory, Dir),
   asserta(user:file_search_path(top_directory, Dir)),
   asserta(user:library_directory(top_directory(lib))).

:- use_module('math/expandmath').
:- use_module(login).
