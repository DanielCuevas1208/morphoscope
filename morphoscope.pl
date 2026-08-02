:- module(morphoscope,
          [ analyze/4,
            generate/4,
            paradigm/3,
            lexicon_size/2,
            supported_language/1
          ]).

:- use_module('src/engine', []).

%% analyze(+Language, +Form, -Lemma, -Features) is nondet.
%
%  Analyze a surface form. Ambiguous forms produce one answer per reading.
analyze(Language, Form, Lemma, Features) :-
    morphoscope_engine:analyze(Language, Form, Lemma, Features).

%% generate(+Language, +Lemma, -Form, -Features) is nondet.
%
%  Generate every supported surface form for a known lemma.
generate(Language, Lemma, Form, Features) :-
    morphoscope_engine:generate(Language, Lemma, Form, Features).

%% paradigm(+Language, +Lemma, -Forms) is semidet.
%
%  Return the ordered paradigm as form(Surface, Features) terms.
paradigm(Language, Lemma, Forms) :-
    morphoscope_engine:paradigm(Language, Lemma, Forms).

%% lexicon_size(+Language, -Count) is semidet.
%
%  Return the number of known lemmas for a language.
lexicon_size(Language, Count) :-
    morphoscope_engine:lexicon_size(Language, Count).

supported_language(en).
supported_language(es).