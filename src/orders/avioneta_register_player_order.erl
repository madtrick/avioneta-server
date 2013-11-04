-module(avioneta_register_player_order).

-export([new/2, toJSON/1]).

new(PlayerComponent, Remote) ->
  avioneta_register_player_order_data:new(?MODULE, [
      {avioneta_player_component, PlayerComponent},
      {remote, Remote}
    ]).

toJSON(OrderData) ->
  avioneta_register_player_order_serializer:toJSON(OrderData).



