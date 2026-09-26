extends StaticBody3D

var is_aimed_at:bool = false
var state:int = 1
signal cutsceneSignal()
@onready var microwavedoor: AnimationPlayer = $blockbench_export/microwavedoor
@onready var open_timer: Timer = $openTimer
@onready var close_timer: Timer = $closeTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("interact")) and (is_aimed_at == true):
		if (Global.holdingTrashbag == false) and (Global.usingMicrowave == false):
			if Global.holdingChicken == false:
				if state == 1:
					microwavedoor.play("microwave_open")
					state += 1
				else:
					microwavedoor.play("microwave_close")
					state -= 1
			else:
				get_tree().change_scene_to_file("res://scenes/microwaveCutscene.tscn")

func _on_microwave_area_3d_area_entered(area: Area3D) -> void:
	is_aimed_at = true

func _on_microwave_area_3d_area_exited(area: Area3D) -> void:
	is_aimed_at = false

func _on_microwavecutscene_open_microwave() -> void:
	microwavedoor.play("microwave_open")
	open_timer.start()

func _on_open_timer_timeout() -> void:
	emit_signal("cutsceneSignal")


func _on_microwavecutscene_close_microwave() -> void:
	microwavedoor.play("microwave_close")
	Global.usingMicrowave = true
	close_timer.start()

func _on_close_timer_timeout() -> void:
	Global.microwave_timer.start()
	Global.microwavesounds.play()
	get_tree().change_scene_to_file("res://scenes/home.tscn")
