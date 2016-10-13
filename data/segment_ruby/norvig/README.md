# Peter norvig text frequencies

This data was provided by [Peter Norvig](http://norvig.com/ngrams/) based on his book,
[Beautiful Data](http://shop.oreilly.com/product/9780596157128.do).

His code is under copyright, but not the data.

Totals for unigrams were given by Novig. Totals for bigrams were taken by summing the frequencies.

Number of unigrams: 333,333
Number of bigrams: 286,358

```bash
> cat total.tsv
1024908267229
> cat 2_total.tsv
225955251755

> head frequencies.tsv
the	23135851162
of	13151942776
and	12997637966
to	12136980858
a	9081174698
in	8469404971
for	5933321709
is	4705743816
on	3750423199

> tail frequencies.tsv
googllr	12711
googlal	12711
googgoo	12711
googgol	12711
goofel	12711
gooek	12711
gooddg	12711
gooblle	12711
gollgo	12711
golgw	12711

> head 2_frequencies.tsv
of the	2766332391
in the	1628795324
to the	1139248999
on the	800328815
for the	692874802
and the	629726893
to be	505148997
is a	476718990
with the	461331348
from the	428303219

> tail 2_frequencies.tsv
floral gifts	100004
enough already	100003
University shall	100003
map maps	100002
final week	100002
capture this	100002
Greece is	100002
winning service	100001
some estimates	100001
also helping	100000
```
