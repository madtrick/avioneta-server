-module(avioneta_handler).
-export([init/1, handle/2]).

-record(avioneta_state, {avioneta_channel}).

init(Options) ->
  Worker        = proplists:get_value(worker, Options),
  {ok, Channel} = avioneta_channel:create(Worker),
  #avioneta_state{avioneta_channel = Channel}.

handle(Message, State) ->
  io:format("Message received"),
  avioneta_core:process_message(Message, State#avioneta_state.avioneta_channel),
  {noreply,  State}.
