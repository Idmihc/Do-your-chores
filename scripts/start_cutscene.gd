extends Node3D

@onready var phone_screen: AnimatedSprite2D = $Phone/phoneScreen
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	phone_screen.play("scroll")
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/home.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/home.tscn")
