extends RigidBody2D
var velocity = Vector2.ZERO
@export var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("SpiderWalk")
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
func _delete_all_enemies():
	queue_free()

func enemyHit():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	GlobalValues.enemyKillCount += 1 
