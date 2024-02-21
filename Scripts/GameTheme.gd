extends AudioStreamPlayer

var canciones = ["res://Sonidos/All Out Life.ogg","res://Sonidos/battery.ogg","res://Sonidos/Blow Me Away.ogg","res://Sonidos/Breaking the Covenant.ogg","res://Sonidos/The Only Thing They Fear Is You.ogg","res://Sonidos/the unforgiven.ogg","res://Sonidos/You Want a Battle.ogg"]
var i=1
var stop = false

func _ready():
	pass

func inicia():
	randomize()
	canciones.shuffle()
	get_node(".").stream=load(canciones[0])
	get_node(".").play()
	if get_node(".").stream_paused == true:
		get_node(".").stream_paused = false

func para():
	get_node(".").stop()
	get_node(".").stream=null
	stop=true

func _on_theme_finished():
	if stop == false:
		if(i==canciones.size()):
			i=0
		get_node(".").stream=load(canciones[i])
		i+=1
		get_node(".").play()
