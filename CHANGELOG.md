* version 0.8a
  - Fix a bug with a timing to check runes.
  - Make team desires more situation depended.

* version 0.8
  - Fix bugs with the Lich skills usage.
  - Fix a bug with selling items.
  - Add the Warlock hero.
  - Fix a bug with buying extra components for upgradable items.
  - Add the Phantom Lancer hero.
  - Fix a bug when Chaos Knight's illusions do not attack creeps
  and buildings.
  - Fix a bug with picking up a rune while fighting or killing Roshan.
  - Add the ATTACK_TARGET table that allows adding algorithms for
  choosing the most desirable target for attacking.

* version 0.7a
  - Fix a bug with the Satanic item recipe.
  - Fix item builds of Chaos Knight and Phantom Assasin.
  - Fix a bug with casting AoE abilities to non-targetable units.
  - Fix a bug with a desire calculating to visit secret and side shops.
  - Fix a bug with sending courier to base after each transfer.
  - Fix a bug with buying the same items several times.

* version 0.7
  - Add the Chaos Knight hero.
  - Add the Phantom Assassin hero.
  - Rework the purchasing items mechanism. Now bots can walk to a side
    and secret shops.
  - Basic implementation of a pushing lanes strategy.
  - Rework the draft system. Now bots consider the already picked
  heroes when drafting. If the human players pick the unknown heroes,
  bot decides that they have position 1.
  - Fix a bug with bot names.
  - Use the luacov util to generate unit tests code coverage reports.

* version 0.6
  - Fix a bug with picking heroes for human players
  - Add support for Sven and Lich heroes. Now bots know enough heroes
  to fill both teams.
  - Fix a bug with focusing an invulnerable target hero.
  - Add early game items to the ITEM_BUILD table

* version 0.5
  - Fix a critical bug with taking elements by indexes of the
  unsorted tables. The bug can cause issues with level up
  abilities, purchasing items, abilities usage, and heroes draft.
  - Fix a bug with level up abilities and talents because of
    C++ side issue.
  - Add "desire" values to the SKILL_USAGE table.
  - Use abilities with a probability that equals to the "desire"
    values in the SKILL_USAGE table.

* version 0.4
  - Fix bugs with skill usages of Sniper, Lion, and Ursa
  - Fix a bug with level up abilities and talents
  - Change a format of the SKILL_BUILD table

* version 0.3
  - Debug all mechanism of bots on a testing team
  - Fill a database for a small heroes meta

* version 0.2
  - Implemented the skills usage mechanism

* version 0.1
  - Implement the items purchasing and selling mechanism
  - Implement the abilities and talents level up mechanism
  - Implement the combo draft mechanism
  - Implement the generator script to extract data from the Database
  - Implement the courier control algorithm
