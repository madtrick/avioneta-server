-module(avioneta_register_player_order).

-export([new/1, toJSON/1]).

new(PlayerComponent) ->
  avioneta_register_player_order_data:new(?MODULE, [
      {avioneta_player_component, PlayerComponent}
    ]).

toJSON(OrderData) ->
  avioneta_register_player_order_serializer:toJSON(OrderData).



