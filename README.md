simple
=====

In chapter 6 of "Making reliable distributed systems in the presence of software errors" [dissertation](https://erlang.org/download/armstrong_thesis_2003.pdf), [Joe Armstrong](https://en.wikipedia.org/wiki/Joe_Armstrong_(programmer)) provides examples of behaviour-based 
Erlang applications. This is the collection of these examples.

Build
-----

    $ rebar3 compile


Run (via rebar3 shell)
-----

	$ rebar3 shell
	===> Verifying dependencies...
	===> Compiling simple
	Erlang/OTP 23 [erts-11.0] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe] [dtrace]

	Eshell V11.0  (abort with ^G)
	1> ===> The rebar3 shell is a development tool; to deploy applications in production, consider using releases (http://www.rebar3.org/docs/releases)
	Packet assembler starting
	Key-Value server starting
	Logger starting
	===> Booted simple

	1>
	1>
	1> kv:lookup(a).
	error
	2>

