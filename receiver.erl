-module(receiver).
-export([wait0/0, wait1/0]).

wait0() ->
    receive
        {From, {M, 0}} ->
            snd_ack0(From);
        {From, {M, 1}} ->
            wait0()
    end.

snd_ack0(From) ->
    From ! {self(), 0},
    wait1().

wait1() ->
    receive
        {From, {M, 0}} ->
            wait1();
        {From, {M, 1}} ->
            snd_ack1(From)
    end.

snd_ack1(From) ->
    From ! {self(), 1},
    wait0().