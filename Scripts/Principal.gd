extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	leerArch()
	if(MainTheme.playing==false && MainTheme.stream_paused==false):
		MainTheme.play()
	elif(MainTheme.stream_paused==true):
		MainTheme.stream_paused = false
	if VarG.tutorial==true:
		get_node("../Panel2").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Conf_pressed():
	playBoton()
	Transicion.cambio2("res://Escenas/Conf.tscn")


func _on_Play_pressed():
	playBoton()
	Transicion.cambio2("res://Escenas/PreJuego.tscn")


func _on_Crear_pressed():
	playBoton()
	Transicion.cambio2("res://Escenas/VentanaCod.tscn")

func playBoton():
	get_node("clac").play()

func _on_Tutorial_pressed():
	Transicion.cambio2("res://Escenas/Tutorial.tscn")

func leerArch():
	var arch = File.new()
	arch.open("user://Guardado/ConfSonido.xml",arch.READ)
	var texto =  arch.get_as_text()
	arch.close()
	var datos = texto.split("\n",true);
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),int(datos[0]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),int(datos[1]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Disparos"),int(datos[2]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Explosiones"),int(datos[3]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voz"),int(datos[4]))

func _on_Salir_pressed():
	get_tree().quit()

func _on_recomendacion_pressed():
	VarG.setTutorial(false)
	get_node("../Panel2").hide()
