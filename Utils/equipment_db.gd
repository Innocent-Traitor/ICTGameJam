const WEAPON_PATH = "res://Sprites/Items/Weapons/"
const ICON_PATH = "res://Sprites/Items/Upgrades/"
const ABILITY_PATH = "res://Sprites/Items/Abilities/"
const UPGRADES = {
		# Sword
	"sword1": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword",
		"details": "A sword slashed where you are aiming",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"sword2": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+1",
		"details": "Deal an extra 3 damage",
		"level": "Level: 2",
		"prerequisite": ["sword1"],
		"type": "weapon"
	},
	"sword3": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+2",
		"details": "Slash the sword a second time",
		"level": "Level: 3",
		"prerequisite": ["sword2"],
		"type": "weapon"
	},
	"sword4": {
		"icon": WEAPON_PATH + "sword.png",
		"displayname": "Sword+3",
		"details": "Slash 3 times total and deal 5 extra damage",
		"level": "Level: 4",
		"prerequisite": ["sword3"],
		"type": "weapon"
	},
	"bow1": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow",
		"details": "Randomly shoot an arrow at an enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"bow2": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow",
		"details": "Shot another arrow and do an extra 2 damage",
		"level": "Level: 2",
		"prerequisite": ["bow1"],
		"type": "weapon"
	},
	"bow3": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow",
		"details": "Shoot 2 more arrows",
		"level": "Level: 3",
		"prerequisite": ["bow2"],
		"type": "weapon"
	},
	"bow4": {
		"icon": WEAPON_PATH + "bow.png",
		"displayname": "Bow",
		"details": "Shot 1 more arrow and do an extra 3 damage",
		"level": "Level: 4",
		"prerequisite": ["bow3"],
		"type": "weapon"
	},
}