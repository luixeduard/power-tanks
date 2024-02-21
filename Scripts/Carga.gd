extends Node

var timer

func _ready():
	_init()
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("Codigos")
	dir.make_dir("Guardado")
	var arch = File.new()
	if(!arch.file_exists("user://Codigos/defective_gear.txt")):
		dir.copy("res://Codigos/defective_gear.txt","user://Codigos/defective_gear.txt")
	if(!arch.file_exists("user://Codigos/Killer.txt")):
		dir.copy("res://Codigos/Killer.txt","user://Codigos/Killer.txt")
	if(!arch.file_exists("user://Codigos/AlmaMortalRR.txt")):
		dir.copy("res://Codigos/AlmaMortalRR.txt","user://Codigos/AlmaMortalRR.txt")
	if(arch.file_exists("user://Guardado/ConfSonido.xml")==false):
		var cadenaA = str(0)+"\n"+str(0)+"\n"+str(0)+"\n"+str(0)+"\n"+str(0) 
		var file = File.new()
		var config = "user://Guardado/ConfSonido.xml"
		file.open(config,File.WRITE)
		file.store_string(cadenaA)
		file.close()
	if(arch.file_exists("user://Guardado/ConfVideo.xml")==false):
		VarG.tamPantalla=OS.get_screen_size(-1)
		OS.set_window_size(VarG.tamPantalla)
		get_viewport().set_size_override(true,VarG.tamPantalla,Vector2(0,0))
		$"/root".size=VarG.tamPantalla
		var cadenaA = str(VarG.tamPantalla.x,"\n",VarG.tamPantalla.y,"\n",VarG.tamPantalla.x,"\n",VarG.tamPantalla.y,"\n",true)
		var file = File.new()
		var config = "user://Guardado/ConfVideo.xml"
		file.open(config,File.WRITE)
		file.store_string(cadenaA)
		file.close()
	else:
		var archV = File.new()
		archV.open("user://Guardado/ConfVideo.xml",arch.READ)
		var texto =  archV.get_as_text()
		archV.close()
		var datos = texto.split("\n",true);
		VarG.tamPantalla=Vector2(int(datos[0]),int(datos[1]))
		var tamOrigin=Vector2(int(datos[2]),int(datos[3]))
		var margins = tamOrigin-VarG.tamPantalla
		OS.set_window_size(VarG.tamPantalla)
		get_viewport().set_size_override(true,VarG.tamPantalla,margins)
		$"/root".size=VarG.tamPantalla
		if((datos[4])=="False"):
			OS.window_fullscreen = false

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 2
	timer.connect("timeout", self, "_timeout")


func _timeout():
	get_tree().change_scene("res://Escenas/Main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
