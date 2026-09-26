extends Node3D

signal openFridge()
signal closeFridge()
@onready var move_chicken_timer: Timer = $moveChickenTimer
@onready var time_label: Label = $CanvasLayer/timeLeft/timeLabel
@onready var frozenchickenanimations: AnimationPlayer = $Camera3D/frozenchicken/frozenchickenanimations
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.collectedChicken = true
	Global.inHome = false
	Global.playerPos = Vector3(0.561,1.126,-4.7)
	Global.playerRot = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("openFridge")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.secs_left < 10:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":0" + str(Global.secs_left)
	else:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":" + str(Global.secs_left)

func _on_fridge_move_chicken() -> void:
	frozenchickenanimations.play("collect")
	move_chicken_timer.start()

func _on_move_chicken_timer_timeout() -> void:
	emit_signal("closeFridge")
	Global.holdingChicken = true
