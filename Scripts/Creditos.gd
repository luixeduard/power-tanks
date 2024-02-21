extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var auo


# Called when the node enters the scene tree for the first time.
func _ready():
#	auo = MainTheme.volume_db
	GameTheme.stream_paused=true
	$cred.play("cascada")
	yield($cred,"animation_finished")
	#get_node("Timer").start(0.2)
	Transicion.cambio3("res://Escenas/Main.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
#	MainTheme.volume_db = auo
	pass
