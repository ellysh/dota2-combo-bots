# Dota 2 Combo Bots 0.1 version

*This project is still in prototyping and developing stage.*

These are bots for Dota 2 and a toolkit to configure them.

A current development state is available in the [`CHANGELOG.md`](CHANGELOG.md) file.

## Why this project appeared?

Dota has default bots that are fit excellent for new players training. But they are too weak to compete with more experienced players. Therefore, these players do not have reliable computer opponents, which allow them to train some tactics and ideas.

There are several well-known projects that suggest more powerful bots for experienced players. But most of them have some drawbacks that make them unreliable for daily Dota training.

The aim of this project is providing a reliable solution for experienced players training.

## Architecture

The main issue with any Dota bots is to transform knowledge from the game experts and pro players into the source code. The Combo Bots project has a solution to this issue.

The knowledge about the game is extracted from the source code into the Excel document, which is named Database. Any player can edit this document and use generator script to produce Lua files. These files have the format, which can be read by the bot. Thus, we have a flexible mechanism to configure the bot and adapt it for your purposes.

## System Requirements

You need nothing except the Dota 2 game to play with Combo Bots.

These applications are required to edit the Combo Bot Database:

* Free [LibreOffice](https://www.libreoffice.org) or MS Office.
* [Python interpreter](https://www.python.org/downloads) of the 2.x version.
* Windows, Linux or Mac OS.
* Bash interpreter to automate Lua scripts generating and unit tests launching (optional)

The [Lua interpreter](https://www.lua.org/download.html) of the 5.3 and above version is required to launch unit tests locally.

## Installation

Now the Combo Bots project is still in development stage. It is not ready for testing by players community. Therefore, it is not available on Steam yet.

You can download the bots and install them manually in the Dota 2 game directory. These are steps to do it:

1. Download the [Combo Bots archive](https://github.com/ellysh/dota2-combo-bots/archive/master.zip).
2. Unpack the archive.
3. Copy all files from the `bot` sub-directory to the `$DOTA\dota 2 beta\game\dota\scripts\vscripts\bots` directory.
4. Start the Dota 2 game.
5. Create a lobby (Play Dota -> Create Lobby).
6. Specify the `Local Dev Script` option in the lobby bot settings for one of the teams.

More details about installing custom bots you can find in this [Dota 2 AI Quick Start](http://ruoyusun.com/2017/01/08/dota2-ai-quickstart.html) guide.

## Configuration

You can find Combo Bots Database file in the `generator/database/docs/Database.ods` path. It has the standard Excel document format.

There are several sheets in the document:

* HEROES
* ITEM_RECIPE
* ITEM_BUILD
* ITEM_SELL
* SKILL_BUILD
* SKILL_USAGE

You should use the internal (built-in) game names of the items, units, heroes, and abilities to fill these sheets. These are links, where you can find this information:

1. Item and hero names:<br/>
https://dota2.gamepedia.com/Cheats
2. Names of the hero abilities:<br/>
https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Ability_Names
3. Names of the items abilities match the items names.

### HEROES

The `HEROES` sheet specifies a list of heroes that can be selected by bot on the draft step.

These are columns of this sheet:

* Hero - this is the built-in hero name to select.
* Position - these are two values that match a possible hero's [farm position](http://wiki.teamliquid.net/dota2/Farm_Dependency) in a team.
* Combo Heroes - these are three possible heroes that can be effectively combined with the current hero.
* Counter Heroes - these are three possible heroes that can be effectively countered by the current hero.

The bot uses data from this sheet to select heroes on the draft step.

Now only the All Pick draft mode is supported.

### ITEM_RECIPE

The `ITEM_RECIPE` sheet describes a list of components to assemble the recipe items.

These are columns of this sheet:

* Item - this is a recipe item name to assemble.
* Components - these are four or fewer components, which are required to assemble the current item. If a component is a recipe item too, you should specify the name of this item here instead of its components.

The bot uses this data in the item purchasing algorithm. Thanks to this sheet, you can specify only final recipe items in the item builds.

## Contributing

I will be glad to any help with the development of this project.

If you are familiar with Lua scripting, you can help with the code development. Please, send your patches via email or make push commits on GitHub.

If you are a game expert, you can help with filling the Database. You can send me your `Database.odt` file. Then I will use it to generate Lua scripts and merge new features in the project repository.

## Acknowledgements

Thanks to [adamqqqplay](https://github.com/adamqqqplay) and his great [Ranked Matchmaking AI](https://github.com/adamqqqplay/dota2ai) project. Some of his ideas and concepts are used here.

## Contacts

You can ask any questions about usage of Combo Bots via email petrsum@gmail.com.

## License

This project is distributed under the GPL v3.0 license
