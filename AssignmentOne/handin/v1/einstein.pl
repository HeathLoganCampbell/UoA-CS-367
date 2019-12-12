:- use_module(library(lists)).  %% to load permutation/2 no idea what this does
/*
NAME: Heath Logan Campbell
UPI: HCAM630

Hints:
* the Brit lives in the red house
* the Swede keeps dogs as pets
* the Dane drinks tea
* the green house is on the left of the white house
* the green house’s owner drinks coffee
* the person who smokes Pall Mall rears birds
* the owner of the yellow house smokes Dunhill
* the man living in the center house drinks milk
* the Norwegian lives in the first house
* the man who smokes blends lives next to the one who keeps cats
* the man who keeps horses lives next to the man who smokes Dunhill
* the owner who smokes BlueMaster drinks beer
* the German smokes Prince
* the Norwegian lives next to the blue house
* the man who smokes blend has a neighbor who drinks water

Pets
* cats
* dogs
* horses
* birds
* fish

Drinks
* Tea
* Coffee
* Milk
* Beer
* Water

Houses
* Red
* Green
* White
* Yellow
* Blue

Nationality
* Norwegian
* Brit
* Swede
* Dane
* German

Cigar
* Pallmall
* Dunhill
* Blends
* BlueMaster
* Prince
*/
solution(Persons) :-
  /* We need a way to tell the houses order so we can get what ones are next to each other */
  Persons = [
     personObj(1, Nat1, Color1, Pet1, Drinks1, Smokes1),
     personObj(2, Nat2, Color2, Pet2, Drinks2, Smokes2),
     personObj(3, Nat3, Color3, Pet3, Drinks3, Smokes3),
     personObj(4, Nat4, Color4, Pet4, Drinks4, Smokes4),
     personObj(5, Nat5, Color5, Pet5, Drinks5, Smokes5)
  ],
  /* Hints */
  /* the Brit lives in the red house */
  member(personObj(_, brit, red, _, _, _), Persons),
  /* the Swede keeps dogs as pets */
  member(personObj(_, swede, _, dogs, _, _  ), Persons),
  /* the Dane drinks tea */
  member(personObj(_, dane, _, _, tea, _), Persons),
   /* the green house is on the left of the white house */
  member(personObj(A, _, green, _, _, _), Persons),
  member(personObj(B, _, white, _, _, _), Persons),
  left_of(A, B),
  /* the green house’s owner drinks coffee */
  member(personObj(_, _, green, _, coffee, _  ), Persons),
  /* the person who smokes Pall Mall rears birds */
  member(personObj(_, _, _, birds, _, pall_mall), Persons),
  /* the owner of the yellow house smokes Dunhill */
  member(personObj(_, _, yellow, _, _, dunhill), Persons),
  /* the man living in the center house drinks milk */
  member(personObj(3, _, _, _, milk, _), Persons),
  /* the Norwegian lives in the first house */
  member(personObj(1, norweigan, _, _, _, _), Persons),
  /* the man who smokes blends lives next to the one who keeps cats */
  member(personObj(C, _, _, _, _, blend), Persons),
  member(personObj(D, _, _, cats, _, _), Persons),
  next_to(C, D),
  /* the man who keeps horses lives next to the man who smokes Dunhill */
  member(personObj(E, _, _, horses, _, _  ), Persons),
  member(personObj(F, _, _, _, _, dunhill   ), Persons),
  next_to(E, F),
  /* the German smokes Prince */
  member(personObj(_, german, _, _, _, prince  ), Persons),
  /* the owner who smokes BlueMaster drinks beer */
	member(personObj(_, _, _, _, beer, bluemaster ), Persons),
  /* the Norwegian lives next to the blue house */
  member(personObj(G, norweigan, _, _, _, _), Persons),
  member(personObj(H, _, blue, _, _, _), Persons),
  next_to(G, H),
  /* the man who smokes blend has a neighbor who drinks water */
  member(personObj(I, _, _, _, _, blend), Persons),
  member(personObj(J, _, _, _, water, _), Persons),
  next_to(I, J),
  /* WHO OWNS THAT FISH BOI?! */
  member(personObj(_, FishOwner, _, fish, _, _), Persons).

ownerOfFish(Persons, FishOwner) :-
  member(personObj(_, FishOwner, _, fish, _, _), Persons).

/* Use ids to date the left and right person */
right_of(A, B) :- 
  A is B + 1.
left_of(A, B) :- 
  A is B - 1.

/* They could be to the left or right of the other person */
next_to(A, B) :- 
  right_of(A, B).
next_to(A, B) :- 
  left_of(A, B).