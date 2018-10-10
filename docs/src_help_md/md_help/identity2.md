---
title: '==/2'
predicates:
 - '==/2' : terms are identical
 - '\==/2' : terms are not identical
---
`==/2` `--` terms are identical

`\==/2` `--` terms are not identical


## FORMS

Term1 = = Term2

Term1 \ = = Term2


## DESCRIPTION

Term1 is identical to Term2(Term1 = = Term2) if they can be unified, and variables occupying equivalent positions in both terms are identical. For atoms and variables, this is an absolute identity check. Viewing Prolog terms as trees in memory, = = / 2 determines whether Term1 and Term2 are isomorphic trees whose leaves are identical. Unlike = / 2, no variables are bound inside a call to
= = / 2 \ = = fails when = = succeeds, and conversely.


## EXAMPLES

```
?- bar\==foo.
yes.
```

```
?- f(b)==f(b).
yes.
```

```
?- X==Y.
no.
```

```
?- f(X)\==f(X).
no.
```

```
?- [a,b,c]\==[a,b,c].
no.
```


## SEE ALSO

- [Bowen 91, 7.4 ]
- [Clocksin 81, 6.8 ]
- [Bratko 86, 3.4 ]. 
