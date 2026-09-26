extends Node3D


func _on_timer_timeout() -> void:
	if Global.tasksCompleted == 0:
		get_tree().change_scene_to_file("res://scenes/endingnotasks.tscn")
	elif Global.tasksCompleted == 5:
		get_tree().change_scene_to_file("res://scenes/endingalltasks.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/endingsometasks.tscn")
