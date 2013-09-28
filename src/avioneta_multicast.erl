-module(avioneta_multicast).
-behaviour(gen_server).

-export([start_link/0, publish/2]).
-export([init/1, handle_cast/2, terminate/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

publish(Data, Channels) ->
  gen_server:cast(?MODULE, {publish, Data, Channels}).

init(_) ->
  {ok, undefined}.

handle_cast({publish, Data, Channels}, State) ->
  publish_data_to_channels(Data, Channels),
  {noreply, State}.

publish_data_to_channels(Data, []) ->
  published;
publish_data_to_channels(Data, [Channel | Tail]) ->
  publish_data_to_channel(Data, Channel),
  publish_data_to_channels(Data, Tail).
publish_data_to_channel(Data, Channel) ->
  avioneta_channel:send(Channel, Data).

terminate(_Reason, _State) ->
  die.
