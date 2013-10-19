-module(avioneta_shoot_player_command).

-export([fromJSON/1, run/2]).

% {player : , x : , y :}
fromJSON(JSON) ->
  {[{<<"player">>, Id}, {<<"x">>, X}, {<<"y">>, Y}]} = JSON,
  avioneta_shoot_player_command_data:new(?MODULE, [{id, Id}, {x, X}, {y, Y}]).

run(CommandData, _ContextData) ->
  lager:debug("Running shoot_player_command"),
  avioneta_shot_data:new(
    [
      {id, avioneta_shoot_player_command_data:id(CommandData)},
      {x, avioneta_shoot_player_command_data:x(CommandData)},
      {y, avioneta_shoot_player_command_data:y(CommandData)}
    ]
  ).
