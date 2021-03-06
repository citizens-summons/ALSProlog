%% Tests non-ISO put/get_* IO procedures: put_atom, put_string, put_number, get_number
%%   Note: put/get_number binary encoding/decoding is tested in numio.pro
:- [test].

test :- test([
	test_errors,
	test_put_number_types,
	test_get_number_types,

	true
]).

etest(Goal, Error) :-
	catch((Goal, !, fail), error(Error, _), true).

test_errors :- test([

% Test standard stream errors
etest(put_atom(V, a),    instantiation_error),
etest(put_atom(a, a),    existence_error(stream,a)),
etest(put_atom(1, a),    domain_error(stream_or_alias,1)),
etest(put_atom([a], a),  domain_error(stream_or_alias,[a])),
etest(put_atom(f(a), a), domain_error(stream_or_alias,f(a))),

etest(put_string(V, "a"),    instantiation_error),
etest(put_string(a, "a"),    existence_error(stream,a)),
etest(put_string(1, "a"),    domain_error(stream_or_alias,1)),
etest(put_string([a], "a"),  domain_error(stream_or_alias,[a])),
etest(put_string(f(a), "a"), domain_error(stream_or_alias,f(a))),

etest(put_number(V, byte, 1),    instantiation_error),
etest(put_number(a, byte, 1),    existence_error(stream,a)),
etest(put_number(1, byte, 1),    domain_error(stream_or_alias,1)),
etest(put_number([a], byte, 1),  domain_error(stream_or_alias,[a])),
etest(put_number(f(a), byte, 1), domain_error(stream_or_alias,f(a))),

etest(get_number(V, byte, 1),    instantiation_error),
etest(get_number(a, byte, 1),    existence_error(stream,a)),
etest(get_number(1, byte, 1),    domain_error(stream_or_alias,1)),
etest(get_number([a], byte, 1),  domain_error(stream_or_alias,[a])),
etest(get_number(f(a), byte, 1), domain_error(stream_or_alias,f(a))),

% test arg errors
etest(put_atom(user, V),    instantiation_error),
etest(put_atom(user, 1),    type_error(atom,1)),
etest(put_atom(user, [a]),  type_error(atom,[a])),
etest(put_atom(user, f(a)), type_error(atom,f(a))),

etest(put_string(user, V),    instantiation_error),
etest(put_string(user, a),    type_error(list,a)),
etest(put_string(user, 1),    type_error(list,1)),
etest(put_string(user, f(a)), type_error(list,f(a))),
%% TODO: determine correct errors for put_string/2 clause:
%% etest(put_string(user, [a]),  representation_error(character_code)),
%% Possibilities:
%% etest(put_string(user,[a]), ... prob integer type error ...)
%% etest(put_string(user,[-1000]), ... prob rep error ... )
%% There’s no defn in builtins for representation_error(character_code).  
%% Most of the others, like domain_error/3, are in blt_evt.pro.
%% The only call on it is found in blt_term.pro:
/*
S =.. L :-
       var(S),
       list(L),
       length(L, Length),
       Length > 255,
	representation_error(max_arity, 2).
*/
etest(put_number(user, byte, V),    instantiation_error),
etest(put_number(user, byte, a),    type_error(byte,a)),
etest(put_number(user, byte, [a]),  type_error(byte,[a])),
etest(put_number(user, byte, f(a)), type_error(byte,f(a))),

% Test number input/output type errors
etest(put_number(user, V, 1),    instantiation_error),
etest(put_number(user, 1, 1),    domain_error(num_output_type,1)),
etest(put_number(user, [a], 1),  domain_error(num_output_type,[a])),
etest(put_number(user, f(a), 1), domain_error(num_output_type,f(a))),
etest(put_number(user, a, 1),    domain_error(num_output_type, a)),

etest(get_number(user, V, 1),    instantiation_error),
etest(get_number(user, 1, 1),    domain_error(num_input_type, 1)),
etest(get_number(user, [a], 1),  domain_error(num_input_type, [a])),
etest(get_number(user, f(a), 1), domain_error(num_input_type, f(a))),
etest(get_number(user, a, 1),    domain_error(num_input_type, a)),

true
]).

test_put_number_types :-
	open(string(S), write, _, [alias(i)]),

	test([
		put_number(i, byte, 1),
		put_number(i, ubyte, 1),
		put_number(i, char, 1),
		put_number(i, uchar, 1),
		put_number(i, short, 1),
		put_number(i, ushort, 1),
		put_number(i, int, 1),
		put_number(i, uint, 1),
		put_number(i, long, 1),
		put_number(i, ulong, 1),
		put_number(i, float, 1),
		put_number(i, double, 1),

		true
	]),

	close(i).

test_get_number_types :-
	open(string("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"), read, _, [alias(o)]),

	test([
		(get_number(o, byte, N),   number(N)),
		(get_number(o, ubyte, N),  number(N)),
		(get_number(o, char, N),   number(N)),
		(get_number(o, uchar, N),  number(N)),
		(get_number(o, short, N),  number(N)),
		(get_number(o, ushort, N), number(N)),
		(get_number(o, int, N),    number(N)),
		(get_number(o, uint, N),   number(N)),
		(get_number(o, long, N),   number(N)),
		(get_number(o, ulong, N),  number(N)),
		(get_number(o, float, N),  number(N)),
		(get_number(o, double, N), number(N)),

		true
	]),

	close(o).

