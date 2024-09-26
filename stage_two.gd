extends Node2D
var ghost_scene: PackedScene = load("res://ghost.tscn")
var player_scene:PackedScene = load("res://player.tscn")
var temp = 0
var civKills = GlobalValues.civKillCount

func _ready():
	set_process(true)
	$Hud/Start.hide()
	$Hud/PlayAgain.hide()
	#Clear NPCs on screen
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("civilians", "queue_free")
	
	var player = player_scene.instantiate()
	
	var enemyKillCount = str(GlobalValues.enemyKillCount)
	$Hud.show_stageTwo_text("Great job! You killed " + enemyKillCount + " spiders!")
	await get_tree().create_timer(2).timeout
	
	#Stage 2 activates if player has killed civilians (Most likely outcome)
	if (civKills > 0):
		#Freeze player until all ghosts are spawned to prevent player from killing ghosts before they can move
		$Player.set_process(false)
		$Hud/StageTwoLabel.hide()
		await get_tree().create_timer(2).timeout
		spawn_ghosts()
	#Player skips stage 2 entirely if they don't kill civilians
	else:
		$Hud/StageTwoLabel.hide()
		$Hud.show_GameOver_text("No civilians were harmed in extermination. Great job!")
		$Hud.show_PlayAgain_button()
	
func _process(delta):
	var HP = str(GlobalValues.HP)
	$Hud.show_HP("HP: " + HP)
	#Only executes after all ghosts have spawned and been slayed
	if GlobalValues.ghostKillCount > 0 and GlobalValues.ghostCount <= 0:
		$Hud.show_GameOver_text("You killed them all. Great job....")
		set_process(false)
		$Hud.show_PlayAgain_button()
		
func spawn_ghosts():
	$AudioStreamPlayer2D.play()
	for i in range(1, civKills +1):
		$Hud.show_stageTwo_text("You killed " + str(i) + " innocent bystanders")
		spawn_ghost()
		temp += 1
		await get_tree().create_timer(.2).timeout
	await get_tree().create_timer(3).timeout
	$Hud/StageTwoLabel.hide()
	$GrassBackground.visible = not $GrassBackground.visible
	$SecondBackground.visible = true
	$Player.set_process(true) #Unfreeze player once all ghosts spawn

func spawn_ghost():
	GlobalValues.ghostCount += 1
	var ghostCountDown = civKills
	ghostCountDown -= temp
	var ghost = ghost_scene.instantiate()
	var ghost_spawn_point = $NPC_Path/GhostSpawnLocation
	ghost_spawn_point.progress_ratio = randf()
	var direction = ghost_spawn_point.rotation + PI / 2
	
	ghost.position = ghost_spawn_point.position
	direction += randf_range(-PI / 4, PI / 4)
	ghost.rotation = direction -190
	add_child(ghost)
	ghost.add_to_group("Ghosts")
	
	var velocity = Vector2(0.0, 0.0)
	ghost.setVelocity(velocity)
	ghost.linear_velocity = velocity.rotated(direction)
	await get_tree().create_timer((.2 * ghostCountDown)+3).timeout
	print("Countdown: ", ghostCountDown)
	velocity = Vector2(300.0, 0.0)
	ghost.setVelocity(velocity.rotated(direction))

func _on_game_over():
	$Hud/TimerLabel.hide()
	if GlobalValues.HP <= 0:
		$Hud.show_GameOver_text("YOU DIED")
		$Hud.show_PlayAgain_button()

func _on_play_again():
	get_tree().change_scene_to_file("res://main.tscn")
