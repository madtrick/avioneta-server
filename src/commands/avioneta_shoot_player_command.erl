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
      {shot_id, shoot_id()},
      {x, avioneta_shoot_player_command_data:x(CommandData)},
      {y, avioneta_shoot_player_command_data:y(CommandData)}
    ]
  ).

shoot_id() ->
  % NOTE: find a better way to encode this as a binary
  erlang:list_to_binary(["Shot-", erlang:integer_to_list(fserlangutils_time:microseconds_since_epoch())]).
