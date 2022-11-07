extends Control

var random = RandomNumberGenerator.new()
var fator1 
var fator2
var right
var pontuacao = 0
var multiplicador
var rodada = 0

func _ready():
	random.randomize()
	nextRound()
	pass

func nextRound():
	rodada+=1
	$NinePatchRect/Rodada.bbcode_text = "[center]"+str(rodada)+"[/center]"
	multiplicador = 3
	$NinePatchRect/Chances.text = "Chances: "+str(multiplicador)
	$NinePatchRect/Pontuacao.text = "Pontuação: "+str(pontuacao)
	fator1 = random.randi_range(1,5)
	fator2 = random.randi_range(1,5)
	$NinePatchRect/Conta.bbcode_text = "[center]"+str(fator1)+" x "+str(fator2)+"[center]"
	right = fator1*fator2
	var res = [right]
	while res.size()<4:
		var add = right+random.randi_range(-4,4)
		if(!res.has(add) and add>0):
			res.append(add)
	res.shuffle()
	for i in range(4):
		get_node("NinePatchRect/GridContainer/Res"+str(i+1)).text = str(res[i])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Res_pressed(button: String):
	#button = Res1, Res2...
	print(button)
	if get_node("NinePatchRect/GridContainer/"+button).text == str(right):
		pontuacao()
	elif multiplicador > 1:
		multiplicador-=1
		$NinePatchRect/Chances.text = "Chances: "+str(multiplicador)
	else:
		nextRound()
	pass # Replace with function body.

func verificaResposta():
	pass
	
func pontuacao():
	pontuacao+=10*multiplicador
	print("resposta certa")
	nextRound()
	pass
