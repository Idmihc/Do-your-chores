extends CharacterBody3D


const SPEED:float = 5.0
const mouse_sensitivity:float = -0.001
@onready var trashbag: AnimatedSprite2D = $crosshair/trashbag
@onready var frozenchicken: Node3D = $Camera3D/frozenchicken
@onready var crosshair: Sprite2D = $crosshair/crosshair

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("right", "left", "backwards", "forward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Global.holdingTrashbag == true:
		trashbag.visible = true
	else:
		trashbag.visible = false
	if Global.holdingChicken == true:
		frozenchicken.visible = true
		crosshair.visible = false
	else:
		frozenchicken.visible = false
		crosshair.visible = true
	
	move_and_slide()

func  _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y += event.relative.x * mouse_sensitivity
