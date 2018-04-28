% Autor
% Javier Ruiz Calle, Sergio Redondo, Jaime Merlín

:-module(_,_).

% Métodos auxiliares
nat(0).
nat(s(X)) :-
    nat(X).

less_or_equal(0,X) :-
    nat(X).
less_or_equal(s(X),s(Y)) :-
    less_or_equal(X,Y).

peano_add(0, N, N).
peano_add( s(N), M, s(Sum) ) :-
	peano_add( N, M, Sum ).