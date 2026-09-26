extends Node3D

var dialogueStarted:bool = false
var floatSpeed:float = 0.0
var rotSpeed:float = 0.0
var fridgeOpen:bool = false
var phase:int = 0
signal forceDoorOpen()
signal forceFridgeDoorOpen()
@onready var mother: AnimatedSprite3D = $Mother/Mother
@onready var animation_player: AnimationPlayer = $Mother/Mother/AnimationPlayer
@onready var mother_dialogue: Label = $CanvasLayer/motherDialogue
@onready var angry_red: Sprite2D = $CanvasLayer/angryRed
@onready var trashcan_open: Node3D = $trashcan/trashcanOpen
@onready var trashcan_closed: Node3D = $trashcan/trashcanClosed
@onready var trashcan: Node3D = $trashcan
@onready var fridge: StaticBody3D = $fridge
@onready var plate: Node3D = $plates/plate
@onready var end_timer: Timer = $endTimer
@onready var trashbag: AnimatedSprite2D = $CanvasLayer/trashbag
@onready var frozenchicken: Node3D = $Camera3D/frozenchicken
@onready var camera_3d: Camera3D = $Camera3D
@onready var plate_dirt: Sprite3D = $plates/plate/plateDirt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	mother.play("normal")
	emit_signal("forceDoorOpen")
	animation_player.play("walk")
	if (Global.hasTakenTrash == true) or (Global.holdingTrashbag == true):
		trashcan_closed.visible = false
		trashcan_open.visible = true
	if Global.holdingTrashbag == true:
		trashbag.visible = true
	if Global.holdingChicken == true:
		frozenchicken.visible = true
	if Global.hasDonePlates == true:
		plate_dirt.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")) and (dialogueStarted == true):
		if phase == 0:
			phase += 1
			if Global.holdingTrashbag == true:
				mother_dialogue.text = "You're holding the trash so I know you forgot to do your chores."
			elif Global.holdingChicken == true:
				mother_dialogue.text = "You're holding the chicken so I know you forgot to do your chores."
			elif Global.usingMicrowave == true:
				mother_dialogue.text = "I can hear the microwave so I know you forgot to do your chores."
			else:
				mother_dialogue.text = "You had all day to complete 5 chores and you couldn't."
		elif phase == 1:
			mother_dialogue.text = " "
			angry_red.visible = true
			mother.play("flying")
			animation_player.play("flight")
			floatSpeed = 0.002
			rotSpeed = 1
			end_timer.start()
	
	fridge.position.y += floatSpeed
	fridge.rotation_degrees.x -= rotSpeed/25
	fridge.position.z -= floatSpeed
	trashcan.position.y += floatSpeed
	plate.position.y += floatSpeed/2
	plate.position.x -= floatSpeed * 5
	plate.rotation_degrees.z += rotSpeed
	camera_3d.position.y += floatSpeed
	camera_3d.position.z -= floatSpeed * 1.5
	
	if (fridge.rotation_degrees.x <= -15) and (fridgeOpen == false):
		emit_signal("forceFridgeDoorOpen")
		fridgeOpen = true

func _on_dialogue_start_timer_timeout() -> void:
	dialogueStarted = true
	mother_dialogue.visible = true

func _on_end_timer_timeout() -> void:
	if Global.microwavesounds.playing == true:
		Global.microwavesounds.stop()
	get_tree().change_scene_to_file("res://scenes/youlose.tscn")
