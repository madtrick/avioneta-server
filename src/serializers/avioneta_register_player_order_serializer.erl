-module(avioneta_register_player_order_serializer).

-export([toJSON/1]).

toJSON(RegisterPlayerOrderData) ->
  PlayerComponent = avioneta_register_player_order_data:avioneta_player_component(RegisterPlayerOrderData),
  Struct = {[
          {type, <<"RegisterPlayerOrder">>},
          {data, {[
                {id, avioneta_player_component:id(PlayerComponent)},
                {x, avioneta_player_component:x(PlayerComponent)},
                {y, avioneta_player_component:y(PlayerComponent)}
              ]}
          }
        ]},
  jiffy:encode(Struct).

