extends Control

@onready var time_count: Label = $TimeCount

var time = 0

func _on_level_time_timeout() -> void:
	time += 1
	time_count.text = str(time)  
