# Twitter text frequencies

This data was provided by the [Rovereto Twitter N-Gram Corpus](http://clic.cimec.unitn.it/amac/twitter_ngram/) project.

The Rovereto corpus is under a [Creative Commons license](https://creativecommons.org/licenses/by-nc-sa/3.0/), but the data below are (1) facts and (2) significantly altered from the corpus.

Totals are based on summing the frequencies.

Number of unigrams: 100,000
Number of bigrams:  100,000

```bash
> cat total.tsv
1174595007

> cat 2_total.tsv
1036122317

> head frequencies.tsv
.	110795054
!	49216653
'	38927876
I	37374980
:	36649714
,	32404355
the	30650094
to	30124217
RT	24925489
a	24016069

> tail frequencies.tsv
Pixi	279
Petrino	279
Pellegrino	279
Patric	279
Parkland	279
Pairings	279
PQ	279
Oppression	279
OovoO	279
Olyphant	279

> head 2_frequencies.tsv
. .	34454621
. <<boundary>>	14409849
! !	11726524
<<boundary>> RT	10605497
! <<boundary>>	8135086
' s	7004194
' t	5603950
I '	4986820
<<boundary>> I	4244443
' m	4073944

> tail 2_frequencies.tsv
lol gotta	916
late lunch	916
is takin	916
in size	916
if Rebecca	916
high hopes	916
gym time	916
glad someone	916
game 5	916
fuk it	916
```
