extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 1000

var speed = 0
var velocity = Vector2()

var target_direction = Vector2()
var is_moving = false

var type
var grid

var ID = get_instance_id()

var Dir = VarG.getDireccionL()

var posicionesTanques
var posicionAnterior;

func rota(ang):
	var rad = ang*PI/180
	get_node("Ammo").rotate(rad)

func _ready():
	var img = Image.new()
	img = load("res://graphics/municion/tiroL.png")
	if Dir == "(N)":
#		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/780)
		var scala=Vector2(980,780)/VarG.tamCel
		img.resize(scala.x,scala.y)
		var imgText = ImageTexture.new()
		imgText.create_from_image(img)
		get_node("Ammo").texture=imgText
		var col = RectangleShape2D.new()
		col.extents=Vector2(980,780)/VarG.tamCel
		get_node("Collision").shape=col
		get_node("Collision").rotation_degrees=90
		rota(270)
	elif Dir == "(O)":
#		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/680)
#		get_node("Ammo").set("scale",scala)
		var scala=Vector2(980,680)/VarG.tamCel
		img.resize(scala.x,scala.y)
		var imgText = ImageTexture.new()
		imgText.create_from_image(img)
		get_node("Ammo").texture=imgText
		var col = RectangleShape2D.new()
		col.extents=Vector2(980,680)/VarG.tamCel
		get_node("Collision").shape=col
		get_node("Collision").rotation_degrees=0
		rota(180)
	elif Dir == "(S)":
#		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/780)
		var scala=Vector2(980,780)/VarG.tamCel
		img.resize(scala.x,scala.y)
		var imgText = ImageTexture.new()
		imgText.create_from_image(img)
		get_node("Ammo").texture=imgText
		var col = RectangleShape2D.new()
		col.extents=Vector2(980,780)/VarG.tamCel
		get_node("Collision").shape=col
		get_node("Collision").rotation_degrees=90
		rota(90)
	else:
		var scala=Vector2(980,680)/VarG.tamCel
		img.resize(scala.x,scala.y)
		var imgText = ImageTexture.new()
		imgText.create_from_image(img)
		get_node("Ammo").texture=imgText
		var col = RectangleShape2D.new()
		col.extents=Vector2(980,680)/VarG.tamCel
		get_node("Collision").shape=col
		get_node("Collision").rotation_degrees=0
#		var scala = Vector2(VarG.tamCel[0]/980,VarG.tamCel[1]/680)
#		get_node("Ammo").set("scale",scala)
	grid = get_parent()
	type = grid.DISL
	posicionAnterior=position
	set_process(true)
	grid.playDisparo()
	if Dir == "(N)":
		direction.y = -1
	elif Dir == "(S)":
		direction.y = 1
	elif Dir == "(O)":
		direction.x = -1
	elif Dir == "(E)":
		direction.x = 1
	speed = MAX_SPEED
	

func explosion():
	var half_tile_size = VarG.tamCel/2
	if(Dir=="(N)"):
		VarG.setDireccionEL(Dir)
		grid.explosionDisL(Vector2(position.x,position.y+half_tile_size.y))
	elif(Dir=="(S)"):
		VarG.setDireccionEL(Dir)
		grid.explosionDisL(Vector2(position.x,position.y-half_tile_size.y))
	elif(Dir=="(E)"):
		VarG.setDireccionEL(Dir)
		grid.explosionDisL(Vector2(position.x-half_tile_size.x,position.y))
	elif(Dir=="(O)"):
		VarG.setDireccionEL(Dir)
		grid.explosionDisL(Vector2(position.x+half_tile_size.x,position.y))

func _process(delta):
	target_direction = direction.normalized()
	velocity = speed * target_direction * delta
	var col = move_and_collide(velocity)
	if col:
		if(col.collider_id==VarG.IDTank1):
			var tank1 = instance_from_id(VarG.IDTank1)
			tank1.v-=VarG.hurtDisL
		elif(col.collider_id==VarG.IDTank2):
			var tank2 = instance_from_id(VarG.IDTank2)
			tank2.v-=VarG.hurtDisL
		elif(col.collider_id==VarG.IDTank3):
			var tank3 = instance_from_id(VarG.IDTank3)
			tank3.v-=VarG.hurtDisL
		elif(col.collider_id==VarG.IDTank4):
			var tank4 = instance_from_id(VarG.IDTank4)
			tank4.v-=VarG.hurtDisL
		queue_free()
		explosion()
#		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
