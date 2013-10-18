-module(avioneta_move_player_order_data).

-export([new/2]).
-export([avioneta_player_component/1]).

-record(avioneta_move_player_order_data, {
    avioneta_player_component
  }).

new(Order, Data) ->
  OrderData = #avioneta_move_player_order_data{
    avioneta_player_component = proplists:get_value(avioneta_player_component, Data)
  },

  avioneta_order_data:new(Order, OrderData).

avioneta_player_component(#avioneta_move_player_order_data{ avioneta_player_component = AvionetPlayerComponent }) -> AvionetPlayerComponent.
