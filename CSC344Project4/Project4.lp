% Length of grid
#const n1=24.
% Width of grid
#const n2=24.
% The social distance
#const distance=6.
% Starting X-Coordinate
#const startX=13.

% Create the grid
cell(0..n1, 0..n2).

person(startX, 0).

p(5, 20).
p(14, 8).
p(21, 5).

% Calculate the outer bad cells using the pythagorean theorem 
badCell(X1, Y1) :- cell(X1, Y1), p(X2, Y2), ((|(X1 - X2)| * |(X1 - X2)|) + (|(Y1 - Y2)| * |(Y1 - Y2)|)) <= (distance * distance).

goodCell(X, Y) :- cell(X, Y), not badCell(X, Y).

{path(X1, Y1, X2, Y2)} :- person(X1, Y1), goodCell(X2, Y2), X2 = X1 - 1, Y2 = Y1, not X2 = startX, X2 != 0, X2 < n1.
{path(X1, Y1, X2, Y2)} :- person(X1, Y1), goodCell(X2, Y2), X2 = X1 + 1, Y2 = Y1, not X2 = startX, X2 != 0, X2 < n1.
{path(X1, Y1, X2, Y2)} :- person(X1, Y1), goodCell(X2, Y2), X2 = X1, Y2 = Y1 + 1, Y2 <= n1.

:- path(X1, Y1, X2, Y2), path(X1, Y1, X3, Y3), X2 != X3, Y2 != Y3.

person(X2, Y2) :- path(_, _, X2, Y2).

:- not path(_, _, _, n1).

#show path/4.