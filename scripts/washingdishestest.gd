extends Node3D

var mouseDistance:float = 0.0
var disScrubbed:float = 0.0
var washing:bool = false
var canScrubSound:bool = true
var waterPlaying:bool = false
var currentPlate:int = 11
var started10:bool = false
var finished10:bool = false
var started9:bool = false
var finished9:bool = false
var started8:bool = false
var finished8:bool = false
var started7:bool = false
var finished7:bool = false
var started6:bool = false
var finished6:bool = false
var started5:bool = false
var finished5:bool = false
var started4:bool = false
var finished4:bool = false
var started3:bool = false
var finished3:bool = false
var started1:bool = false
var finished1:bool = false
var started2:bool = false
var finished2:bool = false
var mousePos:Vector2 = Vector2(0.0,0.0)
@onready var spongeNode: Node2D = $spongeNode
@onready var scrubbing_sound: AudioStreamPlayer3D = $scrubbingSound
@onready var sponge: AnimatedSprite2D = $spongeNode/sponge
@onready var bubbles: GPUParticles2D = $spongeNode/bubbles
@onready var water: AudioStreamPlayer3D = $water
@onready var watertimer: Timer = $watertimer
@onready var plate: Node3D = $plates/plate
@onready var plate_2: Node3D = $plates/plate2
@onready var plate_3: Node3D = $plates/plate3
@onready var plate_4: Node3D = $plates/plate4
@onready var plate_5: Node3D = $plates/plate5
@onready var plate_6: Node3D = $plates/plate6
@onready var plate_7: Node3D = $plates/plate7
@onready var plate_8: Node3D = $plates/plate8
@onready var plate_9: Node3D = $plates/plate9
@onready var plate_10: Node3D = $plates/plate10
@onready var plate_dirt: Sprite3D = $plates/plate/plateDirt
@onready var plate_dirt_2: Sprite3D = $plates/plate2/plateDirt2
@onready var plate_dirt_3: Sprite3D = $plates/plate3/plateDirt3
@onready var plate_dirt_4: Sprite3D = $plates/plate4/plateDirt4
@onready var plate_dirt_5: Sprite3D = $plates/plate5/plateDirt5
@onready var plate_dirt_6: Sprite3D = $plates/plate6/plateDirt6
@onready var plate_dirt_7: Sprite3D = $plates/plate7/plateDirt7
@onready var plate_dirt_8: Sprite3D = $plates/plate8/plateDirt8
@onready var plate_dirt_9: Sprite3D = $plates/plate9/plateDirt9
@onready var plate_dirt_10: Sprite3D = $plates/plate10/plateDirt10
@onready var time_label: Label = $CanvasLayer/timeLeft/timeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	Global.playerPos = Vector3(5.5,1.126,-3.7)
	Global.playerRot = 90
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	plate_dirt.rotation_degrees.y = randi_range(0,359)
	plate_dirt_2.rotation_degrees.y = randi_range(0,359)
	plate_dirt_3.rotation_degrees.y = randi_range(0,359)
	plate_dirt_4.rotation_degrees.y = randi_range(0,359)
	plate_dirt_5.rotation_degrees.y = randi_range(0,359)
	plate_dirt_6.rotation_degrees.y = randi_range(0,359)
	plate_dirt_7.rotation_degrees.y = randi_range(0,359)
	plate_dirt_8.rotation_degrees.y = randi_range(0,359)
	plate_dirt_9.rotation_degrees.y = randi_range(0,359)
	plate_dirt_10.rotation_degrees.y = randi_range(0,359)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.secs_left < 10:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":0" + str(Global.secs_left)
	else:
		time_label.text = "Time until mom comes home: " + str(Global.mins_left) + ":" + str(Global.secs_left)
	
	spongeNode.position = mousePos
	if (Input.is_action_just_pressed("interact")) and (washing == false):
		currentPlate -= 1
		if (currentPlate == 10) and (started10 == false):
			started10 = true
			plate_10.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 9) and (started9 == false):
			started9 = true
			plate_9.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 8) and (started8 == false):
			started8 = true
			plate_8.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 7) and (started7 == false):
			started7 = true
			plate_7.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 6) and (started6 == false):
			started6 = true
			plate_6.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 5) and (started5 == false):
			started5 = true
			plate_5.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 4) and (started4 == false):
			started4 = true
			plate_4.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 3) and (started3 == false):
			started3 = true
			plate_3.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 2) and (started2 == false):
			started2 = true
			plate_2.position = Vector3(6.896,2.442,-3.725)
		elif (currentPlate == 1) and (started1 == false):
			started1 = true
			plate.position = Vector3(6.896,2.442,-3.725)
		
	if Input.is_action_pressed("interact"):
		sponge.play("scrubbing")
		if (washing == true) and (mousePos.x >= 800) and (mousePos.x <= 1100) and (mousePos.y >= 475) and (mousePos.y <= 750):
			bubbles.emitting = true
			disScrubbed += mouseDistance
			if scrubbing_sound.playing == false:
				scrubbing_sound.pitch_scale = randf_range(0.75,1.25)
				scrubbing_sound.play()
			
			if finished10 == false:
				plate_dirt_10.modulate.a = 750/disScrubbed
			elif finished9 == false:
				plate_dirt_9.modulate.a = 750/disScrubbed
			elif finished8 == false:
				plate_dirt_8.modulate.a = 750/disScrubbed
			elif finished7 == false:
				plate_dirt_7.modulate.a = 750/disScrubbed
			elif finished6 == false:
				plate_dirt_6.modulate.a = 750/disScrubbed
			elif finished5 == false:
				plate_dirt_5.modulate.a = 750/disScrubbed
			elif finished4 == false:
				plate_dirt_4.modulate.a = 750/disScrubbed
			elif finished3 == false:
				plate_dirt_3.modulate.a = 750/disScrubbed
			elif finished2 == false:
				plate_dirt_2.modulate.a = 750/disScrubbed
			elif finished1 == false:
				plate_dirt.modulate.a = 750/disScrubbed
		else:
			bubbles.emitting = false
	else:
		sponge.play("idle")
		bubbles.emitting = false
	
	if plate_dirt.modulate.a < 0.075 and currentPlate == 1:
		disScrubbed = 0.0
		plate_dirt.visible = false
		plate.position = Vector3(6.896,2.446,-4.8)
		finished1 = true
	if plate_dirt_2.modulate.a < 0.075 and currentPlate == 2:
		disScrubbed = 0.0
		plate_dirt_2.visible = false
		plate_2.position = Vector3(6.896,2.366,-4.8)
		finished2 = true
	if plate_dirt_3.modulate.a < 0.075 and currentPlate == 3:
		disScrubbed = 0.0
		plate_dirt_3.visible = false
		plate_3.position = Vector3(6.896,2.286,-4.8)
		finished3 = true
	if plate_dirt_4.modulate.a < 0.075 and currentPlate == 4:
		disScrubbed = 0.0
		plate_dirt_4.visible = false
		plate_4.position = Vector3(6.896,2.206,-4.8)
		finished4 = true
	if plate_dirt_5.modulate.a < 0.075 and currentPlate == 5:
		disScrubbed = 0.0
		plate_dirt_5.visible = false
		plate_5.position = Vector3(6.896,2.126,-4.8)
		finished5 = true
	if plate_dirt_6.modulate.a < 0.075 and currentPlate == 6:
		disScrubbed = 0.0
		plate_dirt_6.visible = false
		plate_6.position = Vector3(6.896,2.446,-5.6)
		finished6 = true
	if plate_dirt_7.modulate.a < 0.075 and currentPlate == 7:
		disScrubbed = 0.0
		plate_dirt_7.visible = false
		plate_7.position = Vector3(6.896,2.366,-5.6)
		finished7 = true
	if plate_dirt_8.modulate.a < 0.075 and currentPlate == 8:
		disScrubbed = 0.0
		plate_dirt_8.visible = false
		plate_8.position = Vector3(6.896,2.286,-5.6)
		finished8 = true
	if plate_dirt_9.modulate.a < 0.075 and currentPlate == 9:
		disScrubbed = 0.0
		plate_dirt_9.visible = false
		plate_9.position = Vector3(6.896,2.206,-5.6)
		finished9 = true
	if plate_dirt_10.modulate.a < 0.075 and currentPlate == 10:
		disScrubbed = 0.0
		plate_dirt_10.visible = false
		plate_10.position = Vector3(6.896,2.126,-5.6)
		finished10 = true
	
	if waterPlaying == false:
		waterPlaying = true
		water.pitch_scale = randf_range(1.0,2.0)
		water.play()
		watertimer.start()
		
	if finished1 == true:
		Global.hasDonePlates = true
		get_tree().change_scene_to_file("res://scenes/home.tscn")
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousePos = event.position
		mouseDistance = event.relative.length()

func _on_watertimer_timeout() -> void:
	waterPlaying = false

func _on_in_sink_area_entered(area: Area3D) -> void:
	washing = true

func _on_in_sink_area_exited(area: Area3D) -> void:
	washing = false
