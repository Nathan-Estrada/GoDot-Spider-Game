extends RigidBody2D
@export var speed = 300
var velocity = Vector2.ZERO
var velocity_offset = Vector2.ZERO
var new_velocity
var screen_size

func _ready():
	$AnimatedSprite2D.play("haunt") #Ghost scream plays upon instantiating
	$AudioStreamPlayer2D.play()
	screen_size = get_viewport_rect().size

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func ghostHit():
	hide()
	queue_free()
	#Following 2 global values used for determining when game ends
	GlobalValues.ghostCount -= 1
	GlobalValues.ghostKillCount += 1
	$CollisionShape2D.set_deferred("disabled", true)

#Unlike spiders and civilians, ghosts are to stay within screen bounds
func _process(delta):
	if position.y > screen_size.y:
		position.y = screen_size.y
		turn_around()
	if position.y < 0:
		position.y = 0
		turn_around()
	if position.x > screen_size.x:
		position.x = screen_size.x
		turn_around()
	if position.x < 0:
		position.x = 0
		turn_around()
		
	linear_velocity = velocity.normalized() * speed	
	position += linear_velocity * delta
	
func turn_around():
	setVelocity(Vector2.ZERO)
	rotate(PI)
	new_velocity = -(linear_velocity)
	setVelocity(new_velocity)
	
func getVelocity():
	return velocity
	
func setVelocity(newVelocity):
	velocity = newVelocity
