extends RigidBody2D
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("CivWalk")

func civilianHit():
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	GlobalValues.civKillCount += 1
	
func _delete_all_civilians():
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
