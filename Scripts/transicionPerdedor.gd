extends CanvasLayer

func _ready():
	pass # Replace with function body.

func ejecuta():
	GameTheme.para()
	$AudioStreamPlayer.play()
	$Sangre.visible=true
	$AnimationPlayer.play("Sangre")



func _on_AnimationPlayer_animation_finished(anim_name):
	$Sangre.hide()
	MainTheme.reanuda()
	get_tree().change_scene("res://Escenas/Main.tscn")
