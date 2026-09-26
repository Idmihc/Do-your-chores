extends Node3D

var state:int = 1
var is_aimed_at:bool = false
@onready var door_move: AnimationPlayer = $doorMove
@onready var kick: AudioStreamPlayer3D = $kick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")) and (is_aimed_at == true):
		if Global.holdingChicken == false:
			if state == 1:
				state += 1
				door_move.play("open")
			elif state == 2:
				state -= 1
				door_move.play("closed")

func _on_door_area_area_entered(area: Area3D) -> void:
	is_aimed_at = true

func _on_door_area_area_exited(area: Area3D) -> void:
	is_aimed_at = false

func _on_no_task_ending_force_door_open() -> void:
	kick.play()
	door_move.play("open_fast")
