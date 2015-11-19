Require Export UniMath.Ktheory.InitialAndFinalObject UniMath.Ktheory.Elements.
Require Import UniMath.Ktheory.Precategories.

Local Open Scope cat.

Definition Representation {C:Precategory} (X:C==>SET) := InitialObject (Elements.cat X).

Definition isRepresentable {C:Precategory} (X:C==>SET) := ∥ Representation X ∥.

Definition Object {C:Precategory} {X:C==>SET} (r:Representation X) : C.
Proof.
  intros.
  exact (get_ob (theInitialObject r)).
Defined.

Definition Element {C:Precategory} {X:C==>SET} (r:Representation X) : set_to_type (X (Object r)).
Proof.
  intros.
  exact (get_el (theInitialObject r)).
Defined.

Definition universalProperty {C:Precategory} {X:C==>SET} (r:Representation X) (c:C) :
  Object r → c ≃ set_to_type (X c).
Proof.
  intros.
  exists (λ f, # X f (Element r)).
  exact (λ x, theInitialProperty r (c,, x)).
Defined.

Definition objectMap {C:Precategory} {X X':C==>SET} (r:Representation X) (r':Representation X')
           (p : X ⟶ X') : Object r' → Object r.
Proof.
  intros.
  exact (get_mor (thePoint (theInitialProperty r' (cat_on_nat_trans p (theInitialObject r))))).
Defined.

Definition objectMapUniqueness {C:Precategory} {X X':C==>SET} (r:Representation X) (r':Representation X') (p : X ⟶ X')
           (f : get_ob (theInitialObject r') → get_ob (theInitialObject r))
           (e : # X' f (get_el (theInitialObject r')) = get_el (cat_on_nat_trans p (theInitialObject r)))
  : f = objectMap r r' p
  := maponpaths get_mor (uniqueness (theInitialProperty r' (cat_on_nat_trans p (theInitialObject r))) (f,,e)).

Definition objectMapIdentity {C:Precategory} {X:C==>SET} (r:Representation X) :
  objectMap r r (nat_trans_id X) = identity (Object r)
  := maponpaths
       get_mor
       (theInitialIdentity r
          (thePoint
             (theInitialProperty
                r (cat_on_nat_trans (nat_trans_id X) (theInitialObject r))))).
