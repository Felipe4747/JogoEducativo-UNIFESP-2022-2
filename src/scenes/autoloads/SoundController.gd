extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var music = true
var sound = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
