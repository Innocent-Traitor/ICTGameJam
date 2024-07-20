const WEAPON_PATH = "res://Sprites/Items/Weapons/"
const ICON_PATH = "res://Sprites/Items/Upgrades/"
const ABILITY_PATH = "res://Sprites/Items/Abilities/"
const UPGRADES = {
		# Sword
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
		# Bow
	# "bow1": {
	# 	"icon": WEAPON_PATH + "bow.png",
	# 	"displayname": "Bow",
	# 	"details": "Randomly shoot an arrow at an enemy",
	# 	"prerequisite": [],
	# 	"type": "weapon"
	# },
	# "bow2": {
	# 	"icon": WEAPON_PATH + "bow.png",
	# 	"displayname": "Bow",
	# 	"details": "Shot another arrow and do an extra 2 damage",
	# 	"prerequisite": ["bow1"],
	# 	"type": "weapon"
	# },
	# "bow3": {
	# 	"icon": WEAPON_PATH + "bow.png",
	# 	"displayname": "Bow",
	# 	"details": "Shoot 2 more arrows",
	# 	"prerequisite": ["bow2"],
	# 	"type": "weapon"
	# },
	# "bow4": {
	# 	"icon": WEAPON_PATH + "bow.png",
	# 	"details": "Shot 1 more arrow and do an extra 3 damage",
	# 	"level": "Level: 4",
	# 	"prerequisite": ["bow3"],
	# 	"type": "weapon"
	# },
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
	


}