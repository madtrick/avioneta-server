-module(avioneta_register_player_command_data).

-export([new/2, id/1, x/1, y/1]).

-record(avioneta_register_player_command_data, {
    id,
    x,
    y
  }).

new(Runner, Data) ->
  CommandData = #avioneta_register_player_command_data{
    id = proplists:get_value(id, Data),
    x  = proplists:get_value(x, Data),
    y  = proplists:get_value(y, Data)
  },

  avioneta_command_data:new(Runner, CommandData).


id(#avioneta_register_player_command_data{ id = Id }) -> Id.

x(#avioneta_register_player_command_data{ x = X }) -> X.

y(#avioneta_register_player_command_data{ y = Y }) -> Y.
