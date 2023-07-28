-module(sender).
-export([rw0/0, snd_msg0/2, snd_msg1/2, sw0/0]).

rw0() -> spawn(fun receiver:wait0/0).    %d
sw0() ->                                %c
    SW0Pid = spawn(fun wait0/0),
    put(sw0, SW0Pid).

snd_msg0(Pid0, M) ->
    Pid0 ! {get(sw0), {M, 0}}.

snd_msg1(Pid1, M) ->
    Pid1 ! {get(sw0), {M, 1}}.

wait0() ->   %wait(0), chk_ack(0)
    io:format("enter wait0~n"),
    receive
        {Pid, 0} ->
            io:format("0~n"),
            wait1();
        {Pid, 1} ->
            wait0()
    end.
wait1() ->
    io:format("enter wait1~n"),
    receive
        {Pid, 0} ->
            wait1();
        {Pid, 1} ->
            io:format("1~n"),
            wait0()
    end.