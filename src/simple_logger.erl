-module(simple_logger).
-behaviour(gen_event).

-export([start/0, stop/0, log/1, report/0]).

-export([init/1, terminate/2,
		 handle_event/2, handle_call/2]).

-define(NAME, my_simple_event_logger).

start() ->
	case gen_event:start_link({local, ?NAME}) of
		Ret = {ok, Pid} ->
			gen_event:add_handler(?NAME, ?MODULE,arg1),
			Ret;
		Other ->
			Other
	end.

stop() -> gen_event:stop(?NAME).

log(E) -> gen_event:notify(?NAME, ?MODULE, report).

report() ->
	gen_event:call(?NAME, ?MODULE, report).

init(arg1) ->
	io:format("Logger starting~n"),
	{ok, []}.

handle_event({log, E}, S) 	-> {ok, trim([E|S])}.

handle_call(report, S)		-> {ok, S, S}.

terminate(stop, _)			-> true.

trim([X1,X2,X3,X4,X5|_])	-> [X1, X2, X3, X4, X5];
trim(L)						-> L.