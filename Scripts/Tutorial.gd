extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var videoTime
var video

# Called when the node enters the scene tree for the first time.
func _ready():
	MainTheme.stream_paused=true
	var tam = 15
	var img = load("res://graphics/botones/tick.png")
	img.resize(tam,tam)
	var imgText = ImageTexture.new()
	imgText.create_from_image(img)
	get_node("Reproductor/Video/Panel2/HSlider").set("custom_icons/grabber",imgText)
	get_node("Reproductor/Video/Panel/Panel4/HSlider").value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	MainTheme.stream_paused=false
	Transicion.cambio2("res://Escenas/Main.tscn")


func _on_Configuraciones_pressed():
	var tiempoDeVideo = 54
#	tiempoDeVideo=tiempoDeVideo*60
	videoTime="00:54"
	video = load("res://Tutorial/Configuracion.ogv")
	get_node("Reproductor/Video/Panel2/HSlider").max_value=tiempoDeVideo
	get_node("Reproductor/Video/VideoPlayer").stream=video
	get_node("Reproductor/Sin video").hide()
	get_node("Reproductor/Video").show()
	get_node("Reproductor/Video/VideoPlayer").play()

func _on_crearcodigo_pressed():
	var tiempoDeVideo = 297
	videoTime="04:57"
	video = load("res://Tutorial/codigo.ogv")
	get_node("Reproductor/Video/Panel2/HSlider").max_value=tiempoDeVideo
	get_node("Reproductor/Video/VideoPlayer").stream=video
	get_node("Reproductor/Sin video").hide()
	get_node("Reproductor/Video").show()
	get_node("Reproductor/Video/VideoPlayer").play()

func _on_prejuego_pressed():
	var tiempoDeVideo = 102
	videoTime="01:42"
	video = load("res://Tutorial/AntesDelJuego.ogv")
	get_node("Reproductor/Video/Panel2/HSlider").max_value=tiempoDeVideo
	get_node("Reproductor/Video/VideoPlayer").stream=video
	get_node("Reproductor/Sin video").hide()
	get_node("Reproductor/Video").show()
	get_node("Reproductor/Video/VideoPlayer").play()

func _on_juego_pressed():
	var tiempoDeVideo = 107
	videoTime="01:47"
	video = load("res://Tutorial/juego.ogv")
	get_node("Reproductor/Video/Panel2/HSlider").max_value=tiempoDeVideo
	get_node("Reproductor/Video/VideoPlayer").stream=video
	get_node("Reproductor/Sin video").hide()
	get_node("Reproductor/Video").show()
	get_node("Reproductor/Video/VideoPlayer").play()

func _process(delta):
	var time = get_node("Reproductor/Video/VideoPlayer").stream_position
	var tiempo = "00:00"
	if(time!=null):
		var minute = time/60
		var cad = str(minute)
		var cadMin = cad.substr(0,cad.find(".",0))
		if(cadMin.length()<2):
			cadMin="0"+cadMin
		var cadSeg = "0"+cad.substr(cad.find(".",0))
		var seg = int(round(float(cadSeg)*60))
		cadSeg = str(seg)
		if(cadSeg.length()<2):
			cadSeg="0"+cadSeg
		tiempo=cadMin+":"+cadSeg
	get_node("Reproductor/Video/Panel/Panel2/Label").text=str(tiempo,"/",videoTime)
	get_node("Reproductor/Video/Panel2/HSlider").value=time

func _on_pausa_pressed():
	if(get_node("Reproductor/Video/VideoPlayer").paused==false):
		get_node("Reproductor/Video/VideoPlayer").paused=true
		get_node("Reproductor/Video/Panel/Panel/pausa").texture_normal=load("res://graphics/botones/play.png")
	else:
		get_node("Reproductor/Video/VideoPlayer").paused=false
		get_node("Reproductor/Video/Panel/Panel/pausa").texture_normal=load("res://graphics/botones/pause.png")


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voz"),value)



func _on_VideoPlayer_finished():
	get_node("Reproductor/Video/Panel/Panel/pausa").texture_normal=load("res://graphics/botones/play.png")
	get_node("Reproductor/Video/VideoPlayer").stream=video
	get_node("Reproductor/Video/VideoPlayer").play()
	get_node("Reproductor/Video/VideoPlayer").paused=true
