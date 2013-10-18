-module(avioneta_move_player_command_data).

-export([new/2]).
-export([id/1, axis/1, value/1]).

-record(avioneta_move_player_command_data, {
    id,
    axis,
    value
  }).

new(Runner, Data) ->
  CommandData = #avioneta_move_player_command_data{
    id = proplists:get_value(id, Data),
    axis = proplists:get_value(axis, Data),
    value= proplists:get_value(value, Data)
  },

  avioneta_command_data:new(Runner, CommandData).

id(#avioneta_move_player_command_data{ id = Id }) -> Id.
axis(#avioneta_move_player_command_data{ axis = Axis }) -> Axis.
value(#avioneta_move_player_command_data{ value = Value }) -> Value.
