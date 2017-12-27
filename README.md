# Dota 2 Combo Bots 0.1 version

*This project is still in prototyping and developing stage.*

These are bots for Dota 2 and a toolkit to configure them.

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

## Contributing

## Acknowledgements

Thanks to [adamqqqplay](https://github.com/adamqqqplay) and his great [Ranked Matchmaking AI](https://github.com/adamqqqplay/dota2ai) project. Some of his ideas and concepts are used here.
