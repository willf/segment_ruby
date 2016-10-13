# Google Book text frequencies

This data was provided by [Google Books](http://storage.googleapis.com/books/ngrams/books/datasetsv2.html).
All parts of speech were stripped from the data, and both unigram and bigram
data are used. Version 20120701 of the data was used.

Totals for unigrams and bigrams were taken from summing the frequencies.

Number of unigrams: 333,333
Number of bigrams: 250,000

```bash
> cat total.tsv
468285774779
> cat 2_total.tsv
431675447550

> head frequencies.tsv
,	27957346221
the	23688414489
.	19194317252
of	15342397280
and	11021132912
to	9494905988
in	7611765281
a	7083003595
"	4430963121
is	4139526351

> tail frequencies.tsv
1865-1914	10817
seditiously	10816
party.2	10816
gymkhana	10816
guttersnipe	10816
emb	10816
camptothecin	10816
OHMS	10816
Mikroskop	10816
Hashi	10816

> head 2_frequencies.tsv
of	the	4090128330
,	and	2800837645
in	the	2053960926
,	the	1364701650
to	the	1358602774
and	the	894974339
,	"	792712997
on	the	769237885
)	.	693102993
.	"	686861045

> tail 2_frequencies.tsv
epidermal	cells	165072
's	suicide	165072
-	radiation	165071
the	Governing	165070
such	phrases	165070
lag	.	165070
include	these	165070
detachments	of	165070
radar	.	165069
employed	are	165069
```
