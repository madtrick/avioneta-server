-module(avioneta_command_parser).

-export([parse/1]).

-define(COMMAND(CommandType, Data), {[{<<"type">>, <<CommandType>>}, {<<"data">>, Data}]}).

parse(Data) ->
  JSON = jiffy:decode(Data),
  extract_commands_from_json(JSON).


extract_commands_from_json(JSON) ->
  extract_commands_from_json(JSON, []).

extract_commands_from_json([], Acc) ->
  lists:reverse(Acc);
extract_commands_from_json([ JSONElement | JSONElements ], Acc) ->
  extract_commands_from_json(JSONElements, extract_commands_from_json(JSONElement, Acc));
extract_commands_from_json({[{<<"type">>, <<"MovePlayerCommand">>}, _]}, Acc) ->
  Acc;
extract_commands_from_json(Command = {_}, Acc) ->
  [build_command(Command) | Acc].


build_command(?COMMAND("RegisterPlayerCommand", Data)) ->
  avioneta_command_context_data:new(avioneta_register_player_context, register_player_command:fromJSON(Data))  ;
build_command(?COMMAND("MovePlayerCommand", Data)) ->
  lager:debug("Cona"),
  [].
