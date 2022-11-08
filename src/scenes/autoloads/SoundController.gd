extends Node

var music = true
var sound = true

func _ready():
	pass # Replace with function body.



func _process(delta):
	pass

func play_music():
	$Soundtrack.stream_paused = false
	
func stop_music():
	$Soundtrack.stream_paused = true

func play_MouseHoverSound():
	if sound:
		$MouseHoverSound.play()
	
func playRight():
	if sound:
		$Answer/Right.play()

func playWrong():
	if sound:
		$Answer/Wrong.play()
