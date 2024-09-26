extends Node	
@export var stage_two: PackedScene

var level_two:PackedScene = load("res://stage_two.tscn")
var spawn_enemy:PackedScene = load("res://spawn_enemy.tscn")
var spawn_civ:PackedScene = load("res://spawn_civ.tscn")

var gameTime
var screenSize = Vector2(1152.0, 648.0)

func new_game():
	GlobalValues.HP = GlobalValues.maxHP
	GlobalValues.enemyKillCount = 0
	GlobalValues.civKillCount = 0
	GlobalValues.ghostKillCount = 0
	GlobalValues.ghostCount = 0
	print("NEW GAME")
	gameTime = 45
	
	$Player.start($PlayerSpawnPoint.position)
	$Player.show()
	$StartTimer.start()
	$Hud.show_readyText("KILL AS MANY SPIDERS AS YOU CAN")
	$Hud.update_time(gameTime)
	$Hud/TimerLabel.show()
	
	var hp = str($Player.hp)
	$Hud.show_HP("HP: " + hp)
	
func game_over():
	$StartTimer.stop()
	$EnemySpawnTimer.stop()
	$CivilianSpawnTimer.stop()
	$GameTimer.stop()
	
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("civilians", "queue_free")
	$Hud/TimerLabel.hide()
	$AudioStreamPlayer2D.stop()
	if GlobalValues.HP <= 0:
		$Hud.show_GameOver_text("YOU DIED")
		$Hud.show_PlayAgain_button()
	
func _on_enemy_spawn_timer_timeout():
	var enemy_spawn_instance = spawn_enemy.instantiate()
	add_child(enemy_spawn_instance)
	
func _on_civilian_spawn_timer_timeout():	
	var civ_spawn_instance = spawn_civ.instantiate()
	add_child(civ_spawn_instance)
	
func _on_start_timer_timeout():
	$EnemySpawnTimer.start()
	$CivilianSpawnTimer.start()
	$GameTimer.start()
	$AudioStreamPlayer2D.play()

func _on_game_timer_timeout():
	gameTime -= 1
	$Hud.update_time(gameTime)
	if(gameTime <= 0):
		$GameTimer.stop()
		$Hud/TimerLabel.hide()
		$AudioStreamPlayer2D.stop()
		get_tree().change_scene_to_file("res://stage_two.tscn")

	
func _on_play_again():
	get_tree().change_scene_to_file("res://main.tscn")
