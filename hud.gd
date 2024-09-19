extends CanvasLayer
signal start_game
signal play_again
signal start_timer
signal game_over

func show_HP(text):
	$HP.text = text
	$HP.show()

func show_readyText(text):
	$ReadyText.text = text
	$ReadyText.show()
	$ReadyTimer.start()
	
func show_stageTwo_text(text):
	$StageTwoLabel.text = text
	$StageTwoLabel.show()
	$StageTwoTimer.start()
	
func show_StageTwo_LabelTwo_text(text):
	$StageTwoLabelTwo.text = text
	$StageTwoLabelTwo.show()
	$StageTwoLabelTwoTimer.start()
	
func show_NoCasualties_text(text):
	$NoCasualties.text = text
	$NoCasualties.show()
	
func _start_press():
	$Start.hide()
	start_game.emit()
	
func _on_readyText_timer_timeout():
	$ReadyText.hide()
	start_timer.emit()
	
func update_time(time):
	$TimerLabel.text = str(time)

func _on_stage_two_timer_timeout():
	$StageTwoLabel.hide()
	
func _on_stage_two_label_two_timer_timeout():
	$StageTwoLabelTwo.hide()

func show_PlayAgain_button():
	$PlayAgain.show()

func _on_play_again_pressed():
	print("PRESSED")
	$PlayAgain.hide()
	$NoCasualties.hide()
	play_again.emit()

#Updates HP displayed upon player getting hit
func _on_player_hit():
	var hpText = str(GlobalValues.HP) #Access current player HP
	$HP.text = ("HP: " + hpText)
