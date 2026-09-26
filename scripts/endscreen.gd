extends Node3D

var totalTime:float = 0.0
var seconds:float = 0.0
@onready var label_2: Label = $CanvasLayer/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	totalTime = 300.0 - Global.timeTaken
	if Global.tasksCompleted == 5:
		seconds = round(1000 * (totalTime - (60 * int(totalTime / 60))))
		seconds = seconds / 1000
		label_2.text = "time = " + str(int(totalTime / 60)) +":"+ str(seconds)
