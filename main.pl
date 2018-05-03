% Autor
% Javier Ruiz Calle, Sergio Redondo, Jaime Merlín

:-module(_,_).

esCuadradoFantasticoSecreto(Box, SecretNumber) :-
    parseBox(Box, SecretNumber).

parseBox([X | T], SecretNumber) :-
    my_reverse(T, [Y | _]),
    parseLists(X, Y, SecretNumber).

parseLists([X | T], [Y | U], SecretNumber) :-
    my_reverse(T, [Xs | _]),
    my_reverse(U, [Ys | _]),
    getMaximumValue(0, [X, Y, Xs, Ys], [X, Y, Xs, Ys], SecretNumber).

getMaximumValue(0, [X | T], Original, SecretNumber) :-
        getMaximumValue(X, T, Original, SecretNumber).
getMaximumValue(Max, [X | T], Original, SecretNumber) :-
    less_or_equal(Max, X),
    getMaximumValue(X, T, Original, SecretNumber).
getMaximumValue(Max, [X | T], Original, SecretNumber) :-
    less_or_equal(X, Max),
    getMaximumValue(Max, T, Original, SecretNumber).
getMaximumValue(Max, [], Original, SecretNumber):-
    getSecretNumber(Max, Original, [], SecretNumber).

getSecretNumber(Max, [X | T], UniqueValues, SecretNumber) :-
    Max = X,
    getSecretNumber(Max, T, UniqueValues, SecretNumber).
getSecretNumber(Max, [X | T], UniqueValues, SecretNumber) :-
    Max \= X,
    my_append([X], UniqueValues, Z),
    getSecretNumber(Max, T, Z, SecretNumber).
getSecretNumber(Max, [], [X, Y], SecretNumber) :-
    peano_add(X, Y, Z),
    Max = Z,
    SecretNumber = Z.

% Methods
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

my_reverse([], []).
my_reverse([X | Xs], Ys) :-
    reverse(Xs, Zs),
    my_append(Zs, [X], Ys).

my_append([], Y, Y).
my_append([H|X], Y, [H|Z]) :-
    my_append(X, Y, Z).

% Ejemplos
% esCuadradoFantasticoSecreto([[s(s(0)), s(s(s(s(0)))), s(s(s(s(s(s(0))))))], [s(s(s(s(0)))), s(s(s(s(s(s(0)))))), s(s(0))], [s(s(s(s(s(s(0)))))), s(s(0)), s(s(s(s(0))))]], X).
% esCuadradoFantasticoSecreto([[s(s(s(s(0)))), s(s(0)), s(s(s(s(s(s(0)))))), s(s(s(s(s(s(s(s(0))))))))], [s(s(s(s(s(s(0)))))), s(s(s(s(0)))), s(s(s(s(s(s(s(s(0)))))))), s(s(0))], [s(s(0)), s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(0)))), s(s(s(s(s(s(0))))))], [s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(0)))))), s(s(0)), s(s(s(s(0))))]], X).
% esCuadradoFantasticoSecreto([[s(s(s(s(0)))), s(s(0)), s(s(s(s(s(s(0)))))), s(s(s(s(s(s(s(s(0))))))))], [s(s(s(s(s(s(0)))))), s(s(s(s(0)))), s(s(s(s(s(s(s(s(0)))))))), s(s(0))], [s(s(0)), s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(0)))), s(s(s(s(s(s(0))))))], [s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(0)))))), s(s(0)), s(s(s(s(0))))]], s(s(s(s(s(s(s(s(0))))))))).
% esCuadradoFantasticoSecreto([[s(s(0)), s(s(0)), s(s(0))], [s(s(0)), s(s(0)), s(s(0))], [s(s(0)), s(s(0)), s(s(0))]], X).