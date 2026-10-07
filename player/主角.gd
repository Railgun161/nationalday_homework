extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count:int = 0
@onready var sprite = $Sprite2D
@export var max_health: int = 3
var health: int
@onready var win = $"../Camera2D/win2"
var bullet_scene = preload("res://player/bullet_player.tscn")
@onready var shoot_cooldown = 0
@onready var gogogo_cooldown = 0
@onready var hearts = [
	$"../UI/HeartContainer/Heart1",
	$"../UI/HeartContainer/Heart2",
	$"../UI/HeartContainer/Heart3"
]
var heart_full = preload("res://player/FullHeart.png")
var heart_empty = preload("res://player/EmptyHeart.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	print('初始血量' , health)
	update_heart_ui()


func update_heart_ui():                          #显示血量
	for i in range(hearts.size()):
		if i < health:
			hearts[i].texture = heart_full
		else:
			hearts[i].texture = heart_empty 


func _physics_process(delta: float) -> void:
	var enermies = get_tree().get_nodes_in_group('mob')
	if not is_on_floor():
		velocity.y += gravity * delta    #重力加速度
	else :      #跳跃
		jump_count = 0
		velocity.y = 0
	velocity.x = Input.get_axis('left', 'right') * 300     #左右移动
	if Input.is_action_pressed("sprint") and enermies.is_empty():         #加速 Shift
		velocity.x *= 1.5
	if Input.is_action_just_pressed("gogogo") and enermies.is_empty() and gogogo_cooldown <= 0:       #瞬移 Ctrl
		global_position.x += velocity.x
		gogogo_cooldown = 0.75
	gogogo_cooldown -= delta
	if velocity.x != 0:              #转向
		sprite.flip_h = sign(velocity.x) < 0
	if Input.is_action_just_pressed("jump"):
		if jump_count < 3:          #三段跳
			velocity.y = -450
			jump_count += 1
	shoot_cooldown -= delta
	if Input.is_action_just_pressed('fire') and shoot_cooldown <= 0:        #发射
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		shoot_cooldown = 1
	move_and_slide()
	if win.visible == true:
		health = 3

func _process(delta: float) -> void:
	var enermies = get_tree().get_nodes_in_group('mob')
	if not enermies.is_empty() and global_position.y >= 680:        #掉落死亡
		health = 0
	update_heart_ui()
	if health <= 0:     #判断死亡
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:      #受伤
	if not body.is_in_group('player'): 
		return
	health -= 1
	if health >= 0:
		print('剩余血量' , health)       #展示剩余血量


func _on_go_down_body_entered(body: Node2D) -> void:
	var enermies = get_tree().get_nodes_in_group('mob')
	var boss = get_tree().get_nodes_in_group('boss')
	if enermies.is_empty():
		global_position.x = 4011
		global_position.y = 3185
