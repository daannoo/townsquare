# Release Notes

## Upcoming version



### Version 3.20.1
- Inconsistancies in french translations for "Power" & "Character"

### Version 3.20.0

- MAINT: Upgrade caniuselite
- Various corrections in the French version
- Minor corrections in the English version
- Translatable night description bubbles

### Version 3.19.0

- MAINT: Updating King description
- MAINT: Update of the icons
- MAINT: chnged french translation for Minions from Serviteurs to sbrires
- MAINT: changed french name for Fibbin from Mensonge to Menteur
- MAINT: french translation inconcistancy for snake charmer
- MAINT: changed french name for Baloonist from Montgolfier to Aéronaute
- MAINT: adjustment to nomination messages
- BUGFIX: missing translation in Roles modal
- BUGFIX: missing translation in Night order modal
- BUGFIX: reminder modal title from translation

### Version 3.18.0

- Adding a missing jinx
- Updating night order (and its print)
- Correcting automatic adding/deletion of Fabled
- Adding all missing roles (up to Summoner)
- Correcting Dawn night order

### Version 3.17.0

- Updating english jinxes
- Adding an asterisk in the roles reference
- Correcting the message when someone wants to exile a Traveller
- Correcting Leviathan's english description
- Correcting "Late Night Drive By"'s name
- Adding a token "Used" to the Doomsayer
- Updated packages & Dockerfile for node >=18

---
### Version 3.16.0 (merged upstream 2.16.2)
- fixed custom script format to support new script tool JSON
- updated packages to be compatible with Node >= 18 again

---
### Version 3.15.0
- Night order bubbles always on for storyteller
- Optional night order bubbles for players

---
### Version 3.14.0
Reworked script selection UI

---
### Version 3.13.2
Malformed JSON breaking compilation

---
### Version 3.13.1
Some corrections in the reminders tokens:
- Correcting some french names
- Putting some tokens in "remindersGlobal"
- Deleting some useless tokens, or adding some other

---
### Version 3.13.0
- Correcting the print when ST assigns roles (adding spaces)
- Changing the default value of "isNightOrder"

---
### Version 3.12.0
- Printing the number of alive non-Travellers
- Adding the picture leaf-top6.png
- Some corrections in the jinxes (in French)
- Correcting Atheist's french description

---

### Version 3.11.4
Correcting the print of new scripts' names

---

### Version 3.11.3
Changing default vote duration (3s -> 1s)

---

### Version 3.11.2
Various corrections in the french version

---

### Version 3.11.1
Small UI tweeks to custom scripts selection

---

### Version 3.11.0
Add several included custom scripts

---

### Version 3.10.2
Corrected french description for Minstrel

---

### Version 3.10.1
Correct some french descriptions (Magician, Acrobat, Riot, Legion, Pixie)

---

### Version 3.10.0
- Add the Organ Grinder
- Add new option to hide votes if there is an Organ Grinder

---

### Version 3.9.0
Upgrade node engine to version 16

---

### Version 3.8.1
Several translation correction in french version

---

### Version 3.8.0
Corrected several misleading french translations

---

### Version 3.7.1
Renamed some gambler & moonchild in french translation

---

### Version 3.7.0
Additional reminders for Buddhist & Deviant

---

### Version 3.6.4
Menu reorganization

---

### Version 3.6.3
Small UI adjustments

---

### Version 3.6.2
Dockerization of development environment

---

### Version 3.6.1
Gitignore update to ignore some log files

---

### Version 3.6.0
Timer presets

---

### Version 3.5.0
Better design responsiveness for lower screen resolutions

---

### Version 3.4.1
Fixed night order in french version

---

### Version 3.4.0
Add Streamer mode

---

### Version 3.3.0
Add Narrator tools panel and timers

---

### Version 3.2.0
Add more scripts to the "Popular custom scripts" tab
---

### Version 3.1.0
Add ring bell option

---

### Version 3.0.0
Add localization capabilities and french translation

---

### Version 2.16.1
- Updated character night order to be consistent with script tool

---

### Version 2.16.0
- Add ability to use json from clipboard to upload script (by @alexanderfletcher)

---

### Version 2.15.4
- fixed flickering of add reminder token
- added redirect to Chinese version

---

### Version 2.15.3
- add Huntsman/Damsel, Noble, Al-Hadikhia, Golem, Fearmonger, Puzzlemaster, Alchemist, Engineer, Riot, Psychopath, Atheist, Nightwatchman to list of available characters
- fixed game state JSON not handling custom Fabled correctly

---

### Version 2.15.2
- added mobile web application support
- show correct number of leaves on roles with global reminders
- fixed a bug with traveler list showing up when assigning demon bluffs
- fixed a bug with homebrew scripts that contained negative night order positions

---

### Version 2.15.1
- fix Mephit not showing up on scripts, futureproof Mephit name change
- add Boomdandy to list of available characters

---

### Version 2.15.0
- clean up transparent portions of icons
- add Magician & LLeech to list of available characters

---

### Version 2.14.0
- added Farmer to list of available characters

---

### Version 2.13.0
- fix players being moved or removed during nomination
- add vue linter
- use "Exile" rather than "Banishment" for exiles
- added global animation toggle for better performance
- added record vote history toggle to session menu, and clear vote history button
- add support for custom Fabled characters
- show Jinxed interactions on character reference list
- add 'marked for execution' indicator

---

### Version 2.12.0
- tweak reference sheet to better fit screen in single column layout
- add warning icon overlay for setup roles on character assignment modal
- added Heretic and Marionette plus King/Choirboy and the Gangster to list of available characters

---

### Version 2.11.0
- new design for character reference sheet
- automatically switch to grimoire view when joining a session through a link
- fixed demon bluffs showing on public town square
- fixed a bug that prevented connecting to a session when previously being connected and joining through a link

---

### Version 2.10.0
- added [nomination log indicator](https://fontawesome.com/icons/book-dead).  When a nomination log [v] is available, the number of currently visible entries is displayed. Clicking the indicator can reveal/hide the nomination log.
- fix issue where a player and storyteller updating the same players pronouns at around the same time causes an infinite loop disconnecting the session.
- fix bug with shifting roles when the storyteller deletes a player
- added Poppygrower to list of available characters

---

### Version 2.9.1
- fix gamestate JSON not showing (custom) roles and failing to load states with custom scripts properly
- fix gamestate not stripping out special characters from role.id on load
- made character assignment modal a bit prettier
- got rid of the extra pixels on the  Soldier icon
- fixed lengthy live session channel names not being correctly cut off
- hide player names in night order / character reference popup when town square is public
- fix (pre-)vote calculation being off by one if the nominee votes

---

### Version 2.9.0
- added support for assigning pronouns to players and display of the pronouns in a tooltip on the player name.
- added button to modals that allows the user to maximize them
- added Mephit and Snitch to roles.json

---

### Version 2.8.0
- added hands-off live session support for homebrew / custom characters again!
- added custom image opt-in that will prevent any (potentially malicious / harmful) images from loading until a player manually allows them to

---

## Version 2.7.0
- added support for assigning duplicate characters to more than one player (like Legion)
- further live session bandwidth optimizations
- sessions can now be joined by pasting the whole link into the popup (thanks @davotronic5000)
- fabled night order bug fixed
- added Legion to list of available characters (thanks @eddgabriel)
- added support for mp4/webm video backgrounds
- added tooltips to night order popup

---

## Version 2.6.0
- night mode can be toggeled with [S] now (thanks @davotronic5000)
- night order shows which players are dead

---

## Version 2.5.0
- all travelers from the base editions are now optionally available (thanks @davotronic5000)
- night order shows player names near roles now

---

## Version 2.4.0
- added spoiler role (Pixie!)
- fixed bug with ST sending out roles that are not part of the current edition / script (ie. travelers or base set roles)
- better Lycanthrope icon (thanks @AWConant)

---

## Version 2.3.1
- better vote history design and added timestamps
- adjusted player menu styling on smaller screens
- improved CONTRIBUTING.md description of hosting your own copy

---

## Version 2.3.0
- added spoiler role (Lycanthrope!)
- fixed copy to clipboard in Firefox
- fixed non-countdown votes still playing countdown sound for a split second

---

## Version 2.2.1
- clearing players / roles now also clears Fabled
- fix list of locked votes showing unlocked votes sometimes

---

## Version 2.2.0
- added [V] hotkey to open nomination history (thanks @lilserf)
- updated roles according to official Wiki changes
- adjusted roles night order

---

## Version 2.1.1
- show vote results at the end of a vote
- fixed global reminders not showing up anymore when the associated role is assigned to a player
- adjusted backend metrics


---

## Version 2.1.0
- reduced countdown volume by 10db
- added a mute toggle to the Grimoire menu (currently only silences the countdown)
- pressing [J] while in a session will now leave the session
- always show reminder add button when on a mobile device that doesn't support hovering
- removed screenshot feature as it is no longer useful

---

## Version 2.0.4
- fix bug with live sessions that contain travelers from a different set
- fix server channel cleanup

---

## Version 2.0.3
- load roles that belong to different editions (like travelers) from gamestate
- close session when missing custom roles and open edition modal
- added a few more metrics

---

## Version 2.0.2
- fix nomination history type not detecting travelers
- fix live session domain whitelist
- fix build path
- fix changelog version numbering

---

## Version 2.0.1
- clearing the nomination history as the Storyteller clears it for the players too
- vote buttons should work in all situations correctly now
- fixed some minor styling and live session issues

---

## Version 2.0.0
- The project is now available under its own domain: [clocktower.online](https://clocktower.online)
- Added a feature that allows a live session Storyteller to automatically (and safely) distribute assigned
  characters to all players that have claimed a seat, eliminating the need to manually tell every player their role
- Visible "night phase" that can be toggled by the Storyteller
- Voting history added with nomination and vote results
- Optional, audible voting countdown added (featuring an actual clock tower bell!)
- Fabled show up on the Night Order sheet and affect Grimoire night order counters
- Current game state can now be easily exported and imported in the form of a JSON text code
- Voting can be paused and sped up / slowed down in 0.5 second increments by the Storyteller
- Voting terminology changed to "Hand UP" / "Hand DOWN" and iconography updated
- Added meta-data support for custom scripts, that currently supports `name`, `author` and a custom `logo` through a
  `_meta` role (note that a customized logo will not be synced to players in a live session)
- Players can no longer claim seats that are already occupied and only the Storyteller can vacate seats of other players
  (players can still vacate their own seat)
- Characters selected in the bluff window now also show up in the list of reminder tokens
- Homebrew scripts / custom characters no longer automatically load in live sessions, for 2 reasons:
  - the players in a live session have no control over the script that the storyteller loads,
    so a malicious storyteller could load a custom script that contains harmful / inappropriate images
  - some homebrew scripts are quite big JSON files and synching these through the live session
    server can cause traffic / performance issue easily
  - this change may be reverted in the future when I figure out a way to sync custom characters safely and without
    such a big impact on performance constraints
- Buggy (spamming) live session connections will now be terminated on the server side and display an error message
- Balloonist reminder tokens adjusted
- Live session URLs shortened
- Deus Ex Fiasco and Stormcatcher Fabled added / updated
- Custom Reminder text looks better when there is a lot of text
- added a README for the backend server
