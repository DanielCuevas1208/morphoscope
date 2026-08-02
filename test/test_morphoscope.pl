:- encoding(utf8).

:- begin_tests(morphoscope).

:- use_module('../morphoscope').
:- use_module(library(lists), [member/2]).

sorted_forms(Form, Forms) :-
    findall(Name,
            ( morphoscope:analyze(en, Form, _, Features),
              get_dict(form, Features, Name)
            ),
            Names),
    sort(Names, Forms).

test(supported_languages) :-
    findall(Language, morphoscope:supported_language(Language), Languages),
    assertion(Languages == [en, es]).

test(english_lexicon_is_about_two_hundred_lemmas) :-
    morphoscope:lexicon_size(en, Count),
    assertion(Count == 224).

test(spanish_lexicon_has_regular_and_irregular_entries) :-
    morphoscope:lexicon_size(es, Count),
    assertion(Count == 51).

test(analyze_regular_english_past_is_ambiguous) :-
    sorted_forms(walked, Forms),
    assertion(Forms == [past, past_participle]).

test(analyze_regular_english_y_spelling) :-
    morphoscope:analyze(en, studied, Lemma, Features),
    assertion(Lemma == study),
    assertion(Features.form == past).

test(analyze_irregular_english) :-
    morphoscope:analyze(en, went, Lemma, Features),
    assertion(Lemma == go),
    assertion(Features.form == past).

test(analyze_is_case_insensitive) :-
    morphoscope:analyze(en, 'Walked', Lemma, Features),
    assertion(Lemma == walk),
    assertion(Features.form == past).

test(english_spelling_rules) :-
    morphoscope:generate(en, study, studies, PresentFeatures),
    assertion(PresentFeatures.form == present),
    morphoscope:generate(en, study, studied, PastFeatures),
    assertion(PastFeatures.form == past),
    morphoscope:generate(en, study, studying, GerundFeatures),
    assertion(GerundFeatures.form == gerund),
    morphoscope:generate(en, stop, stopped, _),
    morphoscope:generate(en, stop, stopping, _).
test(generate_regular_english_paradigm) :-
    morphoscope:paradigm(en, walk, Forms),
    length(Forms, Count),
    assertion(Count == 15),
    assertion(member(form(walks, _), Forms)),
    assertion(member(form(walked, _), Forms)),
    assertion(member(form(walking, _), Forms)).

test(generate_irregular_english_paradigm) :-
    morphoscope:paradigm(en, go, Forms),
    assertion(member(form(goes, _), Forms)),
    assertion(member(form(went, _), Forms)),
    assertion(member(form(gone, _), Forms)),
    assertion(member(form(going, _), Forms)).

test(generate_be_tracks_person_and_number) :-
    morphoscope:generate(en, be, are, Features),
    assertion(Features.person == second),
    assertion(Features.number == singular).

test(analyze_regular_spanish) :-
    morphoscope:analyze(es, hablé, Lemma, Features),
    assertion(Lemma == hablar),
    assertion(Features.form == preterite),
    assertion(Features.person == first),
    assertion(Features.number == singular).

test(generate_regular_spanish_paradigm) :-
    morphoscope:paradigm(es, hablar, Forms),
    length(Forms, Count),
    assertion(Count == 21),
    assertion(member(form(hablo, _), Forms)),
    assertion(member(form(hablamos, _), Forms)),
    assertion(member(form(hablando, _), Forms)),
    assertion(member(form(hablado, _), Forms)).

test(analyze_irregular_spanish_is_ambiguous) :-
    findall(Lemma, morphoscope:analyze(es, fue, Lemma, _), Lemmas0),
    sort(Lemmas0, Lemmas),
    assertion(Lemmas == [ir, ser]).

test(generate_irregular_spanish) :-
    morphoscope:generate(es, ser, soy, Features),
    assertion(Features.form == present),
    assertion(Features.person == first),
    assertion(Features.number == singular),
    morphoscope:generate(es, ser, siendo, GerundFeatures),
    assertion(GerundFeatures.form == gerund),
    morphoscope:generate(es, leer, leyendo, _),
    morphoscope:generate(es, leer, leído, _).

test(unknown_lemma_does_not_generate, [fail]) :-
    morphoscope:generate(en, unknownverb, _, _).

test(unknown_form_does_not_analyze, [fail]) :-
    morphoscope:analyze(es, desconocido, _, _).

:- end_tests(morphoscope).