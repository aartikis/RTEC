write_results(ResultFilename,CT,Type):-
    open(ResultFilename, write, ResultStream),
    nl(ResultStream),
    findall((F=V,I),
            (
                holdsFor(F=V,Ii),
		intersect_all([Ii,[(0,CT)]],I),
                I\=[],
                F =.. [Event|Args],
                write(ResultStream,event(Type,Event,[Args,V],I)),
                write(ResultStream,'.'),
                nl(ResultStream)
            ),CC),
    close(ResultStream).
