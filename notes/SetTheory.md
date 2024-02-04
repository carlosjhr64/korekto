# Set theory

## [Zermelo–Fraenkel axioms](https://en.wikipedia.org/wiki/Zermelo-Fraenkel_set_theory)

* [Axiom of extensionality](https://en.wikipedia.org/wiki/Axiom_of_extensionality)
  * `∀𝑨 ∀𝑩 (∀𝑿 (𝑿∈𝑨 ⇔ 𝑿∈𝑩) ⇒ 𝑨=𝑩)`
* [Axiom of empty set](https://en.wikipedia.org/wiki/Axiom_of_empty_set)
  * `∃𝑨 ∀𝑿 (𝑿∉𝑨)`
* [Axiom of pairing](https://en.wikipedia.org/wiki/Axiom_of_pairing)
  * `∀𝑨 ∀𝑩 ∃𝑪 ∀𝑿 (𝑿∈𝑪 ⇔ (𝑿=𝑨 ∨ 𝑿=𝑩))`
* [Axiom of union](https://en.wikipedia.org/wiki/Axiom_of_union)
  * `∀𝑨 ∃𝑩 ∀𝑿 (𝑿∈𝑩 ⇔ ∃𝑪 (𝑿∈𝑪 ∧ 𝑪∈𝑨))`
* [Axiom of infinity](https://en.wikipedia.org/wiki/Axiom_of_infinity)
  * `∃𝑨 (∅∈𝑨 ∧ ∀𝑿 (𝑿∈𝑨 ⇒ (𝑿 ∪ {𝑿})∈𝑨))`
* [Axiom schema of replacement](https://en.wikipedia.org/wiki/Axiom_schema_of_replacement)
  * `∀𝑾 ∀𝑨 (∀𝑿 (𝑿∈𝑨 ⇒ ∃!𝒀 φ(𝑿,𝒀,𝑾,𝑨)) ⇒ ∃𝑩 ∀𝒀 (𝒀∈𝑩 ⇔ ∃𝑿 (𝑿∈A φ(𝑿,𝒀,𝑾,𝑨))))`
* [Axiom of power set](https://en.wikipedia.org/wiki/Axiom_of_power_set)
  * `∀𝑨 ∃𝑩 ∀𝑪 (𝑪∈𝑩 ⇔ ∀𝑿 (𝑿∈𝑪 ⇒ 𝑿∈𝑨))`
* [Axiom of regularity](https://en.wikipedia.org/wiki/Axiom_of_regularity)
  * `∀𝑨 (𝑨≠∅ ⇒ ∃𝑿 (𝑿∈𝑨 ∧ (𝑿 ∩ 𝑨)=∅))`
* [Axiom schema of specification](https://en.wikipedia.org/wiki/Axiom_schema_of_specification)
  * `∀𝑾 ∀𝑨 ∃𝑩 ∀𝑿 (𝑿∈𝑩 ⇔ (𝑿∈𝑨 ∧ φ(𝑿,𝑾,𝑨)))`

## Axiom of choice

* [Axiom of choice](https://en.wikipedia.org/wiki/Axiom_of_choice)
  * `∀𝑨 ((∀𝑿 (𝑿∈𝑨 ∧ 𝑿≠∅)) ⇒ ∃𝒇 (𝒇: ∀𝑿 (𝒇(𝑿)∈𝑿)))`
