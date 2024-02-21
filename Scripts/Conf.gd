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
var VVoz = 0
var changedVolume = false;
var resolucionOrigin;
var origen;
var first = true

# Called when the node enters the scene tree for the first time.
func estableceArrows():
	var tam = get_node("PanelVideo/VBoxContainer/Resolucion").rect_size.y
	var img = load("res://graphics/botones/arrow.png")
	var imgText = ImageTexture.new()
	img.resize(tam,tam,Image.INTERPOLATE_CUBIC)
	imgText.create_from_image(img);
	get_node("PanelVideo/VBoxContainer/Resolucion").set("custom_icons/arrow",imgText)
	

func _ready():
	leerArch()
	leerArchVid()
	searchResolution()
	if(OS.window_fullscreen == true):
		get_node("PanelVideo/VBoxContainer/CheckBox").pressed=true
	else:
		get_node("PanelVideo/VBoxContainer/CheckBox").pressed=false


func searchResolution():
	var select = 0
	var resolutionsX = [768,800,800,854,1024,1024,1152,1280,1280,1280,1366,1440,1920,1920,2048,2560,2560,3840]
	var resolutionsY = [576,480,600,480,600, 768, 768, 720, 768, 800, 768, 900, 1080,1200,1080,1440,1600,2160] 
	var cont = 0
	for i in range(18):
		if(resolutionsX[i]<=origen.x && resolutionsY[i]<=origen.y):
			get_node("PanelVideo/VBoxContainer/Resolucion").add_item(str(resolutionsX[i],"x",resolutionsY[i]));
			cont+=1
	for i in range(cont):
		if (resolucionOrigin==get_node("PanelVideo/VBoxContainer/Resolucion").get_item_text(i)):
			get_node("PanelVideo/VBoxContainer/Resolucion").select(i)
	

func _on_Sonido_pressed():
	playBoton()
	get_node("PanelSonido").show()
	get_node("PanelVideo").hide()

func _on_Video_pressed():
	playBoton()
	get_node("PanelSonido").hide()
	get_node("PanelVideo").show()

func _on_Resolucion_item_selected(id):
	var a = get_node("PanelVideo/VBoxContainer/Resolucion").get_item_text(id)
	resolutionSelected = Vector2(int(a.substr(0,a.find("x"))),int(a.substr(a.find("x")+1)))
	if(resolutionSelected!=VarG.tamPantalla):
		get_node("PanelVideo/ContAcepVideo").show()
	else:
		get_node("PanelVideo/ContAcepVideo").hide()
	#if(width.to_float()==get_viewport_rect().size[0]&&height.to_float()==get_viewport_rect().size[1]):
	#	get_node("PanelVideo/ContAcepVideo").hide()
	

func guardarArchivo():
	var cadenaA
	if(resolutionSelected==null):
		resolutionSelected=VarG.tamPantalla
	if(get_node("PanelVideo/VBoxContainer/CheckBox").pressed==true):
		cadenaA= str(resolutionSelected[0],"\n",resolutionSelected[1],"\n",origen.x,"\n",origen.y,"\n",true)
	else:
		cadenaA= str(resolutionSelected[0],"\n",resolutionSelected[1],"\n",origen.x,"\n",origen.y,"\n",false)
	var file = File.new()
	var config = "user://Guardado/ConfVideo.xml"
	file.open(config,File.WRITE)
	file.store_string(cadenaA)
	file.close()

func _on_AceptarVideo_pressed():
	playBoton()
	var margins = Vector2((origen.x-resolutionSelected[0]),origen.y-resolutionSelected[1])
	OS.set_window_size(resolutionSelected)
	get_viewport().set_size_override(true,resolutionSelected,margins)
	$"/root".size=resolutionSelected
	VarG.tamPantalla=resolutionSelected
	get_node("PanelVideo/ContAcepVideo").hide()
	guardarArchivo()


func _on_Regresa_pressed():
	playBoton()
	Transicion.cambio2("res://Escenas/Main.tscn")


func _on_VolMusica_value_changed(value):
	if first != true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),value)
		vMusica = value
		get_node("PanelSonido/ContAcepSonido").visible=true

func _on_VolVoz_value_changed(value):
	if first != true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voz"),value)
		get_node("voz").play()
		VVoz = value
		get_node("PanelSonido/ContAcepSonido").visible=true

func _on_AceptarSonido_pressed():
	playBoton()
	var cadenaA = str(vGeneral)+"\n"+str(vMusica)+"\n"+str(VDis)+"\n"+str(vExp)+"\n"+str(VVoz) 
	var file = File.new()
	var config = "user://Guardado/ConfSonido.xml"
	file.open(config,File.WRITE)
	file.store_string(cadenaA)
	file.close()
	get_node("PanelSonido/ContAcepSonido").visible=false

func _on_CheckBox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	guardarArchivo()

func playBoton():
	get_node("clic").play()

func _on_VolGeneral_value_changed(value):
	if first != true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
		vGeneral=value
		get_node("PanelSonido/ContAcepSonido").visible=true

func _on_VolDisparos_value_changed(value):
	if first != true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Disparos"),value)
		get_node("disparos").play()
		VDis=value
		get_node("PanelSonido/ContAcepSonido").visible=true

func _on_VolExplosiones_value_changed(value):
	if first != true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Explosiones"),value)
		get_node("explosiones").play()
		vExp=value
		get_node("PanelSonido/ContAcepSonido").visible=true

func leerArchVid():
	var arch = File.new()
	arch.open("user://Guardado/ConfVideo.xml",arch.READ)
	var texto =  arch.get_as_text()
	arch.close()
	var datos = texto.split("\n",true);
	VarG.tamPantalla=Vector2(int(datos[0]),int(datos[1]))
	origen=Vector2(int(datos[2]),int(datos[3]))
	resolucionOrigin = str(datos[0],"x",datos[1]);

func leerArch():
	var arch = File.new()
	arch.open("user://Guardado/ConfSonido.xml",arch.READ)
	var texto =  arch.get_as_text()
	arch.close()
	var datos = texto.split("\n",true);
	get_node("PanelSonido/VBoxContainer/VolGeneral").value=int(datos[0])
	get_node("PanelSonido/VBoxContainer/VolMusica").value=int(datos[1])
	get_node("PanelSonido/VBoxContainer/VolDisparos").value=int(datos[2])
	get_node("PanelSonido/VBoxContainer/VolExplosiones").value=int(datos[3])
	get_node("PanelSonido/VBoxContainer/VolVoz").value=int(datos[4])
	get_node("PanelSonido/ContAcepSonido").visible=false
	first = false
