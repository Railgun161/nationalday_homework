extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	linear_velocity = Input.get_vector('left' , 'right' , 'up' , 'down') * 300
	if Input.is_action_pressed('sprint'):
		linear_velocity *= 2
