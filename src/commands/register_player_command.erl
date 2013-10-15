-module(register_player_command).

-export([fromJSON/1, run/2]).

% {player : { id : , x : , y }}
fromJSON(JSON) ->
  {[{_Player, {[{<<"id">>, Id}, {<<"x">>, X}, {<<"y">>, Y}]}}]} = JSON,
  avioneta_register_player_command_data:new(?MODULE, [{id, Id}, {x, X}, {y, Y}]).

run(CommandData, ContextData) ->
  lager:debug("Running register_player_command"),
  Player = avioneta_arena_component:add_player(
    avioneta_game:arena_component(avioneta_command_context_data:avioneta_game(ContextData)),
    [
      {id, avioneta_register_player_command_data:id(CommandData)},
      {x, avioneta_register_player_command_data:x(CommandData)},
      {y, avioneta_register_player_command_data:y(CommandData)},
      {origin, avioneta_command_context_data:origin(ContextData)}
    ]
  ).
