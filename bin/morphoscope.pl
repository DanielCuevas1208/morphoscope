:- use_module('../morphoscope').
:- use_module(library(lists), [member/2]).

:- initialization(main, main).

main :-
    current_prolog_flag(argv, Arguments),
    (   command(Arguments)
    ->  halt(0)
    ;   usage,
        halt(2)
    ).

command([analyze, Language, Form]) :-
    findall(analysis(Lemma, Features),
            morphoscope:analyze(Language, Form, Lemma, Features),
            Analyses),
    Analyses \= [],
    forall(member(analysis(Lemma, Features), Analyses),
           format('lemma=~w features=~q~n', [Lemma, Features])).
command([generate, Language, Lemma]) :-
    findall(form(Form, Features),
            morphoscope:generate(Language, Lemma, Form, Features),
            Forms),
    Forms \= [],
    forall(member(form(Form, Features), Forms),
           format('form=~w features=~q~n', [Form, Features])).
command([paradigm, Language, Lemma]) :-
    morphoscope:paradigm(Language, Lemma, Forms),
    Forms \= [],
    forall(member(form(Form, Features), Forms),
           format('form=~w features=~q~n', [Form, Features])).
command([help]) :-
    usage.
command([]) :-
    usage.

usage :-
    format('Usage:\n', []),
    format('  swipl -q -s bin/morphoscope.pl -- analyze en walked\n', []),
    format('  swipl -q -s bin/morphoscope.pl -- generate es hablar\n', []),
    format('  swipl -q -s bin/morphoscope.pl -- paradigm en go\n', []).