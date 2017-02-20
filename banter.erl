%%%-------------------------------------------------------------------
%%% @author roger
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. Oct 2016 12:22
%%%-------------------------------------------------------------------
-module(banter).
-author("roger").
-export([rpn/1,processToken/2,fib2/1]).
-include_lib("eunit/include/eunit.hrl").

%reverse polish notation banter using fold

processToken("+",[N1,N2|Rest])->
  [N1+N2|Rest];
processToken("-",[N1,N2|Rest])->
  [N2-N1|Rest];
processToken("*",[N1,N2|Rest])->
  [N1*N2|Rest];
processToken("/",[N1,N2|Rest])->
  [N2/N1|Rest]; %???
processToken(X,Stack)->
  [convertToNumber(X)|Stack].

convertToNumber(String)->
  case string:to_float(String) of
    {error,no_float}->
      list_to_integer(String);
    {Float,_}->
      Float
end.


%rpn("10 4 3 + 2 * -")--> -4
%foldl = left to right %using list as a stack
-spec rpn(list())->number().
rpn(List)->
  [Result]= lists:foldl(fun processToken/2,[],string:tokens(List," ")),
  Result.

rpnPlus_test()->
  ?assert(5=:=banter:rpn("4 1 +")).
rpnPlusFloat_test()->
  ?assert(5.0=:=banter:rpn("4.0 1 +")).
rpnSubtract_test()->
  ?assert(3=:=banter:rpn("4 1 -")).

%banter:test(). runs every function ending with *_test

fib2(0) ->
  0;
fib2(1) ->
  1;
fib2(N) ->
  Self = self(),
  spawn(fun() ->
    Self ! fib2(N-1)
        end),
  spawn(fun() ->
    Self ! fib2(N-2)
        end),
  receive
    F1 ->
      receive
        F2 ->
          F1 + F2
      end
  end.