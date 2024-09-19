extends RigidBody2D
@export var speed = 300
var velocity = Vector2.ZERO
func _ready():
	$AnimatedSprite2D.play("haunt")
	$AudioStreamPlayer2D.play()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func ghostHit():
	hide()
	queue_free()
	GlobalValues.ghostCount -= 1
	GlobalValues.ghostKillCount += 1
	print("Ghosts remaining: ", GlobalValues.ghostCount)
	$CollisionShape2D.set_deferred("disabled", true)

func _process(delta):
	if position.y <= 0 or position.y > 648:
		turn_around()
	if position.x <= 0 or position.x > 1152:
		turn_around()
	
	linear_velocity = velocity.normalized() * speed	
	position += linear_velocity * delta
	
func turn_around():
	rotate(PI)
	setVelocity(-(linear_velocity))
	
func getVelocity():
	return velocity
	
func setVelocity(newVelocity):
	velocity = newVelocity

func screamTwo():
	pass
