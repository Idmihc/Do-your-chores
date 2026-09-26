extends Node3D

@onready var label: Label = $CanvasLayer/Label

func  _ready() -> void:
	if Global.earlyEnd == true:
		label.visible = true
		
func _on_timer_timeout() -> void:
	if Global.tasksCompleted == 0:
		get_tree().change_scene_to_file("res://scenes/endingnotasks.tscn")
	elif Global.tasksCompleted == 5:
		get_tree().change_scene_to_file("res://scenes/endingalltasks.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/endingsometasks.tscn")
