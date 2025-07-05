domains
  name = symbol
  number = integer.

predicates
  nondeterm father(name, name)
  nondeterm mother(name, name)
  nondeterm spouse(name, name)
  nondeterm mother_in_law(name, name)
  nondeterm daughter_in_law(name, name)
  nondeterm stepdaughter(name, name) 
  ancestor(name, name, name, name, name)
  nondeterm max_two(number, number, number)
  nondeterm max_two_cut(number, number, number)
  nondeterm max_three(number, number, number, number)
  nondeterm max_three_cut(number, number, number, number).

clauses
  father(leonid, boris).
  father(egor, maxim).
  father(maxim, anatoly).
  father(irina, konstantin).
  father(boris, vadim).
  father(maria, dmitry).

  mother(leonid, maria).
  mother(egor, irina).
  mother(boris, svetlana).
  mother(irina, yelena).
  mother(maxim, lyubov).
  mother(maria, natalia).

  spouse(X, Y) :- 
    father(Child, X), 
    mother(Child, Y).

  spouse(X, Y) :- 
    father(Child, Y), 
    mother(Child, X).
        
  mother_in_law(Wife, MotherInLaw) :-
    spouse(Husband, Wife),
    mother(Husband, MotherInLaw).

  daughter_in_law(Parent, DaughterInLaw) :-
    father(Son, Parent) ; mother(Son, Parent),
    spouse(Son, DaughterInLaw).

  stepdaughter(Parent, Stepdaughter) :-
    spouse(Parent, Spouse),
    father(Stepdaughter, Spouse) ; mother(Stepdaughter, Spouse),
    not(father(Stepdaughter, Parent)),
    not(mother(Stepdaughter, Parent)).
        
  ancestor(Name, GrandMotherM, GrandFatherM, GrandMotherF, GrandFatherF) :-
    mother(Name, Mother), 
    mother(Mother, GrandMotherM), 
    father(Mother, GrandFatherM),
    father(Name, Father), 
    mother(Father, GrandMotherF), 
    father(Father, GrandFatherF).

  max_two(X, Y, X) :- X >= Y.
  max_two(X, Y, Y) :- Y > X.

  max_two_cut(X, Y, X) :- X >= Y, !.
  max_two_cut(_, Y, Y).

  max_three(X, Y, Z, X) :- X >= Y, X >= Z.
  max_three(X, Y, Z, Y) :- Y >= X, Y >= Z.
  max_three(X, Y, Z, Z) :- Z >= X, Z >= Y.

  max_three_cut(X, Y, Z, X) :- X >= Y, X >= Z, !.
  max_three_cut(X, Y, Z, Y) :- Y >= Z, !.
  max_three_cut(_, _, Z, Z).
goal
  %ancestor(leonid, GM_M, _, GM_F, _).
  %ancestor(leonid, _, GF_M, _, GF_F).
  %ancestor(leonid, GM_M, GF_M, GM_F, GF_F).
  %ancestor(leonid, GM_M, _, _, _).
  %ancestor(leonid, GM_M, GF_M, _, _).
  
  %max_two(1, 2, R1),
  %max_two_cut(1, 2, R2),

  %max_three(8, 7, 9, R3),
  %max_three_cut(8, 7, 9, R4).
  
  %mother_in_law(svetlana, MIL).
  %daughter_in_law(maria, DIL).
  stepdaughter(lyubov, SD).
  