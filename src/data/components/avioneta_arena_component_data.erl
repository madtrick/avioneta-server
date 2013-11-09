-module(avioneta_arena_component_data).

-export([new/1]).
-export([players/1, avioneta_player_component_sup/1, avioneta_game_context_data/1, width/1, height/1]).
-export([update/2]).

-record(avioneta_arena_component_data, {
    players,
    avioneta_player_component_sup,
    avioneta_game_context_data,
    width,
    height
  }).

new(Options) ->
  #avioneta_arena_component_data{
    players                       = [],
    avioneta_player_component_sup = proplists:get_value(avioneta_player_component_sup, Options),
    avioneta_game_context_data    = proplists:get_value(avioneta_game_context_data, Options),
    width                         = proplists:get_value(width, Options),
    height                        = proplists:get_value(height, Options)
  }.

players(#avioneta_arena_component_data{ players = Players }) -> Players.
avioneta_player_component_sup(#avioneta_arena_component_data{ avioneta_player_component_sup = AvionetaPlayerComponentSup }) -> AvionetaPlayerComponentSup.
avioneta_game_context_data(#avioneta_arena_component_data{ avioneta_game_context_data = AvionetaGameContextData }) -> AvionetaGameContextData.
width(#avioneta_arena_component_data{ width = Width }) -> Width.
height(#avioneta_arena_component_data{ height = Height }) -> Height.

update(ArenaComponentData, Options) ->
  ArenaComponentData#avioneta_arena_component_data{
    players = proplists:get_value(players, Options, players(ArenaComponentData))
  }.
