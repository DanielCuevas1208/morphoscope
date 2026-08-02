:- encoding(utf8).

:- module(morphoscope_spanish,
          [ known_lemma/1,
            inflection/3,
            lexicon_size/1
          ]).

:- use_module(library(lists), [append/3, member/2, nth1/3]).

regular_lemma(hablar, ar).
regular_lemma(bailar, ar).
regular_lemma(cantar, ar).
regular_lemma(caminar, ar).
regular_lemma(comprar, ar).
regular_lemma(cocinar, ar).
regular_lemma(entrar, ar).
regular_lemma(escuchar, ar).
regular_lemma(estudiar, ar).
regular_lemma(trabajar, ar).
regular_lemma(viajar, ar).
regular_lemma(mirar, ar).
regular_lemma(necesitar, ar).
regular_lemma(preparar, ar).
regular_lemma(terminar, ar).
regular_lemma(usar, ar).
regular_lemma(visitar, ar).
regular_lemma(comer, er).
regular_lemma(beber, er).
regular_lemma(aprender, er).
regular_lemma(correr, er).
regular_lemma(deber, er).
regular_lemma(vender, er).
regular_lemma(responder, er).
regular_lemma(comprender, er).
regular_lemma(vivir, ir).
regular_lemma(recibir, ir).
regular_lemma(decidir, ir).
regular_lemma(partir, ir).
regular_lemma(subir, ir).
regular_lemma(existir, ir).
regular_lemma(permitir, ir).
regular_lemma(compartir, ir).

% Each entry stores the six persons in first singular through third plural order.
spanish_irregular(ser,
                  [present-[soy, eres, es, somos, sois, son],
                   preterite-[fui, fuiste, fue, fuimos, fuisteis, fueron],
                   imperfect-[era, eras, era, éramos, erais, eran]],
                  siendo, sido).
spanish_irregular(estar,
                  [present-[estoy, estás, está, estamos, estáis, están],
                   preterite-[estuve, estuviste, estuvo, estuvimos, estuvisteis, estuvieron],
                   imperfect-[estaba, estabas, estaba, estábamos, estabais, estaban]],
                  estando, estado).
spanish_irregular(ir,
                  [present-[voy, vas, va, vamos, vais, van],
                   preterite-[fui, fuiste, fue, fuimos, fuisteis, fueron],
                   imperfect-[iba, ibas, iba, íbamos, ibais, iban]],
                  yendo, ido).
spanish_irregular(tener,
                  [present-[tengo, tienes, tiene, tenemos, tenéis, tienen],
                   preterite-[tuve, tuviste, tuvo, tuvimos, tuvisteis, tuvieron],
                   imperfect-[tenía, tenías, tenía, teníamos, teníais, tenían]],
                  teniendo, tenido).
spanish_irregular(hacer,
                  [present-[hago, haces, hace, hacemos, hacéis, hacen],
                   preterite-[hice, hiciste, hizo, hicimos, hicisteis, hicieron],
                   imperfect-[hacía, hacías, hacía, hacíamos, hacíais, hacían]],
                  haciendo, hecho).
spanish_irregular(decir,
                  [present-[digo, dices, dice, decimos, decís, dicen],
                   preterite-[dije, dijiste, dijo, dijimos, dijisteis, dijeron],
                   imperfect-[decía, decías, decía, decíamos, decíais, decían]],
                  diciendo, dicho).
spanish_irregular(poder,
                  [present-[puedo, puedes, puede, podemos, podéis, pueden],
                   preterite-[pude, pudiste, pudo, pudimos, pudisteis, pudieron],
                   imperfect-[podía, podías, podía, podíamos, podíais, podían]],
                  pudiendo, podido).
spanish_irregular(poner,
                  [present-[pongo, pones, pone, ponemos, ponéis, ponen],
                   preterite-[puse, pusiste, puso, pusimos, pusisteis, pusieron],
                   imperfect-[ponía, ponías, ponía, poníamos, poníais, ponían]],
                  poniendo, puesto).
spanish_irregular(venir,
                  [present-[vengo, vienes, viene, venimos, venís, vienen],
                   preterite-[vine, viniste, vino, vinimos, vinisteis, vinieron],
                   imperfect-[venía, venías, venía, veníamos, veníais, venían]],
                  viniendo, venido).
spanish_irregular(saber,
                  [present-[sé, sabes, sabe, sabemos, sabéis, saben],
                   preterite-[supe, supiste, supo, supimos, supisteis, supieron],
                   imperfect-[sabía, sabías, sabía, sabíamos, sabíais, sabían]],
                  sabiendo, sabido).
spanish_irregular(querer,
                  [present-[quiero, quieres, quiere, queremos, queréis, quieren],
                   preterite-[quise, quisiste, quiso, quisimos, quisisteis, quisieron],
                   imperfect-[quería, querías, quería, queríamos, queríais, querían]],
                  queriendo, querido).
spanish_irregular(dar,
                  [present-[doy, das, da, damos, dais, dan],
                   preterite-[di, diste, dio, dimos, disteis, dieron],
                   imperfect-[daba, dabas, daba, dábamos, dabais, daban]],
                  dando, dado).
spanish_irregular(ver,
                  [present-[veo, ves, ve, vemos, veis, ven],
                   preterite-[vi, viste, vio, vimos, visteis, vieron],
                   imperfect-[veía, veías, veía, veíamos, veíais, veían]],
                  viendo, visto).
spanish_irregular(salir,
                  [present-[salgo, sales, sale, salimos, salís, salen],
                   preterite-[salí, saliste, salió, salimos, salisteis, salieron],
                   imperfect-[salía, salías, salía, salíamos, salíais, salían]],
                  saliendo, salido).
spanish_irregular(traer,
                  [present-[traigo, traes, trae, traemos, traéis, traen],
                   preterite-[traje, trajiste, trajo, trajimos, trajisteis, trajeron],
                   imperfect-[traía, traías, traía, traíamos, traíais, traían]],
                  trayendo, traído).

spanish_irregular(abrir,
                  [present-[abro, abres, abre, abrimos, abrís, abren],
                   preterite-[abrí, abriste, abrió, abrimos, abristeis, abrieron],
                   imperfect-[abría, abrías, abría, abríamos, abríais, abrían]],
                  abriendo, abierto).
spanish_irregular(escribir,
                  [present-[escribo, escribes, escribe, escribimos, escribís, escriben],
                   preterite-[escribí, escribiste, escribió, escribimos, escribisteis, escribieron],
                   imperfect-[escribía, escribías, escribía, escribíamos, escribíais, escribían]],
                  escribiendo, escrito).
spanish_irregular(leer,
                  [present-[leo, lees, lee, leemos, leéis, leen],
                   preterite-[leí, leíste, leyó, leímos, leísteis, leyeron],
                   imperfect-[leía, leías, leía, leíamos, leíais, leían]],
                  leyendo, leído).
known_lemma(Lemma) :- regular_lemma(Lemma, _).
known_lemma(Lemma) :- spanish_irregular(Lemma, _, _, _).

lexicon_size(Count) :-
    findall(Lemma, known_lemma(Lemma), Lemmas),
    sort(Lemmas, Unique),
    length(Unique, Count).

inflection(Lemma, Form, Features) :-
    spanish_slot(Slot, Features),
    irregular_form(Lemma, Slot, Form).
inflection(Lemma, Form, Features) :-
    regular_lemma(Lemma, Class),
    spanish_slot(Slot, Features),
    regular_form(Lemma, Class, Slot, Form).

spanish_slot(infinitive,
             features{form:infinitive, mood:infinitive, tense:present}).
spanish_slot(present(Person, Number),
             features{form:present, mood:indicative, number:Number,
                      person:Person, tense:present}) :-
    person_number(Person, Number).
spanish_slot(preterite(Person, Number),
             features{form:preterite, mood:indicative, number:Number,
                      person:Person, tense:past}) :-
    person_number(Person, Number).
spanish_slot(imperfect(Person, Number),
             features{form:imperfect, mood:indicative, number:Number,
                      person:Person, tense:past}) :-
    person_number(Person, Number).
spanish_slot(gerund,
             features{form:gerund, mood:participle, tense:present}).
spanish_slot(past_participle,
             features{form:past_participle, mood:participle, tense:past}).

person_number(first, singular).
person_number(second, singular).
person_number(third, singular).
person_number(first, plural).
person_number(second, plural).
person_number(third, plural).

regular_form(Lemma, _, infinitive, Lemma).
regular_form(Lemma, Class, present(Person, Number), Form) :-
    stem(Lemma, Class, Stem),
    present_ending(Class, Person, Number, Ending),
    atom_concat(Stem, Ending, Form).
regular_form(Lemma, Class, preterite(Person, Number), Form) :-
    stem(Lemma, Class, Stem),
    preterite_ending(Class, Person, Number, Ending),
    atom_concat(Stem, Ending, Form).
regular_form(Lemma, Class, imperfect(Person, Number), Form) :-
    stem(Lemma, Class, Stem),
    imperfect_ending(Class, Person, Number, Ending),
    atom_concat(Stem, Ending, Form).
regular_form(Lemma, ar, gerund, Form) :-
    stem(Lemma, ar, Stem), atom_concat(Stem, ando, Form).
regular_form(Lemma, Class, gerund, Form) :-
    member(Class, [er, ir]),
    stem(Lemma, Class, Stem), atom_concat(Stem, iendo, Form).
regular_form(Lemma, ar, past_participle, Form) :-
    stem(Lemma, ar, Stem), atom_concat(Stem, ado, Form).
regular_form(Lemma, Class, past_participle, Form) :-
    member(Class, [er, ir]),
    stem(Lemma, Class, Stem), atom_concat(Stem, ido, Form).

present_ending(ar, first, singular, o).
present_ending(ar, second, singular, as).
present_ending(ar, third, singular, a).
present_ending(ar, first, plural, amos).
present_ending(ar, second, plural, áis).
present_ending(ar, third, plural, an).
present_ending(er, first, singular, o).
present_ending(er, second, singular, es).
present_ending(er, third, singular, e).
present_ending(er, first, plural, emos).
present_ending(er, second, plural, éis).
present_ending(er, third, plural, en).
present_ending(ir, first, singular, o).
present_ending(ir, second, singular, es).
present_ending(ir, third, singular, e).
present_ending(ir, first, plural, imos).
present_ending(ir, second, plural, ís).
present_ending(ir, third, plural, en).

preterite_ending(ar, first, singular, é).
preterite_ending(ar, second, singular, aste).
preterite_ending(ar, third, singular, ó).
preterite_ending(ar, first, plural, amos).
preterite_ending(ar, second, plural, asteis).
preterite_ending(ar, third, plural, aron).
preterite_ending(Class, first, singular, í) :- member(Class, [er, ir]).
preterite_ending(Class, second, singular, iste) :- member(Class, [er, ir]).
preterite_ending(Class, third, singular, ió) :- member(Class, [er, ir]).
preterite_ending(Class, first, plural, imos) :- member(Class, [er, ir]).
preterite_ending(Class, second, plural, isteis) :- member(Class, [er, ir]).
preterite_ending(Class, third, plural, ieron) :- member(Class, [er, ir]).

imperfect_ending(ar, first, singular, aba).
imperfect_ending(ar, second, singular, abas).
imperfect_ending(ar, third, singular, aba).
imperfect_ending(ar, first, plural, ábamos).
imperfect_ending(ar, second, plural, abais).
imperfect_ending(ar, third, plural, aban).
imperfect_ending(Class, first, singular, ía) :- member(Class, [er, ir]).
imperfect_ending(Class, second, singular, ías) :- member(Class, [er, ir]).
imperfect_ending(Class, third, singular, ía) :- member(Class, [er, ir]).
imperfect_ending(Class, first, plural, íamos) :- member(Class, [er, ir]).
imperfect_ending(Class, second, plural, íais) :- member(Class, [er, ir]).
imperfect_ending(Class, third, plural, ían) :- member(Class, [er, ir]).

stem(Lemma, Class, Stem) :-
    atom_chars(Class, ClassChars),
    atom_chars(Lemma, LemmaChars),
    append(StemChars, ClassChars, LemmaChars),
    atom_chars(Stem, StemChars).

irregular_form(Lemma, infinitive, Lemma) :-
    spanish_irregular(Lemma, _, _, _).
irregular_form(Lemma, present(Person, Number), Form) :-
    irregular_slot(Lemma, present, Person, Number, Form).
irregular_form(Lemma, preterite(Person, Number), Form) :-
    irregular_slot(Lemma, preterite, Person, Number, Form).
irregular_form(Lemma, imperfect(Person, Number), Form) :-
    irregular_slot(Lemma, imperfect, Person, Number, Form).
irregular_form(Lemma, gerund, Form) :-
    spanish_irregular(Lemma, _, Form, _).
irregular_form(Lemma, past_participle, Form) :-
    spanish_irregular(Lemma, _, _, Form).

irregular_slot(Lemma, Tense, Person, Number, Form) :-
    spanish_irregular(Lemma, Tenses, _, _),
    member(Tense-Forms, Tenses),
    person_index(Person, Number, Index),
    nth1(Index, Forms, Form).

person_index(first, singular, 1).
person_index(second, singular, 2).
person_index(third, singular, 3).
person_index(first, plural, 4).
person_index(second, plural, 5).
person_index(third, plural, 6).