extends Node2D
var civ_scene = load("res://civilian.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var civilian = civ_scene.instantiate()
	var civlian_spawn_point = $NPC_Path/CivilianSpawnLocation
	civlian_spawn_point.progress_ratio = randf()
	var direction = civlian_spawn_point.rotation + PI / 2
	
	civilian.position = civlian_spawn_point.position
	
	direction += randf_range(-PI / 4, PI / 4)
	civilian.rotation = direction - 190
	
	var velocity = Vector2(200.0, 0.0)
	civilian.linear_velocity = velocity.rotated(direction)
	
	add_child(civilian)
