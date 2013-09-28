-module(avioneta_core).
-behaviour(gen_server).

-export([start_link/0, process_message/2]).
-export([init/1, handle_cast/2, terminate/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

process_message(Message, OriginChannel) ->
  gen_server:cast(?MODULE, {process_message, OriginChannel, Message}).

init(_) ->
  {ok, undefined}.

handle_cast({process_message, OriginChannel, Message}, State) ->
  handle_process_message(OriginChannel, Message),
  {noreply, State}.
handle_process_message(OriginChannel, {text, Message}) ->
  Channels = filter_origin_channel(OriginChannel, avioneta_registry:entries()),
  avioneta_multicast:publish(Message, Channels).
filter_origin_channel(OriginChannel, Channels) ->
  lists:filter(fun(Element) -> Element =/= OriginChannel end, Channels).

terminate(_Reason, _State) ->
  die.
