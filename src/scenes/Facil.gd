extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var random = RandomNumberGenerator.new()
var fator1 
var fator2
var res

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	fator1 = random.randi_range(1,5)
	fator2 = random.randi_range(1,5)
	res = fator1*fator2
	$NinePatchRect/Conta.bbcode_text = "[center]"+str(fator1)+" x "+str(fator2)+"[center]"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
