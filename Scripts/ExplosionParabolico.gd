extends KinematicBody2D


var grid

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Explosion").frame=0
	grid = get_parent()
	set_process(true)
	var tam = VarG.tamCel*3
	var escala = tam/Vector2(454,454)
	get_node("Explosion").scale=escala
	grid.playExplosionParabolica()

func _process(delta):
	get_node("Explosion").playing=true
	if get_node("Explosion").frame==8:
		grid.quita(get_instance_id())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
