extends KinematicBody2D


var grid

var direccion = VarG.getDireccionEL()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("Explosion").frame=0
	grid = get_parent()
	set_process(true)
	var tam = VarG.tamCel
	var escala = tam/Vector2(255,170)
	get_node("Explosion").scale=escala
	if(direccion=="(N)"):
		get_node("Explosion").rotation_degrees=180
	elif(direccion=="(E)"):
		get_node("Explosion").rotation_degrees=270
	elif(direccion=="(O)"):
		get_node("Explosion").rotation_degrees=90
	get_node("Explosion").playing=true

func _process(delta):
	if get_node("Explosion").frame==9:
		grid.quita(get_instance_id())

