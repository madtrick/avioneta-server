-module(avioneta_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  init_random_seed(),
  avioneta_sup:start_link().

stop(_State) ->
  ok.

init_random_seed() ->
  random:seed(erlang:now()).
