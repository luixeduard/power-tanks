extends AudioStreamPlayer

var canciones = ["res://Sonidos/Arragamet.ogg","res://Sonidos/do i wanna know.ogg","res://Sonidos/Gary vs David.ogg","res://Sonidos/Harder, Better, Faster, Stronger.ogg","res://Sonidos/Hostile.ogg","res://Sonidos/Royalty.ogg"]
var i=0
var pausa = false

func _ready():
	randomize()
	canciones.shuffle()

func pausa():
	get_node(".").playing=false
	pausa = true

func reanuda():
	pausa = false

func _on_theme_finished():
	if pausa != true:
		if(i==canciones.size()):
			i=0
		get_node(".").stream=load(canciones[i])
		i+=1
		get_node(".").play()
