-module(avioneta_shoot_player_order).

-export([new/1, toJSON/1]).

new(Shot) ->
  avioneta_shoot_player_order_data:new(?MODULE, [{shot, Shot}]).

toJSON(OrderData) ->
  avioneta_shoot_player_order_serializer:toJSON(OrderData).
