extends Button

func _ready():
	#Sound_Manager()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_mouse_entered():
	SoundController.play_MouseHoverSound()
	#$"../../MouseHoverSound".play()
	pass # Replace with function body.

func _on_Sair_pressed():
	get_tree().quit()
	pass # Replace with function body.



func _on_Sound_pressed():
	SoundController.sound = !SoundController.sound
	Sound_Manager()
	pass # Replace with function body.


func _on_Music_pressed():
	SoundController.music = !SoundController.music
	Sound_Manager()
	pass # Replace with function body.

func Sound_Manager():
	if SoundController.sound:
		$"../Sound".icon = ResourceLoader.load("res://src/icons/speaker.png")
	else:
		$"../Sound".icon = ResourceLoader.load("res://src/icons/speaker-off.png")
	if SoundController.music:
		SoundController.play_music()
		$"../Music".icon = ResourceLoader.load("res://src/icons/sound-on.png")
	else:
		SoundController.stop_music()
		$"../Music".icon = ResourceLoader.load("res://src/icons/sound-off.png")


func _on_Voltar_pressed():
	get_tree().change_scene("res://src/scenes/MainMenu.tscn")
	pass # Replace with function body.


func _on_StartButton_pressed(difficulty):
	Global.difficulty = difficulty
	get_tree().change_scene("res://src/scenes/Game.tscn")
	pass # Replace with function body.
