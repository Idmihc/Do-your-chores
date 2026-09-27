extends Node3D

var mouseDistance:float = 0.0
var disScrubbed:float = 0.0
var washing:bool = false
var canScrubSound:bool = true
var waterPlaying:bool = false
var mousePos:Vector2 = Vector2(0.0,0.0)
@onready var spongeNode: Node2D = $spongeNode
@onready var scrubbing_sound: AudioStreamPlayer3D = $sponge/scrubbingSound
@onready var scrubbing_timer: Timer = $sponge/scrubbingTimer
@onready var sponge: AnimatedSprite2D = $spongeNode/sponge
@onready var bubbles: GPUParticles2D = $spongeNode/bubbles
@onready var water: AudioStreamPlayer3D = $water
@onready var watertimer: Timer = $watertimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inHome = false
	Global.playerPos = Vector3(5.5,1.126,-3.7)
	Global.playerRot = 90
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spongeNode.position = mousePos
	if Input.is_action_pressed("interact"):
		sponge.play("scrubbing")
		bubbles.emitting = true
		if canScrubSound == true:
			canScrubSound = false
			scrubbing_sound.pitch_scale = randf_range(0.75,1.25)
			scrubbing_sound.play()
			scrubbing_timer.start()
	else:
		sponge.play("idle")
		bubbles.emitting = false
	
	if waterPlaying == false:
		waterPlaying = true
		water.pitch_scale = randf_range(1.0,2.0)
		water.play()
		watertimer.start()
		

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousePos = event.position
		mouseDistance = event.relative.length()

func _on_scrubbing_timer_timeout() -> void:
	canScrubSound = true

func _on_watertimer_timeout() -> void:
	waterPlaying = false
