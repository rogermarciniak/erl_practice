%%%-------------------------------------------------------------------
%%% @author roger
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Oct 2016 10:55
%%%-------------------------------------------------------------------
-module(concur).
-author("roger").

-export([ping/1,pong/1]).

ping(0)->
  ok;
ping(N)->
  receive
    {From, ping} ->
      io:format("pinged~n"),
      From!{self(), pong}  %self() my process id
  end,
  ping(N-1).

pong(0)->
  ok;
pong(N)->
  receive
    {SenderPID, pong} ->
      io:format("ponged~n"),
      SenderPID!{self(), ping}
  end,
  pong(N-1).