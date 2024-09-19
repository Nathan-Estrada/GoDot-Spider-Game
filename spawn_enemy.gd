extends Node2D
var enemy_scene = load("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_point = $NPC_Path/EnemySpawnLocation
	enemy_spawn_point.progress_ratio = randf()
	var direction = enemy_spawn_point.rotation + PI / 2
	
	enemy.position = enemy_spawn_point.position
	
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction -190
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)  #Velocity is randomized
	var velocity = Vector2(300.0, 0.0)
	#enemy.setVelocity(velocity.rotated(direction))
	enemy.linear_velocity = velocity.rotated(direction)
	add_child(enemy)
