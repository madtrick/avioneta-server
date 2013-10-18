-module(avioneta_move_player_order_serializer).

-export([toJSON/1]).

toJSON(MovePlayerOrderData) ->
  PlayerComponent = avioneta_move_player_order_data:avioneta_player_component(MovePlayerOrderData),
  Struct = {[
      {type, <<"MovePlayerOrder">>},
      {data, {[
            {id, avioneta_player_component:id(PlayerComponent)},
            {x, avioneta_player_component:x(PlayerComponent)},
            {y, avioneta_player_component:y(PlayerComponent)}
          ]}
      }
    ]},
  jiffy:encode(Struct).
