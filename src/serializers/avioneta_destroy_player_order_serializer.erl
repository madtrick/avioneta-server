-module(avioneta_destroy_player_order_serializer).

-export([toJSON/1]).

toJSON(DestroyPlayerOrderData) ->
  PlayerId = avioneta_destroy_player_order_data:player_id(DestroyPlayerOrderData),
  Struct = {[
      {type, <<"DestroyPlayerOrder">>},
      {data, {[
            {id, PlayerId}
          ]}
      }
    ]},
  jiffy:encode(Struct).
