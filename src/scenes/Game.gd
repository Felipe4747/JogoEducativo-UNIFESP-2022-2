extends Control

var random = RandomNumberGenerator.new()
var minFator
var maxFator
var fator1 
var fator2
var right
var pontuacao = 0
var chances
var rodada = 0

func _ready():
	setupDifficulty()
	random.randomize()
	nextRound()
	pass

func nextRound():
	rodada+=1
	chances = 3
	fator1 = random.randi_range(minFator[0],maxFator[0])
	fator2 = random.randi_range(minFator[1],maxFator[1])
	right = fator1*fator2
	$NinePatchRect/Timer.start()
	$NinePatchRect/Rodada.bbcode_text = "[center]"+str(rodada)+"[/center]"
	$NinePatchRect/Chances.text = "Chances: "+str(chances)
	$NinePatchRect/Pontuacao.text = "Pontuação: "+str(pontuacao)
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
#	pass


func _on_Res_pressed(button: String):
	#button = Res1, Res2...
	print(button)
	if get_node("NinePatchRect/ResButtons/"+button).text == str(right):
		rightAnswer()
	else:
		wrongAnswer(button)
		

func setupDifficulty():
	match Global.difficulty:
		1:
			$NinePatchRect/Timer.wait_time = 10
			minFator = [1,1]
			maxFator = [5,5]
		2:
			$NinePatchRect/Timer.wait_time = 15
			minFator = [1,5]
			maxFator = [5,10]
		3:
			$NinePatchRect/Timer.wait_time = 20
			minFator = [5,5]
			maxFator = [10,10]


func verificaResposta():
	pass

func rightAnswer():
	SoundController.playRight()
	pontuacao+=10*chances*round($NinePatchRect/Timer.time_left)
	nextRound()
	pass

func wrongAnswer(button: String):
	SoundController.playWrong()
	get_node("NinePatchRect/ResButtons/"+button).modulate = "ff7070"
	$NinePatchRect/ResButtons/ColorTimer.start()
	if chances > 1:
		chances-=1
		$NinePatchRect/Chances.text = "Chances: "+str(chances)
	else:
		nextRound()

func _on_ColorTimer_timeout():
	for i in range(4):
		get_node("NinePatchRect/ResButtons/Res"+str(i+1)).modulate = "ffffff"

func _on_Timer_timeout():
	SoundController.playWrong()
	nextRound()
	pass # Replace with function body.
