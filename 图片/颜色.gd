extends RigidBody2D
var a:float = 0
var b:float = 0
var c:float = 0
var d:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	a += 0.001
	b -= 0.001
	c -= 0.001
	d += 0.001
	modulate = Color(a,b,c,d)
