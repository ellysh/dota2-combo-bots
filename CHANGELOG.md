* version 0.6
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
