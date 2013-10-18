-module(avioneta_move_player_command).

-export([fromJSON/1, run/2]).

% {player : , axis : , value : }
fromJSON(JSON) ->
  {[{<<"player">>, Id}, {<<"axis">>, Axis}, {<<"value">>, Value}]} = JSON,
  avioneta_move_player_command_data:new(?MODULE, [{id, Id}, {axis, Axis}, {value, Value}]).

run(CommandData, ContextData) ->
  lager:debug("Running register_player_command"),
  Player = avioneta_arena_component:get_player(arena_component(ContextData), player_id(CommandData)),
  avioneta_player_component:move(Player, [{axis, axis(CommandData)}, {value, value(CommandData)}]),
  Player.

arena_component(ContextData) ->
  avioneta_game:arena_component(
    avioneta_command_context_data:avioneta_game(ContextData)
  ).

player_id(CommandData) ->
  avioneta_move_player_command_data:id(CommandData).

axis(CommandData) ->
  avioneta_move_player_command_data:axis(CommandData).

value(CommandData) ->
  avioneta_move_player_command_data:value(CommandData).
