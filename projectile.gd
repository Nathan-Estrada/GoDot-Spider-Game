extends Area2D

var speed = 750

func _ready():
	$AudioStreamPlayer2D.play()

func _process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if (body.has_method("enemyHit")):
		body.enemyHit()
	elif (body.has_method("civilianHit")):
		body.civilianHit()
	elif (body.has_method("ghostHit")):
		body.ghostHit()
	return
