-module(avioneta_register_player_context).

-export([call/3]).

call(CommandContextData, AvionetaGame, OriginChannel) ->
  UpdatedCommandContextData = avioneta_command_context_data:update(CommandContextData, [{origin, OriginChannel}, {avioneta_game, AvionetaGame}]),
  CommandData = avioneta_command_context_data:command_data(UpdatedCommandContextData),
  {registered, NewPlayer} = (avioneta_command_data:runner(CommandData)):run(
    avioneta_command_data:runner_data(CommandData), UpdatedCommandContextData
  ),

  ArenaComponent = avioneta_game:arena_component(AvionetaGame),
  %Orders = [avioneta_register_player_order:new(Player) || Player <- avioneta_arena_component:players(ArenaComponent), Player =/= NewPlayer],

  RegisterNewPlayerOrder = avioneta_register_player_order:new(NewPlayer, false),
  RegisterPlayersOrder = [avioneta_register_player_order:new(Player, true) || Player <- avioneta_arena_component:players(ArenaComponent), Player =/= NewPlayer],

  [{send_to_origin, [RegisterNewPlayerOrder | RegisterPlayersOrder]}, {send_to_others, [RegisterNewPlayerOrder]}].
