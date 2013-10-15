-module(avioneta_order_dispatcher).

-export([dispatch/3]).

dispatch(Orders, Origin, Others) ->
  dispatch_orders(Orders, Origin, Others).

dispatch_orders([], _, _) ->
  done;
dispatch_orders([Order | Orders], OriginChannel, OtherChannels) ->
  {DispatchRule, Orders2} = Order,

  lager:debug("Dispatch rule ~w", [DispatchRule]),
  dispatch_with_rule(DispatchRule, convert_to_json(Orders2), OriginChannel, OtherChannels),
  dispatch_orders( Orders, OriginChannel, OtherChannels).

dispatch_with_rule(send_to_origin, Data, OriginChannel, _OtherChannels) ->
  avioneta_multicast:publish(Data, OriginChannel);
dispatch_with_rule(send_to_others, Data, _OriginChannel, OtherChannels) ->
  avioneta_multicast:publish(Data, OtherChannels);
dispatch_with_rule(_, _, _, _) ->
  lager:debug("Unknown dispatch rule").

convert_to_json(Orders) ->
  lists:foldl(fun(OrderData, Acc) ->
        [ (avioneta_order_data:order(OrderData)):toJSON(
          avioneta_order_data:order_data(OrderData)
        ) | Acc]
    end, [], Orders).


