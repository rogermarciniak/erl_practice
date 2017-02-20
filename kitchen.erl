%%%-------------------------------------------------------------------
%%% @author roger
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Oct 2016 10:20
%%%-------------------------------------------------------------------
-module(kitchen).
-author("roger").
-compile(export_all). %don't do it son

cupboard(Items, Timeout)->
  receive
    {SenderID, {store, Thing}} ->
      SenderID!{self(), ok},   %message
      cupboard([Thing|Items], Timeout);

    {SenderID, {take, Thing}} ->
      case lists:member(Thing, Items) of
        true ->
          SenderID!{self(), Thing},
          cupboard(lists:delete(Thing, Items), Timeout);
        false ->
          SenderID!{self(), not_found},
          cupboard(Items, Timeout)
      end;
    {SenderID, terminate} -> SenderID!ok;
    _ -> notok
  after Timeout ->
    ok
  end.

start(Items)->
  spawn(?MODULE, cupboard, [Items, 4000000]).

store(Pid, Thing)->
  Pid!{self(), {store, Thing}},
  receive
    {Pid, MSG} ->
      MSG
  end.

take(Pid, Thing)->
  Pid!{self(), {take, Thing}},
  receive
    {Pid, Thing} ->
      ok;
    {Pid, MSG} ->
      io:format("Item ~p not found: Message:~p~n", [Thing, MSG])
  end.

sleep(Milliseconds)->
  receive
    after Milliseconds->
      ok
  end.

flush()->
  receive
    _->
      flush()
    after 0 -> %not going to happen if there isnt anything in the mailbox
      ok
  end.

important()->
  receive
    {SenderID,{Priority,Message}} when Priority > 10 ->
      [Message|important()]
    after 0 ->
      normal()
  end.

normal()->
  receive
    {SenderID,{_,Message}}->
      [Message|normal()]
  after 0 ->
    ok
  end.