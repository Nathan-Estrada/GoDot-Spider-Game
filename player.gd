extends Area2D
signal hit
signal game_over

@export var speed = 400
@export var projectile : PackedScene

var screen_size

#Every time a player is instantiated player's health is reset
var max_hp = GlobalValues.maxHP
var hp = max_hp

func _ready():
	screen_size = get_viewport_rect().size
	projectile = load("res://projectile.tscn")


func _process(delta):
	var velocity = Vector2.ZERO
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
		
	if Input.is_action_just_pressed("fire_weapon"):
		shoot()
	
	#Walk animation only plays during movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func shoot():
	var beam = projectile.instantiate()
	owner.add_child(beam)
	beam.transform = $Gun.global_transform
	
func _on_body_entered(body: Node2D):
	#Player only receives damage when touched by spider or ghost
	if body.has_method("enemyHit") or body.has_method("ghostHit"):
		$AudioStreamPlayer2D.play()
		GlobalValues.HP -= 1
		hit.emit()
		if GlobalValues.HP <= 0:
			queue_free()
			game_over.emit()
			$CollisionShape2D.set_deferred("disabled",true)
	
func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
