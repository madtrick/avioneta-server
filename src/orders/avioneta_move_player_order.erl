-module(avioneta_move_player_order).

-export([new/1, toJSON/1]).

new(AvionetaPlayerComponent) ->
  avioneta_move_player_order_data:new(?MODULE, [{avioneta_player_component, AvionetaPlayerComponent}]).

toJSON(OrderData) ->
  avioneta_move_player_order_serializer:toJSON(OrderData).
