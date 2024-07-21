extends Panel

var collected_abilities = []
var ability_options = []

func handle_ability():
	for i in 3:
		var option_choice = get_node("TextureContainer/Item" + str(i))
		option_choice.new_option(get_random_ability())

func get_random_ability():
	var dblist = []
	for i in EquipmentDB.ABILITY:
		if i in collected_abilities:
			pass
		elif i in ability_options:
			pass
		elif EquipmentDB.ABILITY[i]["type"] == "Nothing":
			pass
		elif EquipmentDB.ABILITY[i]["prerequisite"].size() > 0:
			var to_add = true
			for n in EquipmentDB.ABILITY[i]["prerequisite"]:
				if not n in collected_abilities:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		ability_options.append(randomitem)
		return randomitem
	else:
		return null

func reset_panel(selected_upgrade):
	collected_abilities.append(selected_upgrade)
	ability_options = []
	self.visible = false