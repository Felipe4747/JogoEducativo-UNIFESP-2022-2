extends Control


func _ready():
	Sound_Manager() # Replace with function body.

func Sound_Manager():
	if SoundController.sound:
		$NinePatchRect/Sound.icon = ResourceLoader.load("res://src/icons/speaker.png")
	else:
		$NinePatchRect/Sound.icon = ResourceLoader.load("res://src/icons/speaker-off.png")
	if SoundController.music:
		SoundController.play_music()
		$NinePatchRect/Music.icon = ResourceLoader.load("res://src/icons/sound-on.png")
	else:
		SoundController.stop_music()
		$NinePatchRect/Music.icon = ResourceLoader.load("res://src/icons/sound-off.png")

#func _process(delta):
#	pass
