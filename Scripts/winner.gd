extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameTheme.para()
	$ganador.text=$ganador.text + str(VarG.win)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_crdts_pressed():
	Transicion.cambio2("res://Escenas/Creditos.tscn")


func _on_main_pressed():
	Transicion.cambio2("res://Escenas/Main.tscn")
	MainTheme.reanuda()
