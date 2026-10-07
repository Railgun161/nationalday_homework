extends Area2D
var direction: Vector2
var nearest_enermy = null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var boss = $"../boss"
	var enermies = get_tree().get_nodes_in_group('mob')           #定位敌人位置
	var bosses = get_tree().get_nodes_in_group('boss')
	if enermies.is_empty():
		if bosses.is_empty():
			queue_free()               #没敌人不发射
			return
		else:
			var dir = boss.global_position - global_position
			direction = dir.normalized()
	else:
		var d0 = INF
		for enermy in enermies:
			if global_position.distance_squared_to(enermy.global_position) < d0:
				d0 = global_position.distance_squared_to(enermy.global_position)
				nearest_enermy = enermy
		var dir = nearest_enermy.global_position - global_position
		direction = dir.normalized()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * 350 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('mob') or body.is_in_group('boss'):
		body.health -= 1
	if body.is_in_group('mob') or body.is_in_group('wall') or body.is_in_group('boss'):
		queue_free()
