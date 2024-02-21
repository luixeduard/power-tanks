extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 100

var speed = 0
var velocity = Vector2()
var target_direction = Vector2()

var type
var grid

var ID = get_instance_id()

var Dir = VarG.getDireccionP()
var PosIni = VarG.getPositionPini()
var PosFin = VarG.getPositionPFin()

var PosicionRealFinal

var half_cell_size 

func rota(ang):
	var rad = ang*PI/180
	get_node("Ammo").rotate(rad)

func _ready():
#	print(PosIni)
#	print(PosFin)
	if Dir == "(N)":
		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/780)
		get_node("Ammo").set("scale",scala)
		rota(270)
		half_cell_size = Vector2(0,VarG.tamCel.y)/2
		if(PosIni!=Vector2(-1,-1)):
			PosicionRealFinal=Vector2(PosIni.x,PosIni.y-int(PosFin))
	elif Dir == "(O)":
		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/680)
		get_node("Ammo").set("scale",scala)
		rota(180)
		half_cell_size = Vector2(VarG.tamCel.y,0)/2
		if(PosIni!=Vector2(-1,-1)):
			PosicionRealFinal=Vector2(PosIni.x-int(PosFin),PosIni.y)
	elif Dir == "(S)":
		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/780)
		get_node("Ammo").set("scale",scala)
		rota(90)
		half_cell_size = Vector2(0,-VarG.tamCel.y)/2
		if(PosIni!=Vector2(-1,-1)):
			PosicionRealFinal=Vector2(PosIni.x,PosIni.y+int(PosFin))
	else:
		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/680)
		get_node("Ammo").set("scale",scala)
		half_cell_size = Vector2(-VarG.tamCel.y,0)/2
		if(PosIni!=Vector2(-1,-1)):
			PosicionRealFinal=Vector2(PosIni.x+int(PosFin),PosIni.y)
	grid = get_parent()
	type = grid.DISL
	set_process(true)


func _process(delta):
#	print(PosicionRealFinal)
	direction = Vector2()
	speed = 0

	if Dir == "(N)":
		direction.y = -1
	elif Dir == "(S)":
		direction.y = 1
	elif Dir == "(O)":
		direction.x = -1
	elif Dir == "(E)":
		direction.x = 1
	target_direction = direction.normalized()
	speed = MAX_SPEED
	velocity = speed * target_direction * delta
	move_and_collide(velocity)
	if(grid.whatIsMyPositionMap(position+half_cell_size)==PosicionRealFinal):
		grid.danoPar(PosicionRealFinal)
		grid.quita(get_instance_id())

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
