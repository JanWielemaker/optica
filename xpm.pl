xpm(Obj, File) :-
	file_name_extension(File, xpm, XpmFile),
	get(Obj, frame, Frame),
	get(Frame, image, Img),
	send(Img, save, XpmFile, xpm).
