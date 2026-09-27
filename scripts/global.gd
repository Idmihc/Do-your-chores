extends Node

var defrosted_chicken:bool = false
var defrost_time:float = 30
var mins_left:int = 5
var secs_left:int = 0
var can_update_mins:bool = true
var started:bool = false
var inHome:bool = false
var collectedChicken = false
var holdingChicken:bool = false
var holdingTrashbag:bool = false
var usingMicrowave:bool = false
var tasksCompleted:int = 0
var hasDonePlates:bool = false
var hasDefrostedChicken:bool = false
var hasTakenTrash:bool = false
var hasCleanedLiving:bool = false
var hasCleanedDining:bool = false
var playerPos:Vector3 = Vector3(-1.0, 2.5, 0.0)
var playerRot:int = 0
var earlyEnd:bool = false
var timeRecorded:bool = false
var timeTaken:float = 0.0
@onready var pause_overlay: CanvasLayer = $pauseOverlay
@onready var doom_timer: Timer = $doomTimer
@onready var minute_update: Timer = $minuteUpdate
@onready var gameplay_song: AudioStreamPlayer = $gameplaySong
@onready var microwave_timer: Timer = $microwaveTimer
@onready var microwavesounds: AudioStreamPlayer3D = $microwavesounds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#pausing and unpausing
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			pause_overlay.visible = true
			get_tree().paused = true
			if inHome == true:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			pause_overlay.visible = false
			get_tree().paused = false
			if inHome == true:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	#updating the timer when not paused
	if (get_tree().paused == false) and (started == true):
		secs_left = roundi(doom_timer.time_left)%60
		if (secs_left == 59) and (mins_left > 0) and (can_update_mins == true):
			mins_left -= 1
			can_update_mins = false
			minute_update.start()
	
	if (tasksCompleted == 5) and (timeRecorded == false):
		timeTaken = doom_timer.time_left
		timeRecorded = true
	if (earlyEnd == false) and (doom_timer.time_left > 10) and (tasksCompleted == 5):
		earlyEnd = true
		get_tree().change_scene_to_file("res://scenes/limbo.tscn")

func _on_minute_update_timeout() -> void:
	can_update_mins = true

func _music_play() -> void:
	if gameplay_song.playing == false:
		gameplay_song.play()

func _on_microwave_timer_timeout() -> void:
	hasDefrostedChicken = true
	usingMicrowave = false
	tasksCompleted +=1

func _on_doom_timer_timeout() -> void:
	gameplay_song.stop()
	get_tree().change_scene_to_file("res://scenes/limbo.tscn")
