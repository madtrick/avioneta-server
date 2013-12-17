-module(avioneta_wsserver).

-export([config/0]).

-define(PORT_ENV_VARIABLE, "PORT").


config() ->
  [{port, port()}, {worker_options, worker_options()}].

port() ->
  avioneta_config:get(port, fserlangutils_string:to_integer(os:getenv(?PORT_ENV_VARIABLE))).

worker_options() ->
  [{handler, avioneta_handler}].
