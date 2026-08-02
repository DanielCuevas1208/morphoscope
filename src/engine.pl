:- module(morphoscope_engine,
          [ analyze/4,
            generate/4,
            paradigm/3,
            lexicon_size/2
          ]).

:- use_module(languages/english, []).
:- use_module(languages/spanish, []).
:- use_module(library(error)).

language_module(en, morphoscope_english).
language_module(es, morphoscope_spanish).

analyze(Language, Form0, Lemma, Features) :-
    must_be(atom, Language),
    must_be(atom, Form0),
    language_module(Language, Module),
    downcase_atom(Form0, Form),
    call(Module:inflection(Lemma, Form, Features)).

generate(Language, Lemma0, Form, Features) :-
    must_be(atom, Language),
    must_be(atom, Lemma0),
    language_module(Language, Module),
    downcase_atom(Lemma0, Lemma),
    call(Module:known_lemma(Lemma)),
    call(Module:inflection(Lemma, Form, Features)).

paradigm(Language, Lemma0, Forms) :-
    must_be(atom, Language),
    must_be(atom, Lemma0),
    language_module(Language, Module),
    downcase_atom(Lemma0, Lemma),
    call(Module:known_lemma(Lemma)),
    findall(form(Form, Features),
            call(Module:inflection(Lemma, Form, Features)),
            Forms).

lexicon_size(Language, Count) :-
    must_be(atom, Language),
    language_module(Language, Module),
    call(Module:lexicon_size(Count)).