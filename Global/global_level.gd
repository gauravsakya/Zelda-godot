extends Node

# Player stats
signal level_changed
signal exp_changed

# Player stats
var current_level: int = 1:
	set(value):
		current_level = value
		emit_signal("level_changed")

var current_exp: int = 0:
	set(value):
		current_exp = value
		emit_signal("exp_changed")

var exp_to_next_level: int = 100

func _ready():
	update_exp_requirements()

# Add experience points
func add_exp(amount: int):
	current_exp += amount
	check_level_up()

# Check if player should level up
func check_level_up():
	if current_exp >= exp_to_next_level:
		level_up()

func level_up():
	current_exp -= exp_to_next_level
	current_level += 1
	update_exp_requirements()
	check_level_up()
	
func update_exp_requirements():
	# Simple formula: base 100 + 50 per level
	exp_to_next_level = 100 + (current_level * 50)
