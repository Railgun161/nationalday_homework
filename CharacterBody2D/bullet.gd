extends Area2D
@onready var player = $"../player"
@onready var a = player.global_position - global_position
@onready var direction = a.normalized()
@onready var win_label = $"../Camera2D/win2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * 400 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player') or body.is_in_group('wall'):
		queue_free()
	if win_label.visible:
		return
	if body.is_in_group('player'):
		player.health -= 1
		if player.health >=0:
			print('剩余血量' , player.health)
