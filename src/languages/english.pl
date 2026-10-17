:- module(morphoscope_english,
          [ known_lemma/1,
            inflection/3,
            lexicon_size/1
          ]).

:- use_module(library(lists), [append/3, member/2, memberchk/2]).

regular_lemma(Lemma) :-
    member(Lemma,
           [ accept, achieve, admire, allow, answer, appear, apply, argue,
             arrive, ask, attach, avoid, bake, balance, behave, believe,
             belong, borrow, breathe, call, cancel, care, carry, change,
             charge, check, clean, clear, climb, close, collect, compare,
             complain, complete, confirm, connect, consider, continue, cook,
             copy, correct, count, cover, create, cry, dance, decide, deliver,
             depend, describe, develop, die, discover, discuss, dress, drop,
             earn, educate, encourage, end, enjoy, enter, escape, examine,
             exist, expect, explain, face, fail, fill, finish, fix, follow,
             identify, imagine, improve, include, increase, invite, jump, kill,
             laugh, like, limit, link, listen, live, look, love, manage, mark,
             match, miss, move, name, need, notice, offer, open, order, produce,
             promise, protect, provide, pull, push, reach, receive, reduce,
             refuse, remember, repeat, replace, reply, report, require, rest,
             return, save, search, serve, share, shop, smile, solve, start, stay,
             step, stop, study, suggest, support, talk, taste, test, thank,
             touch, train, treat, try, turn, use, visit, wait, walk, want, wash,
             watch, wave, wish, work, wrap, zoom
           ]).
double_final_lemma(shop).
double_final_lemma(stop).
double_final_lemma(wrap).


english_irregular(have, has, had, had, having).
english_irregular(do, does, did, done, doing).
english_irregular(go, goes, went, gone, going).
english_irregular(say, says, said, said, saying).
english_irregular(make, makes, made, made, making).
english_irregular(take, takes, took, taken, taking).
english_irregular(come, comes, came, come, coming).
english_irregular(see, sees, saw, seen, seeing).
english_irregular(know, knows, knew, known, knowing).
english_irregular(get, gets, got, got, getting).
english_irregular(give, gives, gave, given, giving).
english_irregular(find, finds, found, found, finding).
english_irregular(think, thinks, thought, thought, thinking).
english_irregular(tell, tells, told, told, telling).
english_irregular(become, becomes, became, become, becoming).
english_irregular(show, shows, showed, shown, showing).
english_irregular(leave, leaves, left, left, leaving).
english_irregular(feel, feels, felt, felt, feeling).
english_irregular(put, puts, put, put, putting).
english_irregular(bring, brings, brought, brought, bringing).
english_irregular(begin, begins, began, begun, beginning).
english_irregular(keep, keeps, kept, kept, keeping).
english_irregular(hold, holds, held, held, holding).
english_irregular(write, writes, wrote, written, writing).
english_irregular(stand, stands, stood, stood, standing).
english_irregular(hear, hears, heard, heard, hearing).
english_irregular(let, lets, let, let, letting).
english_irregular(mean, means, meant, meant, meaning).
english_irregular(set, sets, set, set, setting).
english_irregular(meet, meets, met, met, meeting).
english_irregular(run, runs, ran, run, running).
english_irregular(pay, pays, paid, paid, paying).
english_irregular(sit, sits, sat, sat, sitting).
english_irregular(speak, speaks, spoke, spoken, speaking).
english_irregular(lead, leads, led, led, leading).
english_irregular(read, reads, read, read, reading).
english_irregular(grow, grows, grew, grown, growing).
english_irregular(lose, loses, lost, lost, losing).
english_irregular(fall, falls, fell, fallen, falling).
english_irregular(send, sends, sent, sent, sending).
english_irregular(build, builds, built, built, building).
english_irregular(understand, understands, understood, understood, understanding).
english_irregular(draw, draws, drew, drawn, drawing).
english_irregular(break, breaks, broke, broken, breaking).
english_irregular(spend, spends, spent, spent, spending).
english_irregular(cut, cuts, cut, cut, cutting).
english_irregular(rise, rises, rose, risen, rising).
english_irregular(drive, drives, drove, driven, driving).
english_irregular(buy, buys, bought, bought, buying).
english_irregular(wear, wears, wore, worn, wearing).
english_irregular(choose, chooses, chose, chosen, choosing).
english_irregular(eat, eats, ate, eaten, eating).
english_irregular(drink, drinks, drank, drunk, drinking).
english_irregular(sleep, sleeps, slept, slept, sleeping).
english_irregular(win, wins, won, won, winning).
english_irregular(teach, teaches, taught, taught, teaching).
english_irregular(catch, catches, caught, caught, catching).
english_irregular(sell, sells, sold, sold, selling).
english_irregular(fight, fights, fought, fought, fighting).
english_irregular(throw, throws, threw, thrown, throwing).
english_irregular(forget, forgets, forgot, forgotten, forgetting).
english_irregular(fly, flies, flew, flown, flying).
english_irregular(ride, rides, rode, ridden, riding).
english_irregular(swim, swims, swam, swum, swimming).
english_irregular(sing, sings, sang, sung, singing).
english_irregular(ring, rings, rang, rung, ringing).
english_irregular(shake, shakes, shook, shaken, shaking).
english_irregular(steal, steals, stole, stolen, stealing).
english_irregular(tear, tears, tore, torn, tearing).
english_irregular(wake, wakes, woke, woken, waking).

known_lemma(be).
known_lemma(Lemma) :- regular_lemma(Lemma).
known_lemma(Lemma) :- english_irregular(Lemma, _, _, _, _).

lexicon_size(Count) :-
    findall(Lemma, known_lemma(Lemma), Lemmas),
    sort(Lemmas, Unique),
    length(Unique, Count).

inflection(Lemma, Form, Features) :-
    english_slot(Slot, Features),
    irregular_form(Lemma, Slot, Form).
inflection(Lemma, Form, Features) :-
    regular_lemma(Lemma),
    english_slot(Slot, Features),
    regular_form(Lemma, Slot, Form).

english_slot(infinitive,
             features{form:infinitive, mood:infinitive, tense:present}).
english_slot(present(Person, Number),
             features{form:present, mood:indicative, number:Number,
                      person:Person, tense:present}) :-
    person_number(Person, Number).
english_slot(past(Person, Number),
             features{form:past, mood:indicative, number:Number,
                      person:Person, tense:past}) :-
    person_number(Person, Number).
english_slot(past_participle,
             features{form:past_participle, mood:participle, tense:past}).
english_slot(gerund,
             features{form:gerund, mood:participle, tense:present}).

person_number(first, singular).
person_number(second, singular).
person_number(third, singular).
person_number(first, plural).
person_number(second, plural).
person_number(third, plural).

regular_form(Lemma, infinitive, Lemma).
regular_form(Lemma, present(third, singular), Form) :-
    third_person_form(Lemma, Form).
regular_form(Lemma, present(Person, Number), Lemma) :-
    person_number(Person, Number),
    \+ (Person = third, Number = singular).
regular_form(Lemma, past(_, _), Form) :-
    past_form(Lemma, Form).
regular_form(Lemma, past_participle, Form) :-
    past_form(Lemma, Form).
regular_form(Lemma, gerund, Form) :-
    gerund_form(Lemma, Form).

irregular_form(be, infinitive, be).
irregular_form(be, present(first, singular), am).
irregular_form(be, present(second, singular), are).
irregular_form(be, present(third, singular), is).
irregular_form(be, present(first, plural), are).
irregular_form(be, present(second, plural), are).
irregular_form(be, present(third, plural), are).
irregular_form(be, past(first, singular), was).
irregular_form(be, past(second, singular), were).
irregular_form(be, past(third, singular), was).
irregular_form(be, past(first, plural), were).
irregular_form(be, past(second, plural), were).
irregular_form(be, past(third, plural), were).
irregular_form(be, past_participle, been).
irregular_form(be, gerund, being).
irregular_form(Lemma, infinitive, Lemma) :-
    english_irregular(Lemma, _, _, _, _).
irregular_form(Lemma, present(third, singular), Form) :-
    english_irregular(Lemma, Form, _, _, _).
irregular_form(Lemma, present(Person, Number), Lemma) :-
    english_irregular(Lemma, _, _, _, _),
    person_number(Person, Number),
    \+ (Person = third, Number = singular).
irregular_form(Lemma, past(_, _), Form) :-
    english_irregular(Lemma, _, Form, _, _).
irregular_form(Lemma, past_participle, Form) :-
    english_irregular(Lemma, _, _, Form, _).
irregular_form(Lemma, gerund, Form) :-
    english_irregular(Lemma, _, _, _, Form).

third_person_form(Lemma, Form) :-
    consonant_final_y(Lemma), !,
    replace_suffix(Lemma, y, ies, Form).
third_person_form(Lemma, Form) :-
    memberchk(Suffix, [s, x, z, ch, sh, o]),
    ends_with(Lemma, Suffix), !,
    atom_concat(Lemma, es, Form).
third_person_form(Lemma, Form) :-
    atom_concat(Lemma, s, Form).

past_form(Lemma, Form) :-
    consonant_final_y(Lemma), !,
    replace_suffix(Lemma, y, ied, Form).
past_form(Lemma, Form) :-
    ends_with(Lemma, e), !,
    atom_concat(Lemma, d, Form).
past_form(Lemma, Form) :-
    double_final_lemma(Lemma), !,
    double_final(Lemma, Doubled),
    atom_concat(Doubled, ed, Form).
past_form(Lemma, Form) :-
    atom_concat(Lemma, ed, Form).

gerund_form(Lemma, Form) :-
    ends_with(Lemma, ie), !,
    replace_suffix(Lemma, ie, ying, Form).
gerund_form(Lemma, Form) :-
    ends_with(Lemma, e),
    \+ ends_with(Lemma, ee), !,
    remove_suffix(Lemma, e, Stem),
    atom_concat(Stem, ing, Form).
gerund_form(Lemma, Form) :-
    double_final_lemma(Lemma), !,
    double_final(Lemma, Doubled),
    atom_concat(Doubled, ing, Form).
gerund_form(Lemma, Form) :-
    atom_concat(Lemma, ing, Form).

consonant_final_y(Word) :-
    atom_chars(Word, Chars),
    append(_, [Before, y], Chars),
    \+ memberchk(Before, [a, e, i, o, u]).

ends_with(Word, Suffix) :-
    atom_chars(Word, WordChars),
    atom_chars(Suffix, SuffixChars),
    append(_, SuffixChars, WordChars).

replace_suffix(Word, Old, New, Result) :-
    atom_chars(Word, WordChars),
    atom_chars(Old, OldChars),
    append(Prefix, OldChars, WordChars),
    atom_chars(New, NewChars),
    append(Prefix, NewChars, ResultChars),
    atom_chars(Result, ResultChars).

remove_suffix(Word, Suffix, Stem) :-
    atom_chars(Word, WordChars),
    atom_chars(Suffix, SuffixChars),
    append(StemChars, SuffixChars, WordChars),
    atom_chars(Stem, StemChars).

double_final(Word, Doubled) :-
    atom_chars(Word, Chars),
    append(Prefix, [Last], Chars),
    append(Prefix, [Last, Last], DoubledChars),
    atom_chars(Doubled, DoubledChars).