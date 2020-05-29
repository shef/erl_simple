%%%-------------------------------------------------------------------
%% @doc simple top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(simple_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([start/0, init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start() ->
	start_link().

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    %% {ok, { {one_for_all, 0, 1}, []} }.
    {ok,
    	{{one_for_one, 5, 1000},
    		[
    			{packet,
    				{packet_assembler, start, []},
    				permanent, 500, worker, [packet_assembler]},
				{server,
					{kv, start, []},
					permanent, 500, worker, [kv]},
				{logger,
					{simple_logger, start, []},
					permanent, 500, worker, [simple_logger]}]}}.

%%====================================================================
%% Internal functions
%%====================================================================
