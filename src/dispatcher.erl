-module (dispatcher).
-author("Roman Sotnikov <retgoat@gmail.com>").
-export ([dispatch/2, convert_method_to_action/1]).

dispatch(_,[]) -> none;

dispatch(Req, [{Regexp, Handler}|T]) ->
  "/" ++ Path = Req:get(path),
  Method = Req:get(method),
  Match = re:run(Path, Regexp, [global, {capture, all_but_first, list}]),
  case Match of
    {match, [MatchList]}->
      case length(MatchList) of
        0 ->
          Action = convert_method_to_action(Method),
          Handler:Action(Req, []);

        Length when Length > 0 ->
          Args = lists:flatten(MatchList),
          Action = convert_method_to_action(Method),
          Handler:Action(Req, Args)
      end;
    _ ->
      dispatch(Req, T)
  end.

convert_method_to_action(Method) ->
  List  = atom_to_list(Method),
  Action = string:sub_string(List, 1, length(List)),
  list_to_atom(string:to_lower(Action)).
