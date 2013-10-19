-module(avioneta_shot_data).

-export([new/1]).
-export([id/1, x/1, y/1]).

-record(avioneta_shot_data, {
    id,
    x,
    y
  }).

new(Data) ->
  #avioneta_shot_data{
    id = proplists:get_value(id, Data),
    x = proplists:get_value(x, Data),
    y = proplists:get_value(y, Data)
  }.

id(#avioneta_shot_data{ id = Id }) -> Id.
x(#avioneta_shot_data{ x = X }) -> X.
y(#avioneta_shot_data{ y = Y }) -> Y.

