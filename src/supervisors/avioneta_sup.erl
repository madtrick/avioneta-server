-module(avioneta_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-define(CHILD(I, Type, Options), {I, {I, start_link, Options}, permanent, 5000, Type, [I]}).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
  {ok, { {one_for_one, 5, 10}, [
        ?CHILD(wsserver, worker, [[{port, 8080}, {worker_options, [{handler, avioneta_handler}]}]]),
        ?CHILD(avioneta_registry, worker, []),
        ?CHILD(avioneta_multicast, worker, []),
        ?CHILD(avioneta_games_sup, supervisor, []),
        ?CHILD(avioneta_core, worker, [])
      ]} }.
