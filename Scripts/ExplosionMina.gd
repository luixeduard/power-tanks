extends KinematicBody2D


var grid

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Explosion").frame=0
	grid = get_parent()
	set_process(true)
	var tam = VarG.tamCel
	var escala = tam/Vector2(269,269)
	get_node("Explosion").scale=escala

func _process(delta):
	get_node("Explosion").playing=true
	if get_node("Explosion").frame==8:
		grid.quita(get_instance_id())
