extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"../player"
@onready var win = $"../Camera2D/win2"
@onready var hearts = $"../UI/HeartContainer"
var bullet_scene1 = preload("res://CharacterBody2D/boss/bullet1_boss.tscn")
var bullet_scene2 = preload("res://CharacterBody2D/boss/bullet2_boss.tscn")
var bullet_scene3 = preload("res://CharacterBody2D/boss/bullet3_boss.tscn")
var bullet_scene4 = preload("res://CharacterBody2D/boss/bullet4_boss.tscn")
var bullet_scene5 = preload("res://CharacterBody2D/boss/bullet5_boss.tscn")
var bullet_scene6 = preload("res://CharacterBody2D/boss/bullet6_boss.tscn")
var bullet_scene7 = preload("res://CharacterBody2D/boss/bullet7_boss.tscn")
var bullet_scene8 = preload("res://CharacterBody2D/boss/bullet8_boss.tscn")
var bullet_scene = preload("res://CharacterBody2D/bullet.tscn")
var max_health: int = 4
var health: int


func _ready() -> void:
	health = max_health


func _process(delta: float) -> void:
	if health == 0:
		queue_free()
		win.visible = true
		hearts.visible = false



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta    #重力加速度
	else:               #向玩家跳跃
		velocity.y = -400
		var a = player.global_position - global_position
		var direction = a.normalized()
		velocity.x = direction.x * 400
	move_and_slide()


func _on_timer_timeout() -> void:          
	var a = player.global_position - global_position
	var direction = a.normalized()
	global_position.x += direction.x * 700
	
	a = player.global_position - global_position
	direction = a.normalized()
	velocity.x = direction.x * 400
	move_and_slide()
	
	var bullet1 = bullet_scene1.instantiate()               #发射一堆子弹
	bullet1.global_position = global_position
	get_tree().current_scene.add_child(bullet1)
	var bullet2 = bullet_scene2.instantiate()
	bullet2.global_position = global_position
	get_tree().current_scene.add_child(bullet2)
	var bullet3 = bullet_scene3.instantiate()
	bullet3.global_position = global_position
	get_tree().current_scene.add_child(bullet3)
	var bullet4 = bullet_scene4.instantiate()
	bullet4.global_position = global_position
	get_tree().current_scene.add_child(bullet4)
	var bullet5 = bullet_scene5.instantiate()
	bullet5.global_position = global_position
	get_tree().current_scene.add_child(bullet5)
	var bullet6 = bullet_scene6.instantiate()
	bullet6.global_position = global_position
	get_tree().current_scene.add_child(bullet6)
	var bullet7= bullet_scene7.instantiate()
	bullet7.global_position = global_position
	get_tree().current_scene.add_child(bullet7)
	var bullet8 = bullet_scene8.instantiate()
	bullet8.global_position = global_position
	get_tree().current_scene.add_child(bullet8)
