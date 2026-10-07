extends Area2D
@onready var player = $"../player"
@onready var a = Vector2(1,0)
@onready var direction = a.normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * 450 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		if player.health >= 1:
			player.health -= 1
			print('剩余血量' , player.health)
	if body.is_in_group('player') or body.is_in_group('wall'):
		queue_free()
