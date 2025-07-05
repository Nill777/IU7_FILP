domains
 list = integer *.

predicates
 size(list List, unsigned size).
 size_rec(list List, unsigned Counter, unsigned size).

 sum(list List, integer Sum).
 sum_rec(list List, integer Accumulator, integer Sum).

 sum_odd_pos(list List, integer Sum).
 sum_odd_pos_rec(list List, integer Accumulator, integer Sum).

 generate_gt_val(list List, integer Value, list Result).

 delete(list List, integer Value, list Result).

 append(list List1, list List2, list Result).

clauses
 size(L, N) :- size_rec(L,0,N).
  size_rec([], N, N).
 size_rec([_|T], I, N) :- 
  I1 = I+1, 
    size_rec(T, I1, N).
 
 sum(L, Sum) :- sum_rec(L,0,Sum).
  sum_rec([], Sum, Sum).
 sum_rec([H|T], S, Sum) :- 
  S1 = S+H, 
    sum_rec(T, S1, Sum).
 
 sum_odd_pos(L, Sum) :- sum_odd_pos_rec(L,0,Sum).
 sum_odd_pos_rec([_], Sum, Sum) :- !.
 sum_odd_pos_rec([], Sum, Sum).
 sum_odd_pos_rec([_,H|T], S, Sum) :- 
  S1 = S+H, 
  sum_odd_pos_rec(T, S1, Sum).

 
 generate_gt_val([H|T], E, [H|R]) :- 
  H > E, !, generate_gt_val(T, E, R).
 generate_gt_val([_|T], E, R) :- generate_gt_val(T, E, R).
 generate_gt_val([], _, []).
 
 delete([H|T], E, [H|R]) :- 
  H <> E, !, delete(T, E, R).
 delete([_|T], E, R) :- delete(T, E, R).
 delete([], _, []).
 
 append([N|L1], L2, [N|L]) :- append(L1, L2, L).
 append([], L, L).
goal
    % 1    
    %size([5,6,7,8], Size).    % size = 4
    % 2
    %sum([0, -2, 10], Sum).  % Sum = 8
    % 3    % sumOddPos([1,2,1,2,1], Sum).  % Sum = 4
    sum_odd_pos([1,2,1,2], Sum).    % Sum = 4
    % 4    
    %generate_gt_val([3,6,0,-1,4], 3, L).      % L = [6,4]
    % 5
    %delete([4,3,1,2,3], 3, L).       % L = [4,1,2]    % delete([1,2,3], 0, L).           % L = [1,2,3]
    % delete([], 0, L).                % L = []
    % delete([0], 0, L).               % L = []
    % 6    % append([1,2], [3,4,5], L).    % L = [1,2,3,4,5]
    %append([], [1,2,3], L).       % L = [1,2,3]    % append([1,2,3], [], L).       % L = [1,2,3]

  