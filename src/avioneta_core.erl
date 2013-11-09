-module(avioneta_core).
-behaviour(gen_server).

-export([start_link/0, process_message/2]).
-export([init/1, handle_cast/2, terminate/2]).

-record(avioneta_core_state, {
    avioneta_game
  }).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

process_message(Message, OriginChannel) ->
  gen_server:cast(?MODULE, {process_message, OriginChannel, Message}).

init(_) ->
  {ok, build_avioneta_core_state()}.

handle_cast({disconnect_player, OriginChannel}, State) ->
  ok;
handle_cast({process_message, OriginChannel, Message}, State) ->
  NewAvionetaCoreStateData = handle_process_message(OriginChannel, Message, State),
  {noreply, NewAvionetaCoreStateData}.

handle_process_message(OriginChannel, {text, Message}, State) ->
  CommandContexts = avioneta_command_parser:parse(Message),
  Messages =  avioneta_command_runner:run(CommandContexts, avioneta_game(State), OriginChannel),
  Channels = filter_origin_channel(OriginChannel, avioneta_registry:entries()),
  avioneta_message_dispatcher:dispatch(Messages, OriginChannel, Channels ),
  State.
filter_origin_channel(OriginChannel, Channels) ->
  lists:filter(fun(Element) -> Element =/= OriginChannel end, Channels).

terminate(_Reason, _State) ->
  die.

build_avioneta_core_state() ->
  GameName = random_game_name(),
  avioneta_games_sup:add_game(GameName),
  avioneta_core_state_data:new(GameName).

avioneta_game(State) ->
  avioneta_core_state_data:avioneta_game(State).

random_game_name() ->
  %
  % PLEASE NOTE that if the server stays up for too long we might run out of memory
  % if the atom table grows. Right now we have to stick with atoms as is the only valid
  % value for locally registering processes. In the future we might migrate to a global
  % registry
  %
  erlang:list_to_atom("game-" ++ erlang:integer_to_list(fserlangutils_time:microseconds_since_epoch())).
