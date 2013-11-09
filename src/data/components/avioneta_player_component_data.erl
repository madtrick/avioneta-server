-module(avioneta_player_component_data).

-export([new/1]).
-export([id/1, x/1, y/1, origin/1, avioneta_game_context_data/1, color/1]).
-export([update/2]).

-record(avioneta_player_component_data, {
    id,
    x,
    y,
    origin,
    color,
    avioneta_game_context_data
  }).

new(Data) ->
  #avioneta_player_component_data{
    id     = proplists:get_value(id, Data),
    x      = proplists:get_value(x, Data),
    y      = proplists:get_value(y, Data),
    origin = proplists:get_value(origin, Data),
    color  = proplists:get_value(color, Data),
    avioneta_game_context_data = proplists:get_value(avioneta_game_context_data, Data)
  }.

id(#avioneta_player_component_data{ id = Id }) -> Id.
x(#avioneta_player_component_data{ x = X }) -> X.
y(#avioneta_player_component_data{ y = Y }) -> Y.
color(#avioneta_player_component_data{ color = Color }) -> Color.
origin(#avioneta_player_component_data{ origin = Origin }) -> Origin.
avioneta_game_context_data(#avioneta_player_component_data{ avioneta_game_context_data = Data }) -> Data.

update(AvionetaPlayerComponentData, Data) ->
  AvionetaPlayerComponentData#avioneta_player_component_data{
    x = proplists:get_value(x, Data, x(AvionetaPlayerComponentData)),
    y = proplists:get_value(y, Data, y(AvionetaPlayerComponentData))
  }.
