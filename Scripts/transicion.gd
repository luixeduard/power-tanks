extends CanvasLayer

func _ready():
	pass 
func cambio(escena):
	$anims.play("fade_in")
	yield($anims,"animation_finished")
	get_tree().change_scene(escena)
	$anims.play("fade_out")
	
func cambio2(escena):
	$anims.play("blur_in")
	yield($anims,"animation_finished")
	get_tree().change_scene(escena)
	$anims.play("blur_out")
	
func cambio3(escena):
	$anims.play("black_in")
	yield($anims,"animation_finished")
	get_tree().change_scene(escena)
	$anims.play("black_out")
	MainTheme.stream_paused = false
