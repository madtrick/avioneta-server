-module(avioneta_player_component_data).

-export([new/1]).
-export([id/1, x/1, y/1, origin/1, avioneta_game_context_data/1]).

-record(avioneta_player_component_data, {
    id,
    x,
    y,
    origin,
    avioneta_game_context_data
  }).

new(Data) ->
  #avioneta_player_component_data{
    id     = proplists:get_value(id, Data),
    x      = proplists:get_value(x, Data),
    y      = proplists:get_value(y, Data),
    origin = proplists:get_value(origin, Data),
    avioneta_game_context_data = proplists:get_value(avioneta_game_context_data, Data)
  }.

id(#avioneta_player_component_data{ id = Id }) -> Id.
x(#avioneta_player_component_data{ x = X }) -> X.
y(#avioneta_player_component_data{ y = Y }) -> Y.
origin(#avioneta_player_component_data{ origin = Origin }) -> Origin.
avioneta_game_context_data(#avioneta_player_component_data{ avioneta_game_context_data = Data }) -> Data.
