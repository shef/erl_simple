-module(packet_assembler).
-behaviour(gen_fsm).

-export([start/0, send_header/1, send_data/1]).

-export([init/1, terminate/3, waiting/2, collecting/2]).

-define(NAME, my_simple_packet_assembler).

start() ->
	gen_fsm:start_link({local, ?NAME}, ?MODULE, arg1,[]).

send_header(Len) 	-> gen_fsm:send_event(?NAME, Len).

send_data(Str) 		-> gen_fsm:send_event(?NAME, Str).

init(arg1) ->
	io:format("Packet assembler starting~n"),
	{ok, waiting, nil}.

waiting(N, nil) ->
	{next_state, collecting, {N,0,[]}}.

collecting(Buff0, {Need, Len, Buff1}) ->
	L = length(Buff0),
	if
		L + Len < Need ->
			{next_state, collecting,
				{Need, Len+L, Buff1++Buff0}};
		L + Len == Need ->
			Buff = Buff1 ++ Buff0,
			io:format("Got data:~s~n", [Buff]),
			{next_state, waiting, nil}
	end.

terminate(Reason, State, Data) ->
	io:format("packet assembler terminated:"
				"~p ~n", [Reason]),
	true.