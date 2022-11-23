extends Control

var random = RandomNumberGenerator.new()
var minFator = [0,0]
var maxFator = [0,0]
var fator1 
var fator2
var right
var chances
var rodada = 0
var streak = 1

func _ready():
	Sound_Manager()
	setupDifficulty()
	Global.score = 0
	random.randomize()
	nextRound()
	pass

func nextRound():
	if rodada == 10:
		TransitionScreen.change_scene("res://src/scenes/Score.tscn")
		return
	rodada+=1
	chances = 3
	fator1 = random.randi_range(minFator[0],maxFator[0])
	fator2 = random.randi_range(minFator[1],maxFator[1])
	right = fator1*fator2
	$NinePatchRect/Timer.start()
	$NinePatchRect/Rodada.bbcode_text = "[center]"+str(rodada)+"[/center]"
	$NinePatchRect/Chances.text = "Chances: "+str(chances)
	$NinePatchRect/Pontuacao.text = "Pontuação: "+str(Global.score)
	$NinePatchRect/Conta.bbcode_text = "[center]"+str(fator1)+" x "+str(fator2)+" = ?[center]"
	var res = [right]
	while res.size()<4:
		var add = right+random.randi_range(-4,4)
		if(!res.has(add) and add>0):
			res.append(add)
	res.shuffle()
	for i in range(4):
		get_node("NinePatchRect/ResButtons/Res"+str(i+1)).text = str(res[i])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$NinePatchRect/Tempo.text = "Tempo: "+str(round($NinePatchRect/Timer.time_left))

func _on_Res_pressed(button: String):
	#button = Res1, Res2...
	if $NextRoundTimer.time_left !=0:
		return
	if get_node("NinePatchRect/ResButtons/"+button).text == str(right):
		rightAnswer(button)
	else:
		wrongAnswer(button)
		

func setupDifficulty():
	match Global.difficulty:
		1:
			$NinePatchRect/Dificuldade.text = "Fácil"
			$NinePatchRect/Timer.wait_time = 10
			minFator = [1,1]
			maxFator = [5,5]
		2:
			$NinePatchRect/Dificuldade.text = "Médio"
			$NinePatchRect/Timer.wait_time = 15
			minFator = [1,5]
			maxFator = [5,10]
		3:
			$NinePatchRect/Dificuldade.text = "Difícil"
			$NinePatchRect/Timer.wait_time = 20
			minFator = [5,5]
			maxFator = [10,10]


func rightAnswer(button: String):
	streak+=1
	SoundController.playRight()
	get_node("NinePatchRect/ResButtons/"+button).modulate = "70ff70"
	$NinePatchRect/ResButtons/ColorTimer.start()
	Global.score+=10*streak*round($NinePatchRect/Timer.time_left)
	$NextRoundTimer.start()
	pass

func wrongAnswer(button: String):
	streak=1
	SoundController.playWrong()
	get_node("NinePatchRect/ResButtons/"+button).modulate = "ff7070"
	$NinePatchRect/ResButtons/ColorTimer.start()
	if chances > 1:
		chances-=1
		$NinePatchRect/Chances.text = "Chances: "+str(chances)
	else:
		$NextRoundTimer.start()

func _on_ColorTimer_timeout():
	for i in range(4):
		get_node("NinePatchRect/ResButtons/Res"+str(i+1)).modulate = "ffffff"

func _on_Timer_timeout():
	SoundController.playWrong()
	nextRound()
	pass # Replace with function body.

func _on_NextRoundTimer_timeout():
	nextRound()
	pass # Replace with function body.

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



