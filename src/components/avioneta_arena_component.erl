-module(avioneta_arena_component).
-behaviour(gen_server).

-export([start_link/1]).
-export([add_player/2, players/1]).
-export([init/1, handle_call/3, handle_info/2]).

-define(PLAYER_DOWN(Pid), {'DOWN', _, process, Pid, _}).

start_link(AvionetaGameContextData) ->
  gen_server:start_link(?MODULE, [AvionetaGameContextData], []).

add_player(ArenaComponent, Data) ->
  gen_server:call(ArenaComponent, {add_player, Data}).

players(ArenaComponent) ->
  gen_server:call(ArenaComponent, players).

init([AvionetaGameContextData]) ->
  {ok, AvionetaPlayerComponentSup} = avioneta_player_component_sup:start_link(),
  {ok, avioneta_arena_component_data:new([{avioneta_game_context_data, AvionetaGameContextData}, {avioneta_player_component_sup, AvionetaPlayerComponentSup}])}.

handle_info(?PLAYER_DOWN(Pid), ArenaComponentData) ->
  lager:debug("Player is down"),


  NewPlayers = [Player || Player <- avioneta_arena_component_data:players(ArenaComponentData), Player =/= Pid ],
  NewArenaComponentData = avioneta_arena_component_data:update(ArenaComponentData, [{players, NewPlayers}]),
  {noreply, NewArenaComponentData}.

handle_call({add_player, Data}, _, ArenaComponentData) ->
  {ok, Player}                = avioneta_player_component_sup:add_player(
    avioneta_arena_component_data:avioneta_player_component_sup(ArenaComponentData),
    avioneta_arena_component_data:avioneta_game_context_data(ArenaComponentData),
    Data
  ),
  monitor_player_componet(Player),
  Players               = avioneta_arena_component_data:players(ArenaComponentData),
  NewArenaComponentData = avioneta_arena_component_data:update(ArenaComponentData, [{players, [Player | Players]}]),
  {reply, Player, NewArenaComponentData};

handle_call(players, _, ArenaComponentData) ->
  {reply, avioneta_arena_component_data:players(ArenaComponentData), ArenaComponentData}.

monitor_player_componet(Player) ->
  monitor(process, Player).

avioneta_event_bus(ArenaComponentData) ->
  AvionetaGameContextData = avioneta_arena_component_data:avioneta_game_context_data(ArenaComponentData),
  avioneta_game_context_data:avioneta_event_bus(AvionetaGameContextData).
