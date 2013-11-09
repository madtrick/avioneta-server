-module(avioneta_destroy_player_order_data).

-export([new/2]).
-export([player_id/1]).

-record(avioneta_destroy_player_order_data, {
    player_id
  }).

new(Order, Data) ->
  OrderData = #avioneta_destroy_player_order_data{
    player_id = proplists:get_value(player_id, Data)
  },

  avioneta_message_data:new(Order, OrderData).

player_id(#avioneta_destroy_player_order_data{ player_id = PlayerId }) -> PlayerId.
