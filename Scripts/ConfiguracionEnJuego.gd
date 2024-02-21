extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var select = 0
var resolutionSelected
var vGeneral = 0
var vMusica = 0
var VDis = 0
var vExp = 0 
var VVoz = 6
var changedVolume = false;
var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	leerArch()

func _on_VolMusica_value_changed(value):
	if first!=true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),value)
		vMusica = value

func _on_VolVoz_value_changed(value):
	if first!=true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voz"),value)
		get_node("../voz").play()
		VVoz = value

func _on_Aceptar_pressed():
	playBoton()
	var cadenaA = str(vGeneral)+"\n"+str(vMusica)+"\n"+str(VDis)+"\n"+str(vExp)+"\n"+str(VVoz) 
	var file = File.new()
	var config = "user://Guardado/ConfSonido.xml"
	file.open(config,File.WRITE)
	file.store_string(cadenaA)
	file.close()
	get_node(".").hide()
	

func _on_CheckBox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func playBoton():
	get_node("../clic").play()

func _on_VolGeneral_value_changed(value):
	if first!=true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
		vGeneral=value

func _on_VolDisparos_value_changed(value):
	if first!=true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Disparos"),value)
		get_node("../DisparoLineal").play()
		VDis=value

func _on_VolExplosiones_value_changed(value):
	if first!=true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Explosiones"),value)
		get_node("../ExplosionMina").play()
		vExp=value

func leerArch():
	var arch = File.new()
	arch.open("user://Guardado/ConfSonido.xml",arch.READ)
	var texto =  arch.get_as_text()
	arch.close()
	var datos = texto.split("\n",true);
	get_node("Fondo/PanelOpc/PanelSonido/VBoxContainer/VolGeneral").value=int(datos[0])
	get_node("Fondo/PanelOpc/PanelSonido/VBoxContainer/VolMusica").value=int(datos[1])
	get_node("Fondo/PanelOpc/PanelSonido/VBoxContainer/VolDisparos").value=int(datos[2])
	get_node("Fondo/PanelOpc/PanelSonido/VBoxContainer/VolExplosiones").value=int(datos[3])
	get_node("Fondo/PanelOpc/PanelSonido/VBoxContainer/VolVoz").value=int(datos[4])
	first = false
