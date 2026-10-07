extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"../player"
var max_health: int = 2
var health: int
@onready var sprite = $Sprite2D


func _ready() -> void:
	health = max_health


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta    #重力加速度
	else:               #向玩家跳跃
		velocity.y = -350
		var a = player.global_position - global_position
		var direction = a.normalized()
		velocity.x = direction.x * 400
	if velocity.x != 0:              #转向
		sprite.flip_h = sign(velocity.x) < 0
	move_and_slide()
	if health == 0:
		queue_free()
