%%%-------------------------------------------------------------------
%%% @author roger
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. Oct 2016 11:12
%%%-------------------------------------------------------------------
-module(hol).
-author("roger").

%% API
-export([map/2,addTwo/1,fold/3,filter/2]).

% map applies a function to list
map(_, [])->
  [];
map(FUN, [Head|Tail])->
  [FUN(Head)|map(FUN, Tail)].

addTwo(Num)->
  Num + 2.


%% this goes into the console
%% hol:map(fun hol:addTwo/1, [1,2,3]).


% fold(+, 0, [1,2,3])-->6 applies operator (or function) to all list elements
% adds the list in this case
fold(_,Accumulator,[])->
  Accumulator;
fold(Fun,Accumulator,[Head|Tail])->
  fold(Fun,Fun(Accumulator,Head),Tail).

% fold(*,1,[5,2,3])
%  L fold(*,*(1,5),[2,3])
%   L fold(*,*(*(1,5),2),[3])
%    L  fold(*,*(*(*(1,5),2,3),[])
%     L *(*(*(1,5),2),3)
%      L *(*(5,2),3)
%       L *(10,3)

% hol:fold(fun(X,Y)->X+Y end,0,[1,2,3,4,5,6,7,8,9]).   <<<<<<<------- THIS
% 45

% hol:fold(fun(X,Y)->X++Y end,[],[[1,2,3],[a,b,c],[4,5,6],[d,e,f]]).
% [1,2,3,a,b,c,4,5,6,d,e,f]

%///breaking news: foldr() goes from right to left///

%filter returns elements of list that are true (doesn't have to be a list (tree))
filter(_,[])->
  [];
filter(Fun,[Head|Tail])->
  case Fun(Head) of
    true ->
      [Head|filter(Fun,Tail)];
    false ->
      filter(Fun,Tail)
  end;
filter(Fun,[_|Tail])->
  filter(Fun,Tail).

% hol:filter(fun(X)->X rem 2==0 end, [1,2,3,4,5,6,7,8,9,10]).
% [2,4,6,8,10]