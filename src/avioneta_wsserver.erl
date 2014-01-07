-module(avioneta_wsserver).

-export([config/0]).

-define(PORT_ENV_VARIABLE, "PORT").


config() ->
  [{port, port()}, {number_of_workers, 3}, {worker_options, [{protocol_modules_options, protocol_modules_options()}]}].

port() ->
  avioneta_config:get(port, fserlangutils_string:to_integer(os:getenv(?PORT_ENV_VARIABLE))).

protocol_modules_options() ->
  [
    {wsserver_websocket_protocol,[
        {handler_module, avioneta_handler}
      ]
    }
  ].
