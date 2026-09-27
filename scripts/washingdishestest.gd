extends Node3D

var mouseDistance:float = 0.0
var disScrubbed:float = 0.0
var washing:bool = false
var canScrubSound:bool = true
var waterPlaying:bool = false
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
	spongeNode.position = mousePos
	if Input.is_action_pressed("interact"):
		sponge.play("scrubbing")
		if (mousePos.x >= 800) and (mousePos.x <= 1100) and (mousePos.y >= 440) and (mousePos.y <= 750):
			bubbles.emitting = true
			if scrubbing_sound.playing == false:
				scrubbing_sound.pitch_scale = randf_range(0.75,1.25)
				scrubbing_sound.play()
		else:
			bubbles.emitting = false
	else:
		sponge.play("idle")
		bubbles.emitting = false
	
	if washing == false:
		disScrubbed = 0.0
	
	if plate_dirt.modulate.a < 0.05:
		plate_dirt.visible = false
	if plate_dirt_2.modulate.a < 0.05:
		plate_dirt_2.visible = false
	if plate_dirt_3.modulate.a < 0.05:
		plate_dirt_3.visible = false
	if plate_dirt_4.modulate.a < 0.05:
		plate_dirt_4.visible = false
	if plate_dirt_5.modulate.a < 0.05:
		plate_dirt_5.visible = false
	if plate_dirt_6.modulate.a < 0.05:
		plate_dirt_6.visible = false
	if plate_dirt_7.modulate.a < 0.05:
		plate_dirt_7.visible = false
	if plate_dirt_8.modulate.a < 0.05:
		plate_dirt_8.visible = false
	if plate_dirt_9.modulate.a < 0.05:
		plate_dirt_9.visible = false
	if plate_dirt_10.modulate.a < 0.05:
		plate_dirt_10.visible = false
	
	if waterPlaying == false:
		waterPlaying = true
		water.pitch_scale = randf_range(1.0,2.0)
		water.play()
		watertimer.start()
		

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousePos = event.position
		mouseDistance = event.relative.length()

func _on_watertimer_timeout() -> void:
	waterPlaying = false
