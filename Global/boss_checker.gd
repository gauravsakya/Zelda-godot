extends Node3D

func _process(delta):
	var boss_exists = false
	var other_enemies_exist = false
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if is_instance_valid(enemy):
			if enemy.is_in_group("boss"):
				boss_exists = true
			else:
				other_enemies_exist = true
	
	# If boss is dead and no other enemies exist
	if not boss_exists and not other_enemies_exist:
		get_tree().change_scene_to_file("res://scenes/levels/menu/menu.tscn")
