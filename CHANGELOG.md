* version 1.3a
  - Fix items receipts according to the 7.14 patch.

* version 1.3
  - Add the SKILL_GROUPS table. Now each skill can refer to several
    skill groups. This allows using the skill in a different manner
    depending on the situation.
  - Change a format of the HEROES table. Now heroes skills, damage type,
    and attack range are considered when drafting.
  - Fix priorities to attack enemy buildings. The current order is
    ancient, barracks, towers.
  - Do not use the CanBeSeen API function for checking attack and skill
    usage targets. This function returns false for neutral creeps
    because of the bug.
  - Fix a bug with focusing max health targets.

* version 1.2
  - Implement the farm mode.
  - Implement the Roshan mode.
  - Decrease desire to make solo agression actions.
  - Decrease the roam desire to prevent feeding by single heroes.
  - Tune team desire to not do laning after the laning stage.
  - Implement the defend tower mode.
  - Fix a bug with picking up dropped items.

* version 1.1
  - Calculate desire for the defend lane mode.
  - Add the ITEM_SETS table to gather typical item sets.
  - Rework the purchasing items mechanism. Now bots buy several items
    faster without mistakes with duplicates.
  - Fix a bug with an excessive aggression in the laning phase.
  - Bots estimate a power of the enemy hero before attacking him.
  - Make a limit for the roam target distance.
  - Implementation of the evasive_maneuvers mode. Now bots evade the
    damage from enemy towers and creeps.
  - Fix a bug with hanging in the roam mode.
  - Fix a bug with a canceling TP scrolls.
  - Fix a bug with picking up rune when it is out of a vision range
    because of elevation.

* version 1.0
  - Bots choose laning when there is no targets for push and roam.
  - Distinguish the neutral and enemy creeps in the attack algorithms.
  - Retreat when a tower attacks a bot.
  - Fix a bug with choosing an attack target by heroes and their minions.
  - Fix a critical bug with hanging on a draft.
  - Bots cast the chain stunning instead of spamming the disable skills.
  - Fix bugs when bots move to shrine, rune or shop toward enemy heroes.
  - Fix a bug when bots do not attack enemy near own shrine.
  - Fix a bug with a not full healing near the fountain.

* version 0.9
  - Fix a bug when all base shop items are bought via a courier.
  - Fix bugs with hanging courier near the side shop.
  - Implement the items usage mechanism.
  - Fix a bug with passive strategy when Combo Bots play in both teams.
  - Implement the shrine usage mechanism.
  - Improve the algorithm for picking a random hero.
  - Implementation of the mode retreat.

* version 0.8a
  - Fix a bug with a timing to check runes.
  - Make team desires more situation depended.
  - Fix a bug with purchasing items in the base shop via courier.
  - Fix a bug with a rune pick up desire.
  - Fix a bug with stucking courier.

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
