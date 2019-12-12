/* knowledge base */
female(sara).
female(sue).
female(zoe).
female(anna).
female(isabelle).
female(helen).

parentOf(helen, isabelle).
parentOf(kerry, isabelle).

parentOf(helen, anna).
parentOf(jeffy, anna).

/* Function */
half_sister_of(I,A) :-
  parentOf(Z, I), parentOf(Z, A), female(I), (parentOf(X, I),  parentOf(W, A)), not(Z = X), not(X = W), not(Z = W).