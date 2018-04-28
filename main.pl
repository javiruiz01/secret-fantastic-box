% Autor
% Javier Ruiz Calle, Sergio Redondo, Jaime Merlín

:-module(_,_).

esCuadradoFantasticoSecreto(Matriz, Secreto) :-
    recorrerMatriz(Matriz, Secreto).

recorrerMatriz([X | T], Secreto) :-
    reverse(T, [Y | _]),
    recorrerListas(X, Y, Secreto).

recorrerListas([X | T], [Y | U], Secreto) :-
    reverse(T, [Xs | _]),
    reverse(U, [Ys | _]),
    comprobarSecreto(0, [X, Y, Xs, Ys], [X, Y, Xs, Ys], Secreto).

comprobarSecreto(0, [X | T], Original, Secreto) :-
        comprobarSecreto(X, T, Original, Secreto).
comprobarSecreto(Maximo, [X | T], Original, Secreto) :-
    less_or_equal(Maximo, X),
    comprobarSecreto(X, T, Original, Secreto).
comprobarSecreto(Maximo, [X | T], Original, Secreto) :-
    % Comprobamos que es mayor que, por lo tanto se usa less_or_equal con los args al revés
    less_or_equal(X, Maximo),
    comprobarSecreto(Maximo, T, Original, Secreto).
comprobarSecreto(Maximo, [], Original, Secreto):-
    sumar(Maximo, Original, [], Secreto).

sumar(Maximo, [X | T], Numeros, Secreto) :-
    Maximo = X,
    sumar(Maximo, T, Numeros, Secreto).
sumar(Maximo, [X | T], Numeros, Secreto) :-
    % condicion para que no entre en caso de que sean iguales y entre por backtracing
    Maximo \= X,
    append([X], Numeros, Z),
    sumar(Maximo, T, Z, Secreto).
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

reverse([], []).
reverse([X | Xs], Ys) :-
    reverse(Xs, Zs),
    append(Zs, [X], Ys).

% Prueba
% esCuadradoFantasticoSecreto([[s(s(0)),s(s(s(s(0)))),s(s(s(s(s(s(0))))))],[s(s(s(s(0)))),s(s(s(s(s(s(0)))))),s(s(0))],[s(s(s(s(s(s(0)))))),s(s(0)),s(s(s(s(0))))]],s(s(s(s(s(s(0))))))).