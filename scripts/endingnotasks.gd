extends Node3D

signal forceDoorOpen()
@onready var mother: AnimatedSprite3D = $Mother/Mother
@onready var animation_player: AnimationPlayer = $Mother/Mother/AnimationPlayer
@onready var trashbag: AnimatedSprite2D = $CanvasLayer/trashbag
@onready var frozenchicken: Node3D = $CanvasLayer/frozenchicken
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	mother.play("angry")
	emit_signal("forceDoorOpen")
	animation_player.play("kill")
	if Global.holdingChicken == true:
		frozenchicken.visible = true
	elif Global.holdingTrashbag == true:
		trashbag.visible = true


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/youlose.tscn")
