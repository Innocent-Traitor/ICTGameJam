extends Node
const WEAPON_PATH = "res://Sprites/Items/Weapons/"
const ICON_PATH = "res://Sprites/Items/Upgrades/"
const ABILITY_PATH = "res://Sprites/Items/Ability/"
const UPGRADES = {
	"sword1": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword\n",
		"details": "A sword slashed where you are aiming",
		"prerequisite": [],
		"type": "weapon"
	},
	"sword2": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+1\n",
		"details": "Deal an extra 3 damage",
		"prerequisite": ["sword1"],
		"type": "weapon"
	},
	"sword3": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+2\n",
		"details": "Slash the sword a second time",
		"prerequisite": ["sword2"],
		"type": "weapon"
	},
	"sword4": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+3\n",
		"details": "Slash 3 times total and deal 5 extra damage",
		"prerequisite": ["sword3"],
		"type": "weapon"
	},
	"bow1": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow\n",
		"details": "Randomly shoot an arrow at an enemy",
		"prerequisite": [],
		"type": "weapon"
	},
	"bow2": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow+1\n",
		"details": "Shot another arrow and do an extra 2 damage",
		"prerequisite": ["bow1"],
		"type": "weapon"
	},
	"bow3": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow+2\n",
		"details": "Shoot 2 more arrows",
		"prerequisite": ["bow2"],
		"type": "weapon"
	},
	"bow4": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow+3\n",
		"details": "Shot 1 more arrow and do an extra 3 damage",
		"prerequisite": ["bow3"],
		"type": "weapon"
	},
	"crossbow1": {
		"icon": WEAPON_PATH + "crossbow.png",
		"displayname": "Crossbow\n",
		"details": "A crossbow that pierces enemies",
		"prerequisite": [""],
		"type": "weapon"
	},
	"crossbow2": {
		"icon": WEAPON_PATH + "crossbow.png",
		"displayname": "Crossbow+1\n",
		"details": "Pierce 3 enemies in total",
		"prerequisite": ["crossbow1"],
		"type": "weapon"
	},
	"crossbow3": {
		"icon": WEAPON_PATH + "crossbow.png",
		"displayname": "Crossbow+2\n",
		"details": "Pierce 5 enemies and do an extra 5 damage",
		"prerequisite": ["crossbow2"],
		"type": "weapon"
	},
	"crossbow4": {
		"icon": WEAPON_PATH + "crossbow.png",
		"displayname": "Crossbow+3\n",
		"details": "Pierce all enemies and do an extra 5 damage",
		"prerequisite": ["crossbow3"],
		"type": "weapon"
	},
	"fire1": {
		"icon": WEAPON_PATH + "fire_staff.png",
		"displayname": "Fire Staff\n",
		"details": "Drop a fireball around yourself",
		"prerequisite": [""],
		"type": "weapon"
	},
	"fire2": {
		"icon": WEAPON_PATH + "fire_staff.png",
		"displayname": "Fire Staff+1\n",
		"details": "Drop an additional fireball and do an extra 2 damage",
		"prerequisite": ["fire1"],
		"type": "weapon"
	},
	"fire3": {
		"icon": WEAPON_PATH + "fire_staff.png",
		"displayname": "Fire Staff+2\n",
		"details": "Deel an extra 3 damage",
		"prerequisite": ["fire2"],
		"type": "weapon"
	},
	"fire4": {
		"icon": WEAPON_PATH + "fire_staff.png",
		"displayname": "Fire Staff+3\n",
		"details": "Drop an additional fireball",
		"prerequisite": ["fire3"],
		"type": "weapon"
	},
	"sludge1": {
		"icon": WEAPON_PATH + "sludge.png",
		"displayname": "Sludge Bucket\n",
		"details": "Throw a puddle of sludge randomly and deal damage over time",
		"prerequisite": [""],
		"type": "weapon"
	},
	"sludge2": {
		"icon": WEAPON_PATH + "sludge.png",
		"displayname": "Sludge Bucket+1\n",
		"details": "Deal 1 extra damage",
		"prerequisite": ["sludge1"],
		"type": "weapon"
	},
	"sludge3": {
		"icon": WEAPON_PATH + "sludge.png",
		"displayname": "Sludge Bucket+2\n",
		"details": "Throw an extra sludge puddle",
		"prerequisite": ["sludge2"],
		"type": "weapon"
	},
	"sludge4": {
		"icon": WEAPON_PATH + "sludge.png",
		"displayname": "Sludge Bucket+3\n",
		"details": "Make the puddle 50% bigger and deal 1 extra damage",
		"prerequisite": ["sludge3"],
		"type": "weapon"
	},
	#region Items
	"food": {
		"icon": ICON_PATH + "food.png",
		"displayname": "Food\n",
		"details": "Heals 25 health",
		"prerequisite": [],
		"type": "food"
	},
	"boots1": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Go Fasters\n",
		"details": "Go 10% faster",
		"prerequisite": [],
		"type": "item"
	},
	"boots2": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Go Fasters+1\n",
		"details": "Go 20% faster",
		"prerequisite": ['boots1'],
		"type": "item"
	},
	"boots3": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Go Fasters+2\n",
		"details": "Go 30% faster",
		"prerequisite": ['boots2'],
		"type": "item"
	},
	"heart1": {
		"icon": ICON_PATH + "heart.png",
		"displayname": "Heart Container\n",
		"details": "Get +25 max health",
		"prerequisite": [],
		"type": "item"
	},
	"heart2": {
		"icon": ICON_PATH + "heart.png",
		"displayname": "Heart Container+1\n",
		"details": "Get +50 max health",
		"prerequisite": ['heart1'],
		"type": "item"
	},
	"heart3": {
		"icon": ICON_PATH + "heart.png",
		"displayname": "Heart Container+2\n",
		"details": "Get +75 max health",
		"prerequisite": ['heart2'],
		"type": "item"
	},
	"bread1": {
		"icon": ICON_PATH + "bread.png",
		"displayname": "Bread\n",
		"details": "Regain 2.5 health every 5 seconds",
		"prerequisite": [],
		"type": "item"
	},
	"bread2": {
		"icon": ICON_PATH + "bread.png",
		"displayname": "Bread+1\n",
		"details": "Regain 5 health every 5 seconds",
		"prerequisite": ['bread1'],
		"type": "item"
	},
	"bread3": {
		"icon": ICON_PATH + "bread.png",
		"displayname": "Bread+2\n",
		"details": "Regain 7.5 health every 5 seconds",
		"prerequisite": ['bread2'],
		"type": "item"
	},
	"whetstone1": {
		"icon": ICON_PATH + "whetstone.png",
		"displayname": "Whetstone\n",
		"details": "Increase damage by 10%",
		"prerequisite": [],
		"type": "item"
	},
	"whetstone2": {
		"icon": ICON_PATH + "whetstone.png",
		"displayname": "Whetstone+1\n",
		"details": "Increase damage by 20%",
		"prerequisite": ['whetstone1'],
		"type": "item"
	},
	"whetstone3": {
		"icon": ICON_PATH + "whetstone.png",
		"displayname": "Whetstone+2\n",
		"details": "Increase damage by 30%",
		"prerequisite": ['whetstone2'],
		"type": "item"
	},
	"anvil1": {
		"icon": ICON_PATH + "anvil.png",
		"displayname": "Anvil\n",
		"details": "Deflect 5% of damage",
		"prerequisite": [],
		"type": "item"
	},
	"anvil2": {
		"icon": ICON_PATH + "anvil.png",
		"displayname": "Anvil+1\n",
		"details": "Deflect 10% of damage",
		"prerequisite": ['anvil1'],
		"type": "item"
	},
	"anvil3": {
		"icon": ICON_PATH + "anvil.png",
		"displayname": "Anvil+2\n",
		"details": "Deflect 15% of damage",
		"prerequisite": ['anvil2'],
		"type": "item"
	},
	#endregion
}

const ABILITY = {
	"freezeblast1": {
		"icon": ABILITY_PATH + "freeze.png",
		"displayname": "Freeze Blast\n",
		"details": "Active: Freeze all enemies for 10 seconds",
		"prerequisite": [],
		"type": "Active"
	},
	"freezeblast2": {
		"icon": ABILITY_PATH + "freeze.png",
		"displayname": "Freeze Blast+\n",
		"details": "Active: Do 20 damage when freezing an enemy",
		"prerequisite": ['freezeblast1'],
		"type": "Active"
	},
	"rush1": {
		"icon": ABILITY_PATH + "rush.png",
		"displayname": "Rush B!\n",
		"details": "Active: Double Speed, 50% damage reduction for 5 seconds",
		"prerequisite": [],
		"type": "Active"
	},
	"rush2": {
		"icon": ABILITY_PATH + "rush.png",
		"displayname": "Rush B!+\n",
		"details": "Active: Nullify all damage and ability lasts 10 seconds",
		"prerequisite": ['rush1'],
		"type": "Active"
	},
	"dodge1": {
		"icon": ABILITY_PATH + "dodge.png",
		"displayname": "Roll\n",
		"details": "Secondary: Move towards the mouse cursor and dodge attacks",
		"prerequisite": [],
		"type": "Secondary"
	},
	"dodge2": {
		"icon": ABILITY_PATH + "dodge.png",
		"displayname": "Roll+\n",
		"details": "Secondary: You can dodge twice before the cooldown ends",
		"prerequisite": ['dodge1'],
		"type": "Secondary"
	},
	"windblast1": {
		"icon": ABILITY_PATH + "windblast.png",
		"displayname": "Wind Blast\n",
		"details": "Secondary: Push all enemies away from you",
		"prerequisite": [],
		"type": "Secondary"
	},
	"windblast2": {
		"icon": ABILITY_PATH + "windblast.png",
		"displayname": "Wind Blast+\n",
		"details": "Secondary: Push enemies you are facing farther away",
		"prerequisite": ['windblast1'],
		"type": "Secondary"
	},
	"lastchance1": {
		"icon": ABILITY_PATH + "lastchance.png",
		"displayname": "Last Chance\n",
		"details": "Passive: Before you die, get bullet time for 5 seconds",
		"prerequisite": [],
		"type": "Passive"
	},
	"lastchance2": {
		"icon": ABILITY_PATH + "lastchance.png",
		"displayname": "Last Chance+\n",
		"details": "Passive: You and your attacks move at full speed during bullet time",
		"prerequisite": ['lastchance1'],
		"type": "Passive"
	},
	"holy1": {
		"icon": ABILITY_PATH + "holy.png",
		"displayname": "Holy Orb\n",
		"details": "Passive: Decay takes twice as long to happen",
		"prerequisite": [],
		"type": "Passive"
	},
	"holy2": {
		"icon": ABILITY_PATH + "holy.png",
		"displayname": "Holy Orb+\n",
		"details": "Passive: Decay can only reduce your stats by 25%",
		"prerequisite": ['holy1'],
		"type": "Passive"
	},
	'nothing': {
		"icon": ABILITY_PATH + "nothing.png",
		"displayname": "MISSINGNO\n",
		"details": "Sorry Nothing",
		"prerequisite": [],
		"type": "Nothing"
	}

}