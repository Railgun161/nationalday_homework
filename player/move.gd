extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count:int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else :
		jump_count = 0
		velocity.y = 0
	velocity.x = Input.get_axis('left', 'right') * 300
	if Input.is_action_just_pressed("jump"):
		if jump_count < 3:
			velocity.y -= 400
			jump_count += 1
	
	move_and_slide()
