extends CanvasLayer

func change_scene(target: String)->void:
	$AnimationPlayer.play("fade_to_black")
	yield($AnimationPlayer, 'animation_finished')
	
	if get_tree().change_scene(target) != OK:
		print(get_tree().change_scene(target))
	
	$AnimationPlayer.play("fade_to_normal")
