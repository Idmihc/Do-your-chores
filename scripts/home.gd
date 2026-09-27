extends Node3D

var aimed_at_liv_table:bool = false
var aimed_at_din_table:bool = false
var aimed_at_trash:bool = false
var aimed_at_green_trash:bool = false
var aimed_at_plates:bool = false
@onready var time_label: Label = $CanvasLayer/timeLeft/timeLabel
@onready var trashcan_open: Node3D = $trashcan/trashcanOpen
@onready var trashcan_closed: Node3D = $trashcan/trashcanClosed
@onready var player: CharacterBody3D = $Player
@onready var livingroomtabledirt: Sprite3D = $livingroomTable/livingroomtabledirt
@onready var diningroomtabledirt: Sprite3D = $diningroomTable/diningroomtabledirt
@onready var chicken: Node3D = $chicken
@onready var greentrashclosed: Node3D = $greentrash/greentrashclosed
@onready var greentrashopen: Node3D = $greentrash/greentrashopen
@onready var collect_trash: AudioStreamPlayer3D = $collectTrash
@onready var dispose_trash: AudioStreamPlayer3D = $disposeTrash
@onready var plate_dirt: Sprite3D = $plates/plateDirt
@onready var plate_dirt_2: Sprite3D = $plates/plateDirt2
@onready var plates: Node3D = $plates
@onready var task_list: Control = $CanvasLayer/taskList
@onready var liv_tablebar: Sprite2D = $CanvasLayer/taskList/livingroomtable/livTablebar
@onready var din_tablebar: Sprite2D = $CanvasLayer/taskList/diningroomtable/dinTablebar
@onready var trashbar: Sprite2D = $CanvasLayer/taskList/takeoutTrash/trashbar
@onready var platesbar: Sprite2D = $CanvasLayer/taskList/cleanPlates/platesbar
@onready var chickenbar: Sprite2D = $CanvasLayer/taskList/chicken/chickenbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.started == false:
		Global.started = true
		Global.doom_timer.start()
	Global.inHome = true
	Global._music_play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.position = Global.playerPos
	player.rotation_degrees.y = Global.playerRot
	if Global.hasCleanedLiving == true:
		livingroomtabledirt.visible = false
		
	if Global.hasCleanedDining == true:
		diningroomtabledirt.visible = false
		
	if Global.hasDefrostedChicken == true:
		chicken.visible = true
		
	if (Global.holdingTrashbag == true) or (Global.hasTakenTrash == true):
		trashcan_open.visible = true
		trashcan_closed.visible = false
		
	if (Global.hasTakenTrash == true):
		greentrashclosed.visible = true
		greentrashopen.visible = false
	
	if Global.hasDonePlates == true:
		plate_dirt.visible = false
		plate_dirt_2.visible = false
		plates.position.z -= 2.6 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.secs_left < 10:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":0" + str(Global.secs_left)
	else:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":" + str(Global.secs_left)
	
	if Global.hasDefrostedChicken == true:
		chicken.visible = true
		
	if (Input.is_action_just_pressed("interact")) and (Global.holdingChicken == false):
		if (aimed_at_liv_table == true) and (Global.hasCleanedLiving == false) and (Global.holdingTrashbag == false):
			get_tree().change_scene_to_file("res://scenes/livingroomCutscene.tscn")
		elif (aimed_at_din_table == true) and (Global.hasCleanedDining == false) and (Global.holdingTrashbag == false):
			get_tree().change_scene_to_file("res://scenes/diningroomCutscene.tscn")
		elif (aimed_at_trash == true) and ((Global.holdingTrashbag == false) and (Global.hasTakenTrash == false)):
			Global.holdingTrashbag = true
			trashcan_open.visible = true
			trashcan_closed.visible = false
			collect_trash.play()
		elif (aimed_at_green_trash == true) and (Global.holdingTrashbag == true):
			Global.holdingTrashbag = false
			Global.hasTakenTrash = true
			Global.tasksCompleted += 1
			greentrashclosed.visible = true
			greentrashopen.visible = false
			dispose_trash.play()
		elif (aimed_at_plates == true) and (Global.holdingTrashbag == false) and (Global.hasDonePlates == false):
			get_tree().change_scene_to_file("res://scenes/washingdishestest.tscn")
	
	if Input.is_action_just_pressed("show"):
		if task_list.visible == true:
			task_list.visible = false
		else:
			task_list.visible = true
	
	if Global.hasCleanedDining == true:
		din_tablebar.visible = true
	if Global.hasCleanedLiving == true:
		liv_tablebar.visible = true
	if Global.hasDefrostedChicken == true:
		chickenbar.visible = true
	if Global.hasDonePlates == true:
		platesbar.visible = true
	if Global.hasTakenTrash == true:
		trashbar.visible = true
	

func _on_livingtable_area_area_entered(area: Area3D) -> void:
	aimed_at_liv_table = true

func _on_livingtable_area_area_exited(area: Area3D) -> void:
	aimed_at_liv_table = false

func _on_diningroom_area_area_entered(area: Area3D) -> void:
	aimed_at_din_table = true

func _on_diningroom_area_area_exited(area: Area3D) -> void:
	aimed_at_din_table = false
 
func _on_trashcan_area_area_entered(area: Area3D) -> void:
	aimed_at_trash = true

func _on_trashcan_area_area_exited(area: Area3D) -> void:
	aimed_at_trash = false

func _on_greentrash_area_3d_area_entered(area: Area3D) -> void:
	aimed_at_green_trash = true

func _on_greentrash_area_3d_area_exited(area: Area3D) -> void:
	aimed_at_green_trash = false

func _on_plate_area_area_entered(area: Area3D) -> void:
	aimed_at_plates = true

func _on_plate_area_area_exited(area: Area3D) -> void:
	aimed_at_plates = false
