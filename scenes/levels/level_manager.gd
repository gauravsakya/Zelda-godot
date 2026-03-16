extends Node3D

var scenes = [
	"res://scenes/levels/inherited levels/desert/overworldDesert.tscn",
	"res://scenes/levels/inherited levels/christmas/christmas.tscn",
	"res://scenes/levels/overworld.tscn"
]

func _on_timer_timeout() -> void:
	var current_scene = get_tree().current_scene.scene_file_path
	
	if current_scene == scenes[1]: # If current scene is Christmas
		get_tree().change_scene_to_file(scenes[0]) # Change to Desert
	else:
		# Default behavior - change to Christmas
		get_tree().change_scene_to_file(scenes[1])
