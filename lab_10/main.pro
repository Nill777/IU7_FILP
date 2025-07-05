predicates
  factorial(integer, integer)
  factorial_rec(integer, integer, integer)
  nondeterm fib(integer, integer)
  fib_rec(integer, integer, integer, integer)
clauses
  factorial(N, RESULT) :- factorial_rec(N, 1, RESULT).
  factorial_rec(0, A, A)  :- !.
  factorial_rec(N, A, R) :- 
    N2 = N - 1,
    A2 = A * N,
  factorial_rec(N2, A2, R).
 
  fib(0, 0) :- !.
  fib(N, Res) :- fib_rec(N, Res, 0, 1).
  fib_rec(1, Res, _, Res) :- !.
  fib_rec(N, Res, N1, N2) :-
    Tmp_N = N - 1,
    Tmp_N2 = N1 + N2,
    fib_rec(Tmp_N, Res, N2, Tmp_N2).
goal
  %factorial(0, Result).
  %factorial(5, Result).
  %factorial(9, Result).
  %fib(0, Result).
  %fib(1, Result).
  %fib(2, Result).
  %fib(4, Result).
  fib(6, Result).

  