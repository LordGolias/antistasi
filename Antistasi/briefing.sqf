waitUntil {!isNull player};

player createDiarySubject ["Tutorial","Begin Tutorial"];
player createDiaryRecord ["Tutorial",["Menus",
	"The different items in <marker name='respawn_west'>your HQ</marker> allow you to access different menus. The Y key accesses others."
]];
player createDiaryRecord ["Tutorial",["Undercover",
	"In the early stages, especially when accomplishing certain missions, being undercover can be extremely helpful.
	 Just as for real resistance fighters, your ability to disappear is something the AAF cannot counter.
	 See Features section for a deep explanation of Undercover Mode."
]];
player createDiaryRecord ["Tutorial",["Start Position",
	"Find a good spot to begin the mission.
	 Your experience is very different from one start spot to another.
	 Study the surrounding markers and roads between them well.
	 If you start near a road between enemy zones, a patrol may appear and kill Petros"
]];
player createDiaryRecord ["Tutorial",["Resources",
	"There are three types of resources: Human Resources (to recruit AIs), money (to buy stuff), and equipment (to equip you and AIs).
	 HR and Money is shown on the top, equipment is in the ammo box.
	 In the initial stages, your main source of resources is side-missions."
]];
player createDiaryRecord ["Tutorial",["Conquer and Hold",
	"Don't expect a light counter-attack when you conquer strategic zones such as resources or bases.
	 The AAF will send everything they can, if available.
	 If you conquer a zone and expect a counter-attack, fleeing is a nice option."
]];
player createDiaryRecord ["Tutorial",["Strategy",
	"Once you have a nice amount of resources, focus on enemy communications.
	 If you disturb them enough, you won't have to face big counter-attacks."
]];
player createDiaryRecord ["Tutorial",["CSAT Support",
	"Keep an eye on CSAT Support. If it's too high, counter-attacks will be much more difficult."
]];
player createDiaryRecord ["Tutorial",["Early Beginning",
	"Don't expect to be able to conquer anything in the early stages.
	 First you have to gather enough resources (HR and Money) in order to be able to conquer and hold your positions.
	 This mission tries to simulate real life guerilla situations.
	 If in doubt, ask yourself what would you do in real life.
	 Don't expect to win every time. Hit and Run is the basic manoeuvre here.
	 Earn every resource, weapon and ammunition to gather enough assets in order to be a real challenge for the enemy.
	 In the meantime, disturb its operations and gain support from NATO."
]];

player createDiarySubject ["Commander","Commander Options"];
player createDiaryRecord ["Commander",["In-game Members",
	"In the HQ Flag, if the Server Member feature is enabled, you may check which of the Server Members are in game and the total number of non members."
]];
player createDiaryRecord ["Commander",["Grab FIA Funds",
	"Use this option to grab money from the FIA pool to your personal account.
	 Please note this will have an impact on your score and future promotion chances.
	 Corrupt Commanders may find themselves loosing their command."
]];
player createDiaryRecord ["Commander",["Roadblocks",
	"Use the menu and select a spot on the map.
	 Click where a road is. A group of AT soldiers will join you.
	 Send them to the selected place and they will establish a roadblock there."
]];
player createDiaryRecord ["Commander",["Observation Post",
	"Use the radio and select a spot on the map with good field of vision.
	 A group of snipers will join you.
	 Send them to the selected place and they will spot for you, attempting to remain hidden and not engaging enemies upon contact."
]];
player createDiaryRecord ["Commander",["Sell Vehicle","Use this option to sell captured vehicles and increase FIA funds."]];
player createDiaryRecord ["Commander",["Minefields","Take the engineers truck to the desired position to build a minefield. Cover them while they deploy mines. From then on, no one will be able to pass the area safely (even your own units - so use with caution). Mines (AT and AP) are taken from your Ammobox. The quantity of mines in the field will depend on the contents of your ammobox, up to a max. number depending on the type of minefield. Delete those minefields to recover the mines."]];
player createDiaryRecord ["Commander",["Recruit Squad","The Commander may recruit an AI manned squad at base camp flags. Use the High Command module (CTRL + SPACE) to give orders to your squads. Also you may temporally control and dismiss the squad leader in the same way you do with squad-mates."]];
player createDiaryRecord ["Commander",["Artillery","Mounted mortar teams may be used as artillery support. Select a mortar team using the High Command bar, and press SHIFT + Y in-game to call in a mortar fire mission."]];
player createDiaryRecord ["Commander",["NATO Attacks","If you have enough NATO Prestige points you can ask NATO forces to conduct an attack. The more prestige you have, the bigger the attack. NATO Attacks can only select AAF Bases and Airports as targets. Don't abuse these! Every time you ask for an attack, you will lose prestige points"]];
player createDiaryRecord ["Commander",["NATO Armor","Spend prestige points on asking an armoured column to reach any zone on the map you desire. Column size will depend on actual Prestige points. Use them for both attacking or defending purposes"]];
player createDiaryRecord ["Commander",["NATO Ammodrop",
	"NATO will send a transport chopper with an ammobox full of supplies you can use.
	 The number of weapons and equipment will depend on your total NATO points.
	 The more points, the better the contents of the ammodrop."
]];
player createDiaryRecord ["Commander",["NATO Arty/CAS","Use this option to call in NATO Arty\CAS Support. The quality of the vehicle will depend on your total of NATO points."]];
player createDiaryRecord ["Commander",["NATO Bomb Run","NATO will perform an Air-strike / bombing run of the specified type."]];
player createDiaryRecord ["Commander",["Rest - Camp-fire","Use the action menu on your HQ Camp-fire to rest for 8 hours."]];
player createDiaryRecord ["Commander",["Move HQ","The Commander may select this option on the HQ Flag in order to move the HQ emplacement to another spot. This will allow you to move your HQ to a safer location or move closer to the front-lines. The closer your HQ is to the enemy, the greater the number of possibile side-missions you will have available. Remember! Keep Petros Safe or you will lose the game!"]];
player createDiaryRecord ["Commander",["Side Missions - Petros","Ask Petros for any type of mission you want. Mission availability is subject to HQ positioning, current allocated tasks and ownership of the surrounding areas"]];
player createDiaryRecord ["Commander",["FIA Skill Upgrade","For a price, you can upgrade FIA training so that future recruits will have better skills."]];
player createDiaryRecord ["Commander",["Garrisons","The Commander is responsible for assigning units as garrisons in  conquered areas. Use the Garrison Management option in the HQ flag in order to add or remove garrison troops at each zone. Check Map Info screen for a quick overview of how many soldiers are assigned to each zone."]];
player createDiaryRecord ["Commander",["General","Having a commander is necessary because he is the commander of the FIA attacking ground forces. Many options are available only to the commander and, depending on your settings, if you play MP, the most experienced player will usually occupy this position."]];

player createDiarySubject ["SpecialK","Special Keys"];
player createDiaryRecord ["SpecialK",["Earplugs","Press END to enable / disable earplugs. Disabled with ACE."]];
player createDiaryRecord ["SpecialK",["Group Manager","MP Only: Press U in-game to join another player's group"]];
player createDiaryRecord ["SpecialK",["Artillery","Press SHIFT + Y in-game while having an artillery squad selected on the HC bar."]];
player createDiaryRecord ["SpecialK",["High Command","When you are the Commander, hit CTRL + SPACE to give way-points and other orders to your AI squads using the HC mode. Non commanders may use it to check enemy contacts reported by the FIA communications network."]];
player createDiaryRecord ["SpecialK",["Battle Options","Press Y in-game to have access any time to several options. Most of them are explained in the Commander or Features sections."]];

player createDiarySubject ["Features","Features Detail"];
player createDiaryRecord ["Features",["Player and Money","Use this option to donate money to other players or your faction funds. Commanders may add or remove players from the Server Members List if the feature is enabled"]];
player createDiaryRecord ["Features",["Server Members","For MP only. If enabled, this feature will exclude all non-members from using the HQ Ammobox and become Commander. This feature is intended to avoid having your game ruined by the casual troll in open server environments."]];
player createDiaryRecord ["Features",["Base Static Emplacement","Purchased static weapons won't despawn if you leave them in a base or zone, AI garrison will man them. Reinforce places as you desire."]];
player createDiaryRecord ["Features",["Fast Travel","When there are no enemies nearby, fast travel to FIA controlled places. The Commander also has the ability to use this option on HC groups, selecting the group on HC bar and clicking on this button"]];
player createDiaryRecord ["Features",["Ammobox Transfer","When you mount a truck, you may use the Transfer action in the action menu. It will search for nearby ammoboxes and load the contents of the nearest one into the truck's cargo space. You may then unload the truck in your ammobox at HQ for future use. Before transferring, make sure to unload backpack/vest contents into the Truck cargo space and then transfer. TIP: If your HQ Ammobox is full, use this functionality from a nearby truck to add more content to the ammobox as it will then accept everything :)"]];
player createDiaryRecord ["Features",["Conquer","Some zones, like bases or airports require you to use the ""Take the Flag"" action on their respective flags in order to conquer them. Some others, like roadblocks and some outposts, simply require you to defeat the garrison."]];
player createDiaryRecord ["Features",["Static Weapons","You may steal static weapons found in enemy bases. You must use the 'Steal Static' action to do so. DO NOT disassemble them before using the 'Steal Static' action!"]];
player createDiaryRecord ["Features",["Vehicles","You may buy vehicles for your squad at FIA flags."]];
player createDiaryRecord ["Features",["Radio Towers","Destroy or capture Radio Towers in order to disrupt the AAF Comms Network. Bases and Airports without Comms cannot perform counter-attacks. Conquering instead of destroying a Radio Tower will give the FIA a chance of discovering enemy movements."]];
player createDiaryRecord ["Features",["Politics","This is a civil war. People are not conquered if you cannot conquer their hearts. In game mechanics, this means you cannot conquer cities. The citizens of each town support the AAF or FIA to some amount. The dominant faction is the one who owns the city and benefits from their support in terms of money and human resources (HR). Your actions may lower AAF Support or raise yours, or both. Killing enemies, accomplishing missions, conquering resources, and power-stations, affect the amount of citizen support."]];
player createDiaryRecord ["Features",["Arsenal",
	"Scavenge equipment and put it in your HQ Ammobox.
	 This equipment becomes available to players in the Arsenal (you cannot take more than those that exist).
	 The AI will also use these items, within limits to avoid depleting them. Leave no man behind: AIs that are discharged return the equipment. Vehicles sold and stored also.
	 Certain items are undepletable (e.g. uniforms)."
]];
player createDiaryRecord ["Features",["Undercover","Click on this button to go undercover. If you meet the requirements, the AAF won't attack you on sight. On foot, to go undercover you must have no weapons or military equipment visible. You will lose undercover status when you change load-out, get spotted by enemy guard-dogs, plant mines, and can also be reported by some civilians to the AAF. If you are discovered you won't be able to go undercover on foot again for 30 minutes. You can also go undercover by getting into any civilian vehicle. You will lose undercover status by firing any weapon or being spotted far from a road. If you are discovered you won't be able to go undercover in that vehicle again. Getting close to enemy bases, outposts and roadblocks will also make you lose undercover status."]];
player createDiaryRecord ["Features",["Garage","Add any vehicle near your personal Virtual Garage (or factions garage if you are the commander) and keep it safe for future use. Vehicle add option is under the Y menu. Garage management is in HQ options (Flag)."]];
player createDiaryRecord ["Features",["Faction Leader","Just as with any resistance movement, leadership is not as stable as in organised states. Any player can take the role of FIA Force Commander if the current one is not very popular... Demonstrate your skill while accomplishing missions and killing enemies and maybe you will become the next leader."]];

player createDiarySubject ["AI","AI Management"];
player createDiaryRecord ["AI",["Dismiss Squad-mate","Select the unit and use the 'Dismiss Squad-mate' option to send them back to HQ. You will recover some of the money you spent on them"]];
player createDiaryRecord ["AI",["Vehicle Squad","Commander Only. Use this option to assign the vehicle you are looking at to any HC squad. Check vehicle status, order them to mount or disembark, and automate mounted static squads"]];
player createDiaryRecord ["AI",["Auto Rearm","Your AI squad-mates will automatically look for and scavenge any ammunition from nearby corpses, vehicles and ammoboxes if needed. Use this instead of the vanilla Rearm radio option"]];
player createDiaryRecord ["AI",["Auto Heal","AI Medic squad-mates will heal other AI’s automatically without the need to give any orders. If in combat, your AI will use smoke grenades for cover. If there is no medic in the group, the AI will use their own medikits."]];
player createDiaryRecord ["AI",["AI Radio","This feature aims to simulate the lack of radio communications with AI fighters. Your AI squad-mates won't have a radio until you unlock it from the Arsenal. Without a radio, if an AI squad-mate gets too far away, they will get lost and return to the leader's position after completing the last order they received. To avoid this, you may scavenge some radios from AAF (AutoRearm feature will do) or let the AI use a military vehicle which has long range radios. If it takes too long to find their leader, they will automatically return to the HQ."]];
player createDiaryRecord ["AI",["AI Control","Select a squad-mate or HC Group to gain direct control over them for a limited time. Selecting this option for a HC squad will give you control over the squad's leader"]];
player createDiaryRecord ["AI",["Recruit","You may recruit up to 9 AI squad-mates at some FIA flags and the HQ flag."]];

player createDiarySubject ["Options","Game Options"];
player createDiaryRecord ["Options",["Reinit UI","Select this option when the Y key or Statistics bar are not working. Also use this option if you have any support (mortar, CAS) with no radio option to call it."]];
player createDiaryRecord ["Options",["Garbage Cleaner","Commander only. Will delete things like dropped weapons, magazines, clothing etc.. Beware, it freezes the game for some time"]];
player createDiaryRecord ["Options",["Spawn Distance","Commander only. Increase or decrease general spawn and despawn distance. Use it carefully combined with other options. SP tested a loss of 10 FPS rate in max. settings. MP networking bandwidth loss was not tested."]];
player createDiaryRecord ["Options",["Civ Spawn","Increase or decrease the percentage of city civilian population that spawn. At 0% only one civilian will spawn in each city."]];
player createDiaryRecord ["Options",["Music ON/OFF","Antistasi has a situational music script, depending on a player's stance and time of day. The default in MP is OFF, and ON in Single-player"]];
player createDiaryRecord ["Options",["Persistent Save-game","Commander Only. You may save the game at your HQ Map. This will allow you to continue playing upon mission update or server restart, preserving stats, player's equipment, conquered zones, AAF assets and many more things. WARNING SP USERS: Normal save and load runs badly in this mission. This system is your only guarantee of saving the game properly"]];
player createDiaryRecord ["Options",["FPS Limiter","Commander Only. Sets the minimum FPS ratio for the server in order to spawn civilians. There is a built-in minimum, so some civilian spawning is guaranteed. Use in combination with the Civ Spawn options to improve server performance if needed."]];
player createDiaryRecord ["Options",["Map Info","Click on a city to learn the strength of their support for the AAF or FIA. Click on other zones to know relevant info about them."]];

player createDiaryRecord ["Diary",["Thanks","nuker: For testing and ideas<br/>Ghost: For MP DS testing and teaching me how to run a DS.<br/>Nirvana and CWW clan for testing.<br/>LanCommi on dedi server testing.<br/>neuron: lots of testing and help in steam page.<br/>Gillaustio and Farooq for inspirational works on revive system<br/>Valtas: Support, testing bug reports and building the first serious open Dedi for Antistasi<br/>Goon and jw custom: Part of the code for the NAPALM script.<br/>Larrow: Very valuable scripting help in BIS forums<br/>Billw: Lots of help on testing and bug detection<br/>tommytom73: HC testing<br/>Manko: Earplug snippet<br/>harmdhast: Help on some scripting<br/>DeathTouchWilly: Official Antistasi Manual<br/>daveallen10: ACE Integration scripts<br/>x RickyTan x: Tons of help and testing in the Official Servers and Antistasi Trailer development<br/>And all those players who spend their time on making comments, suggestions and reports on Steam and BIS forums"]];
player createDiaryRecord ["Diary",["Mods","Integrated (optional) Mods:<br/>TFAR: Radio integrated in Arsenal. Sound disabled when player is unconscious.<br/>ACE Medical: Will disable Antistasi revive system.<br/>RHS AFRF: FIA Loadout.<br/><br/>CAUTION: The use of Persistent Save system with TFAR and RHS activated will make them mandatory in future.<br/><br/>Any client sided Mod, such as JSRS, Blastcore, UI Mod should work.<br/><br/>Units and vehicles mods won't work. AI Mods may cause malfunctions (in any case Antistasi has heavy AI tweaking)."]];
player createDiaryRecord ["Diary",["Script Credits","UPSMon by Monsada, Kronzy and Cool=Azroul13 <br/>Persistent Save by zooloo75.<br/>Tags by Marker and Melbo."]];
player createDiaryRecord ["Diary",["HQ - Basics","Flag: Vehicle and Squad Unit Recruitment. Commander Options.<br/>Petros: Side-missions (Commander Only).<br/>Map: Game Options.<br/>Camp-fire: Rest for 8 hours (Commander Only)."]];
player createDiaryRecord ["Diary",["Resources","Every 10 minutes each faction receives Money and Manpower according to the zones they own, and the state they are in. Having a good amount of resource zones, some factories, both with friendly power plants nearby is the way of getting enough resources to win this war. Please note AAF is doing the same to buy new vehicles and CSAT Support."]];
player createDiaryRecord ["Diary",["Money","Money comes from a combination of citizens support on each city, resources conquered, factories conquered (which boost the economy) and power provided to all of them with a nearby friendly power plant (you may also conquer them to cut off Money supply to the enemy). Money is used to purchase vehicles, units and squads"]];
player createDiaryRecord ["Diary",["Money - MP","In MP games there are two money pools. FIA Money -which is for Commander use only- and personal money. Personal money can be used by any player to recruit AI or buy vehicles. FIA earns money by taxes and accomplishing missions. Personal money comes from killing enemies and accomplishing missions. Options to transfer or donate money are found in the Y menu. Commander can grab money from the FIA Pool to his own account"]];
player createDiaryRecord ["Diary",["HR","HR or Manpower comes from citizen support on each city. Manpower is needed to recruit more units (1 HR Points = 1 Soldier)"]];
player createDiaryRecord ["Diary",["NATO and CSAT Support","External intervention is something both sides are looking for. Some actions will raise NATO Support for you while others will raise CSAT Support for AAF. General rule: conquering zones will raise CSAT will to intervention. Evil player actions such as killing prisoners or civilians will low NATO support, good actions such as help civilians will raise NATO support."]];
player createDiaryRecord ["Diary",["Loose","You will loose the game if CSAT has destroyed a total of 8 cities."]];
player createDiaryRecord ["Diary",["Win","You will win the game when most of the population supports FIA"]];
player createDiaryRecord ["Diary",["Welcome","Welcome to Arma 3 - Antistasi. This mission aims to simulate guerilla combat, tactics and strategic situations. It is not a quick and easy mod, it is long term, step-by-step mission with LOTS of features and enhanced AI."]];