% Autor
% Javier Ruiz Calle, Sergio Redondo, Jaime Merlín

:-module(_,_).

esCuadradoFantasticoSecreto(Matriz, Secreto) :-
    recorrerMatriz(Matriz, Secreto).

recorrerMatriz([X | T], Secreto) :-
    reverse(T, [Y | _]),
    recorrerListas(X, Y).

recorrerListas([X | T], [Y | U], Secreto) :-
    reverse(T, [Xs | _]),
    reverse(U, [Ys | _]),
    comprobarSecreto(0, [X, Y, Xs, Ys], [X, Y, Xs, Ys], Secreto).

comprobarSecreto(Y, [], Original, Secreto):-
    sumar(Y, Original, [], Secreto).
comprobarSecreto(0, [X | T], Original, Secreto) :-
    comprobarSecreto(X, T, Original, Secreto).
comprobarSecreto(Y, [X | T], Original, Secreto) :-
    less_or_equal(Y, X),
    comprobarSecreto(X, T, Original, Secreto).
comprobarSecreto(Y, [X | T], Original, Secreto) :-
    comprobarSecreto(Y, T, Original, Secreto).

sumar(Maximo, [X | T], Numeros, Secreto) :-
    Maximo = X,
    sumar(Maximo, T, T, Secreto).
sumar(Maximo, [X | T], Numeros, Secreto) :-
    % condicion para que no entre en caso de que sean iguales y entre por backtracing
    sumar(Maximo, T, [X | T], Secreto).
sumar(Maximo, [], [X, Y], Secreto) :-
    peano_add(X, Y, Z),
    Maximo = Z,
    Secreto = Z.


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