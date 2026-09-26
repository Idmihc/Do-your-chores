extends Node3D

var mousePos:Vector2 = Vector2(0,0)
var mouseDis:float = 0.0
var tempDis:float = 0.0
var canPlayDust:bool = true
@onready var time_label: Label = $CanvasLayer/timeLeft/timeLabel
@onready var livingroomtabledirt: Sprite3D = $livingroomTable/livingroomtabledirt
@onready var duster: AnimatedSprite2D = $duster
@onready var dusting_sound: AudioStreamPlayer2D = $duster/dustingSound
@onready var dusting_timer: Timer = $duster/dustingTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	Global.playerPos = Vector3(3.25,1.126,3.7)
	Global.playerRot = 90
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.secs_left < 10:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":0" + str(Global.secs_left)
	else:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":" + str(Global.secs_left)
	
	duster.position = mousePos + Vector2(50,0)
	
	if Input.is_action_pressed("interact"):
		duster.play("dusting")
		if (mousePos.x >= 345) and (mousePos.x <= 1565):
			if (mousePos.y >= 140) and (mousePos.y <= 925):
				mouseDis += tempDis
				livingroomtabledirt.modulate.a = 2500/mouseDis
				if canPlayDust == true:
					canPlayDust = false
					dusting_timer.start()
					dusting_sound.pitch_scale = randf_range(1,2)
					dusting_sound.play()
	else:
		duster.play("idle")
	
	if livingroomtabledirt.modulate.a < 0.05:
		Global.hasCleanedLiving = true
		Global.tasksCompleted +=1
		get_tree().change_scene_to_file("res://scenes/home.tscn")
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousePos = event.position
		tempDis = event.relative.length()

func _on_dusting_timer_timeout() -> void:
	canPlayDust = true
