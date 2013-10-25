-module(avioneta_destroy_player_order).

-export([new/1, toJSON/1]).

new(PlayerId) ->
  avioneta_destroy_player_order_data:new(?MODULE, [{player_id, PlayerId}]).

toJSON(OrderData) ->
  avioneta_destroy_player_order_serializer:toJSON(OrderData).
