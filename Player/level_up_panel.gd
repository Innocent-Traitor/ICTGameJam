extends Panel

var collected_upgrades = []
var upgrade_options = []


func handle_levelup():
	for i in 3:
		var option_choice = get_node("TextureContainer/Item" + str(i))
		option_choice.new_option(get_random_item())

func get_random_item():
	var dblist = []
	for i in EquipmentDB.UPGRADES:
		if i in collected_upgrades: # Find already collected upgrades
			pass
		elif i in upgrade_options: # If the upgrade is already an option
			pass
		elif EquipmentDB.UPGRADES[i]["type"] == "food": # Don't pick food
			pass
		elif EquipmentDB.UPGRADES[i]["prerequisite"].size() > 0: # Check for prerequisite
			var to_add = true
			for n in EquipmentDB.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades: # Checks to see if prerequisite is fulfilled
					to_add = false # if they aren't, don't add
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0: # Makes sure we have an avaiable upgrade
		var randomitem = dblist.pick_random() # Pick a random one
		upgrade_options.append(randomitem) # Add that item to the upgrade_options
		return randomitem # return the item for the item_option
	else:
		return null # This will make it so it's food if they have no other options

func reset_levelup(selected_upgrade):
	collected_upgrades.append(selected_upgrade)
	upgrade_options = []
	self.visible = false