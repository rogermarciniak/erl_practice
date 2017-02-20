%%%-------------------------------------------------------------------
%%% @author roger
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Sep 2016 10:52
%%%-------------------------------------------------------------------
-module(func).
-author("roger").
%these are built in, no point of rewriting them
-export([factorial/1,foc/1,len/1,sum/1,prod/1,mem/2,dele/2,push/2,append/2,zip/2,reverse/1,sort/1,conc/2,flatten/1,sublist/2]).

factorial(N) ->
    if
      N==1 ->
        1;
      N > 1 ->
        N*factorial(N-1)
    end.

foc(1) ->
  1;
foc(N) ->
  N*foc(N-1).

len([]) ->
  0;
% _ means look for a variable whatever it is, check that its there
len([_|Tail]) ->
  1+len(Tail).

sum([]) ->
  0;
sum([Head|Tail]) ->
  Head+sum(Tail).

prod([]) ->
  1;
prod([Head|Tail]) ->
  Head*prod(Tail).

%%mem(X,[]) ->
%%  false;
%%mem(X,[Head|Tail]) ->
%%  if X==Head ->
%%    true;
%%    X/=Head ->
%%      mem(X,Tail)
%%  end.

mem(X,[X|_]) ->true;
mem(X,[_|Tail])->mem(X,Tail).

%tell compiler what you're expecting, eg. list or X which is whatever
%-spec dele(X,@List) -> @List
dele(X,[])->
  [];
dele(X,[X|Tail])->
  Tail;
dele(X,[Head|Tail])->
  [Head|dele(X,Tail)].

push(X,List)->
  [X,List].

%append(x,[1,2,3])->[1,2,3,x]
append(X,[])->
  [X];
append(X,[Head|Tail])->
  [Head|append(X,Tail)].

%zip([1,2,3],[a,b,c]) == [{1,a},{2,b},{3,c}] takes two lists and puts them together
zip([],[])->
  [];
% is considered "tail recursive" which means, recursion is the last thing you do
% all the stuff is going to the recursive call and is then being returned all the way back
zip([HeadOne|TailOne],[HeadTwo|TailTwo])->
  [{HeadOne,HeadTwo}|zip(TailOne,TailTwo)].

%reverse([a,b,c])==[c,b,a]
%%reverse([])->
%%  [];
%%reverse([Head|Tail])->
%%  RTail=reverse(Tail),
%%  append(Head,RTail).

%better reverse()!
reverse(List)->
  reverse(List,[]).

reverse([],Accumulator)->
  Accumulator;
reverse([Head|Tail],SoFar)->
  reverse(Tail,[Head|SoFar])