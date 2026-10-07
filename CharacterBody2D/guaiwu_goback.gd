extends CharacterBody2D
var bullet_scene = preload("res://CharacterBody2D/bullet.tscn")
var max_health: int = 2
var health: int
@onready var sprite = $Sprite2D


func _ready() -> void:
	velocity.x = -250      #移动速度
	health = max_health


func _physics_process(delta: float) -> void:
	if velocity.x != 0:              #转向
		sprite.flip_h = sign(velocity.x) < 0
	move_and_slide()

func _process(delta: float) -> void:
	if health == 0:
		queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group('mob'):            #往返
		return
	velocity.x = -velocity.x


func _on_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
