-module(avioneta_player_component).
-behaviour(gen_server).

-export([start_link/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).
-export([id/1, x/1, y/1, move/2]).

-define(PROCESS_EXIT(Pid), {'EXIT', Pid, _}).

start_link(AvionetaGameContextData, PlayerData) ->
  gen_server:start_link(?MODULE, [AvionetaGameContextData, PlayerData], []).

id(PlayerComponent) ->
  gen_server:call(PlayerComponent, id).

x(PlayerComponent) ->
  gen_server:call(PlayerComponent, x).

y(PlayerComponent) ->
  gen_server:call(PlayerComponent, y).

move(PlayerComponent, Data) ->
  gen_server:cast(PlayerComponent, {move, Data}).

init([AvionetaGameContextData, PlayerData]) ->
  PlayerComponentData = avioneta_player_component_data:new(
    [{avioneta_game_context_data, AvionetaGameContextData} | PlayerData]
  ),
  link_with_origin(PlayerComponentData),
  {ok, PlayerComponentData}.

handle_info(?PROCESS_EXIT(Pid), PlayerComponentData) ->
  react_to_process_exit(PlayerComponentData, Pid).

handle_cast({move, Data}, PlayerComponentData) ->
  [{axis, Axis}, {value, Value}] = Data,
  {noreply, move(Axis, Value, PlayerComponentData)}.

handle_call(id, _, PlayerComponentData) ->
  {reply, avioneta_player_component_data:id(PlayerComponentData), PlayerComponentData};
handle_call(x, _, PlayerComponentData) ->
  {reply, avioneta_player_component_data:x(PlayerComponentData), PlayerComponentData};
handle_call(y, _, PlayerComponentData) ->
  {reply, avioneta_player_component_data:y(PlayerComponentData), PlayerComponentData}.

terminate(Repos, PlayerComponentData) ->
  die.

move(<<"x">>, Value, PlayerComponentData) ->
  avioneta_player_component_data:update(
    PlayerComponentData,
    [{x, Value + avioneta_player_component_data:x(PlayerComponentData)}]
  );

move(<<"y">>, Value, PlayerComponentData) ->
  avioneta_player_component_data:update(
    PlayerComponentData,
    [{y, Value + avioneta_player_component_data:y(PlayerComponentData)}]
  ).

link_with_origin(PlayerComponentData) ->
  erlang:process_flag(trap_exit, true),
  erlang:link(avioneta_player_component_data:origin(PlayerComponentData)).

react_to_process_exit(PlayerComponentData, Pid) ->
  react_to_process_exit_if_origin(PlayerComponentData, avioneta_player_component_data:origin(PlayerComponentData), Pid).

react_to_process_exit_if_origin(PlayerComponentData, Origin, Pid) when Origin =:= Pid ->
  avioneta_event_bus:trigger(avioneta_event_bus(PlayerComponentData), <<"player.disconnected">>, [[{id, avioneta_player_component_data:id(PlayerComponentData)}]]),
  {stop, origin_exit, PlayerComponentData};
react_to_process_exit_if_origin(PlayerComponentData, _, _) ->
  {noreply, PlayerComponentData}.

avioneta_event_bus(PlayerComponentData) ->
  avioneta_game_context_data:avioneta_event_bus(
    avioneta_player_component_data:avioneta_game_context_data(PlayerComponentData)
  ).