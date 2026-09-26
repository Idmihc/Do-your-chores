extends Node3D

signal forceDoorOpen()
@onready var mother: AnimatedSprite3D = $Mother/Mother
@onready var animation_player: AnimationPlayer = $Mother/Mother/AnimationPlayer
@onready var mother_dialogue: Label = $CanvasLayer/motherDialogue
@onready var dialogue_start_timer: Timer = $dialogueStartTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mother.play("normal")
	emit_signal("forceDoorOpen")
	animation_player.play("walk")
	dialogue_start_timer.start()

func  _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if mother_dialogue.text == "You completed all your chores.":
			mother_dialogue.text = "Good job!"
		elif mother_dialogue.text == "Good job!":
			get_tree().change_scene_to_file("res://scenes/youwin.tscn")

func _on_dialogue_start_timer_timeout() -> void:
	mother_dialogue.text = "You completed all your chores."
