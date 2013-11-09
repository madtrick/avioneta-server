-module(avioneta_shoot_player_order_serializer).

-export([toJSON/1]).

toJSON(ShootPlayerOrderData) ->
  Shot = avioneta_shoot_player_order_data:shot(ShootPlayerOrderData),
  Struct = {[
      {type, <<"ShootPlayerOrder">>},
      {data, {[
            {id, avioneta_shot_data:id(Shot)},
            {x, avioneta_shot_data:x(Shot)},
            {y, avioneta_shot_data:y(Shot)}
          ]}}
    ]},
  jiffy:encode(Struct).
