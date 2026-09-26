extends Node3D

var canplaywater:bool = true
@onready var time_label: Label = $CanvasLayer/timeLeft/timeLabel
@onready var animation_plate_5: AnimationPlayer = $animationPlate5
@onready var timer: Timer = $Timer
@onready var water: AudioStreamPlayer3D = $water
@onready var watertimer: Timer = $watertimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.playerPos = Vector3(5.5,1.126,-3.7)
	Global.playerRot = 90
	animation_plate_5.play("wash")
	timer.start()

#1200 to 1540, 440 to 740
#1545 to 1920, 440 to 740
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.secs_left < 10:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":0" + str(Global.secs_left)
	else:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":" + str(Global.secs_left)
	
	if canplaywater == true:
		canplaywater = false
		water.pitch_scale = randf_range(1.0,2.0)
		water.play()
		watertimer.start()
	
func _on_timer_timeout() -> void:
	Global.hasDonePlates = true
	Global.tasksCompleted += 1
	get_tree().change_scene_to_file("res://scenes/home.tscn")

func _on_watertimer_timeout() -> void:
	canplaywater = true
