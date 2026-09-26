extends Node3D

var beingwashed:bool = false
@onready var plate_dirt: Sprite3D = $plateDirt
@onready var sidecollision: Area3D = $sidecollision
@onready var wash_timer: Timer = $washTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plate_dirt.rotation_degrees.y = randi_range(0,359)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if beingwashed == true:
		plate_dirt.modulate.a = wash_timer.time_left/10.0
	
func _on_sidecollision_area_entered(area: Area3D) -> void:
	sidecollision.queue_free()
	wash_timer.start()
	beingwashed = true
