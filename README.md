# Morphoscope

Morphoscope is a small SWI-Prolog morphological analyzer for English and Spanish verbs.

It maps a word form to a lemma and grammatical features.
It also generates every supported form for a known lemma.

## Value

The project demonstrates bidirectional morphology in a compact, inspectable codebase.

The English lexicon contains 224 lemmas with regular and irregular entries.
The Spanish lexicon contains regular `-ar`, `-er`, and `-ir` verbs plus common irregular paradigms.

Ambiguous forms return multiple answers.
For example, `walked` can be a past form or a past participle.

## Architecture

- `morphoscope.pl` exposes the public API.
- `src/engine.pl` validates input and dispatches language operations.
- `src/languages/english.pl` stores English data and spelling rules.
- `src/languages/spanish.pl` stores Spanish data and conjugation rules.
- `bin/morphoscope.pl` provides a command-line demo.
- `test/test_morphoscope.pl` contains deterministic `plunit` tests.

Each answer uses a SWI-Prolog dict named `features`.
Finite forms include person, number, tense, mood, and form.

English supports these slots:

- infinitive;
- six present indicative person-number slots;
- six past indicative person-number slots;
- past participle;
- gerund.

Spanish supports these slots:

- infinitive;
- six present indicative person-number slots;
- six preterite indicative person-number slots;
- six imperfect indicative person-number slots;
- past participle;
- gerund.

Full paradigm means every slot implemented by the selected language rule set.

## Setup

Install SWI-Prolog 9.x or later.
Run commands from the repository root.

Check the installation:

```text
swipl --version
```

Run the test suite:

```text
swipl -q -f none -s test/test_morphoscope.pl -g run_tests -t halt
```

Run the command-line demo:

```text
swipl -q -s bin/morphoscope.pl -- analyze en walked
swipl -q -s bin/morphoscope.pl -- generate es hablar
swipl -q -s bin/morphoscope.pl -- paradigm en go
```

Use the library from a Prolog query:

```prolog
?- use_module(morphoscope).
?- analyze(en, went, Lemma, Features).
Lemma = go,
Features = features{form:past, mood:indicative, number:singular,
                    person:first, tense:past}.

?- paradigm(es, hablar, Forms).
```

## Sample output

The first command emits one answer for each compatible reading.
Output is shortened here.

```text
lemma=walk features=features{form:past,mood:indicative,number:singular,person:first,tense:past}
...
lemma=walk features=features{form:past_participle,mood:participle,tense:past}
```

A generation query emits surface forms with their features.

```text
form=hablar features=features{form:infinitive,mood:infinitive,tense:present}
form=hablo features=features{form:present,mood:indicative,number:singular,person:first,tense:present}
form=hablando features=features{form:gerund,mood:participle,tense:present}
form=hablado features=features{form:past_participle,mood:participle,tense:past}
```

## Test status

Tests cover regular and irregular analysis in both languages.
Tests cover English and Spanish paradigm generation.
CI installs SWI-Prolog and runs the suite on pushes and pull requests.
Local execution was unavailable for this release because `swipl` was absent from the environment.

## Limitations

The analyzer covers verbs only.
It does not infer unknown lemmas or use a corpus.
English spelling rules use curated exceptions and do not model dialect variants.
Spanish rules omit subjunctive, future, conditional, pronoun clitics, and regional variants.
Lexicons are hand-curated fixtures, not frequency lists.
An analysis does not provide confidence scores.

## License

Morphoscope is released under the MIT License.