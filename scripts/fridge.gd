extends StaticBody3D

var is_aimed_at: bool = false
var state:int = 1
signal moveChicken()
@onready var fridge_area: Area3D = $fridgeArea
@onready var fridge_door: AnimationPlayer = $blockbench_export/fridgeDoor
@onready var cutscene_timer: Timer = $cutsceneTimer
@onready var closedoor_timer: Timer = $closedoorTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")) and (is_aimed_at == true):
		if (Global.holdingTrashbag == false) and (Global.holdingChicken == false):
			if Global.collectedChicken == true:
				if state == 1:
					fridge_door.play("fridge_open")
					state += 1
				else:
					fridge_door.play("fridge_close")
					state -= 1
			else:
				get_tree().change_scene_to_file("res://scenes/fridgeCutscene.tscn")
			

func _on_fridge_area_area_entered(body: Node3D) -> void:
	is_aimed_at = true

func _on_fridge_area_area_exited(body: Node3D) -> void:
	is_aimed_at = false

func _on_fridgecutscene_open_fridge() -> void:
	fridge_door.play("fridge_open")
	cutscene_timer.start()

func _on_cutscene_timer_timeout() -> void:
	emit_signal("moveChicken")

func _on_fridgecutscene_close_fridge() -> void:
	fridge_door.play("fridge_close")
	closedoor_timer.start()

func _on_closedoor_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/home.tscn")

func _on_some_task_ending_force_door_open() -> void:
	fridge_door.play("fridge_open")
