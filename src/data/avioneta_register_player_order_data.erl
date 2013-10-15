-module(avioneta_register_player_order_data).

-export([new/2, avioneta_player_component/1]).

-record(avioneta_register_player_order_data, {
    avioneta_player_component
  }).

new(Order, Data) ->
  OrderData = #avioneta_register_player_order_data{
    avioneta_player_component = proplists:get_value(avioneta_player_component, Data)
  },

  avioneta_order_data:new(Order, OrderData).

avioneta_player_component(#avioneta_register_player_order_data{ avioneta_player_component = PlayerComponent }) -> PlayerComponent.
