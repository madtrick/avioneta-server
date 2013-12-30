-module(avioneta_channel).
-behaviour(gen_server).

-export([create/1, send/2]).
-export([init/1, handle_cast/2, terminate/2]).

-record(avioneta_channel_state, {
    wsserver_worker
  }).

create(WSWorker) ->
  gen_server:start_link(?MODULE, WSWorker, []).

send(Channel, Data) ->
  gen_server:cast(Channel, {send, Data}).

init(WSWorker) ->
  avioneta_registry:register(self()),
  {ok, #avioneta_channel_state{ wsserver_worker = WSWorker }}.

handle_cast({send, Data}, State) ->
  wsserver_worker:send(State#avioneta_channel_state.wsserver_worker, Data),
  {noreply, State}.

terminate(_Reason, _State) ->
  die.
