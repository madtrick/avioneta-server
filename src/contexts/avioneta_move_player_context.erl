-module(avioneta_move_player_context).

-export([call/3]).

call(CommandContextData, AvionetaGame, OriginChannel) ->
  UpdatedCommandContextData = avioneta_command_context_data:update(CommandContextData, [{origin, OriginChannel}, {avioneta_game, AvionetaGame}]),
  CommandData = avioneta_command_context_data:command_data(UpdatedCommandContextData),

  Player = (avioneta_command_data:runner(CommandData)):run(
    avioneta_command_data:runner_data(CommandData), UpdatedCommandContextData
  ),

  MovePlayerOrder = avioneta_move_player_order:new(Player),

  [{send_to_others, [MovePlayerOrder]}].

