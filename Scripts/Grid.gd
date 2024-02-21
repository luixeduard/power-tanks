# Collection of functions to work with a Grid. Stores all its children in the grid array
extends TileMap

enum {EMPTY, PLAYER, MINA, DISL, DISP, MINEEXP,SACO}

var tile_size = 0
var half_tile_size = 0
var grid_size = Vector2(0, 0)
var endGame
var grid = []
var gridMinas = []

onready var Player = preload("res://Escenas/Player.tscn")
onready var Mina = preload("res://Escenas/Mina.tscn")
onready var DisL = preload("res://Escenas/DisparoLineal.tscn")
onready var Par = preload("res://Escenas/DisparoParabolico.tscn")
onready var ExpP = preload("res://Escenas/ExplosionParabolico.tscn")
onready var ExpL = preload("res://Escenas/ExplosionLineal.tscn")
onready var ExpM = preload("res://Escenas/ExplosionMina.tscn")
onready var ExpT = preload("res://Escenas/explosionTanque.tscn")
onready var CostalH = preload("res://Escenas/costalH.tscn")
onready var CostalV = preload("res://Escenas/costalV.tscn")
onready var CostalE = preload("res://Escenas/costalE.tscn")


var positions = []

var PLAYER1_STARTPOS# = Vector2(3,1)
var PLAYER2_STARTPOS# = Vector2(4,1)
var PLAYER3_STARTPOS# = Vector2(6,0)
var PLAYER4_STARTPOS# = Vector2(7,0)

var ID_Player1 = -1
var ID_Player2 = -1
var ID_Player3 = -1
var ID_Player4 = -1

var NoPlayers

var minaPawn = []
var minaPawnID = []

var tanks = ["res://graphics/selectable/tank1.png","res://graphics/selectable/tank2.png","res://graphics/selectable/tank3.png","res://graphics/selectable/tank4.png","res://graphics/selectable/tank5.png","res://graphics/selectable/tank6.png","res://graphics/selectable/tank7.png","res://graphics/selectable/tank8.png","res://graphics/selectable/tank9.png"]
var Imgvida = ["res://graphics/vida/vida0.png","res://graphics/vida/vida5.png","res://graphics/vida/vida10.png","res://graphics/vida/vida15.png","res://graphics/vida/vida20.png","res://graphics/vida/vida25.png","res://graphics/vida/vida30.png","res://graphics/vida/vida35.png","res://graphics/vida/vida40.png","res://graphics/vida/vida45.png","res://graphics/vida/vida50.png","res://graphics/vida/vida55.png","res://graphics/vida/vida60.png","res://graphics/vida/vida65.png","res://graphics/vida/vida70.png","res://graphics/vida/vida75.png","res://graphics/vida/vida80.png","res://graphics/vida/vida85.png","res://graphics/vida/vida90.png","res://graphics/vida/vida95.png","res://graphics/vida/vida100.png"]

func randomPosition():
	var tMapa = VarG.TamMap
	for i in range(1,tMapa-1):
		for j in range(1,tMapa-1):
			positions.append(Vector2(i,j))
	randomize()
	positions.shuffle()
	PLAYER1_STARTPOS=positions[0]
	PLAYER2_STARTPOS=positions[1]
	PLAYER3_STARTPOS=positions[2]
	PLAYER4_STARTPOS=positions[3]

func _ready():
	endGame = VarG.NoEquipos
	init()
	randomPosition()
	if(VarG.NoEquipos==2):
		get_node("../../../Posiciones/Player1/Tanque1").texture=load(tanks[VarG.selEq1])
		get_node("../../../Posiciones/Player2/Tanque2").texture=load(tanks[VarG.selEq2])
		get_node("../../../Posiciones/Player3").visible=false
		get_node("../../../Posiciones/Player4").visible=false
		get_node("../../../Instrucciones/Jugador3").visible=false
		get_node("../../../Instrucciones/Label3").visible=false
		get_node("../../../Instrucciones/Jugador4").visible=false
		get_node("../../../Instrucciones/Label4").visible=false
	elif(VarG.NoEquipos==3):
		get_node("../../../Posiciones/Fondo").set_anchor(MARGIN_BOTTOM,0.74,true);
		get_node("../../../Posiciones/Player1/Tanque1").texture=load(tanks[VarG.selEq1])
		get_node("../../../Posiciones/Player2/Tanque2").texture=load(tanks[VarG.selEq2])
		get_node("../../../Posiciones/Player3").visible=true
		get_node("../../../Posiciones/Player3/Tanque3").texture=load(tanks[VarG.selEq3])
		get_node("../../../Posiciones/Player4").visible=false
		get_node("../../../Instrucciones/Jugador4").visible=false
		get_node("../../../Instrucciones/Label4").visible=false
	elif(VarG.NoEquipos==4):
		get_node("../../../Posiciones/Fondo").set_anchor(MARGIN_BOTTOM,0.99,true);
		get_node("../../../Posiciones/Player1/Tanque1").texture=load(tanks[VarG.selEq1])
		get_node("../../../Posiciones/Player2/Tanque2").texture=load(tanks[VarG.selEq2])
		get_node("../../../Posiciones/Player3").visible=true
		get_node("../../../Posiciones/Player3/Tanque3").texture=load(tanks[VarG.selEq3])
		get_node("../../../Posiciones/Player4").visible=true
		get_node("../../../Posiciones/Player4/Tanque4").texture=load(tanks[VarG.selEq4])
	tile_size = get_cell_size()
	half_tile_size = tile_size / 2
	grid_size = Vector2(cell_quadrant_size, cell_quadrant_size)
	for x in range(grid_size.x):
		grid.append([])
		gridMinas.append([])
# warning-ignore:unused_variable
		for y in range(grid_size.y):
			grid[x].append(EMPTY)
			gridMinas[x].append(EMPTY)
	for x in range(VarG.TamMap):
		grid[x][0]=SACO
		grid[x][VarG.TamMap-1]=SACO
		grid[0][x]=SACO
		grid[VarG.TamMap-1][x]=SACO
	grid[0][0]=EMPTY
	grid[0][VarG.TamMap-1]=EMPTY
	grid[VarG.TamMap-1][0]=EMPTY
	grid[VarG.TamMap-1][VarG.TamMap-1]=EMPTY
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if(grid[x][y]==SACO):
				if(y==0 || y == grid_size.y-1):
					var costal = CostalH.instance()
					costal.position=map_to_world(Vector2(x,y))+half_tile_size
					add_child(costal)
				else:
					var costal = CostalV.instance()
					costal.position=map_to_world(Vector2(x,y))+half_tile_size
					add_child(costal)
	grid[0][0]=SACO
	grid[0][VarG.TamMap-1]=SACO
	grid[VarG.TamMap-1][0]=SACO
	grid[VarG.TamMap-1][VarG.TamMap-1]=SACO
	var posSacoE = [Vector2(0,0),Vector2(VarG.TamMap-1,0),Vector2(0,VarG.TamMap-1),Vector2(VarG.TamMap-1,VarG.TamMap-1)]
	var angSaco = [0,90,270,180]
	for i in range(4):
		var costal = CostalE.instance()
		costal.position=map_to_world(posSacoE[i])+half_tile_size
		costal.rota(angSaco[i])
		if(i == 1 || i ==2):
			costal.escala(Vector2(72,66))
		else:
			costal.escala(Vector2(72,72))
		add_child(costal)

	# Players
	if(NoPlayers>=2):
		var new_player1 = Player.instance()
		new_player1.position = map_to_world(PLAYER1_STARTPOS) + half_tile_size
		grid[PLAYER1_STARTPOS.x][PLAYER1_STARTPOS.y] = PLAYER
		add_child(new_player1)
		ID_Player1 = new_player1.get_instance_id()
		VarG.setIDTank1(ID_Player1)
		var new_player2 = Player.instance()
		new_player2.position = map_to_world(PLAYER2_STARTPOS) + half_tile_size
		grid[PLAYER2_STARTPOS.x][PLAYER2_STARTPOS.y] = PLAYER
		add_child(new_player2)
		ID_Player2 = new_player2.get_instance_id()
		VarG.setIDTank2(ID_Player2)
	if(NoPlayers>=3):
		var new_player3 = Player.instance()
		new_player3.position = map_to_world(PLAYER3_STARTPOS) + half_tile_size
		grid[PLAYER3_STARTPOS.x][PLAYER3_STARTPOS.y] = PLAYER
		add_child(new_player3)
		ID_Player3 = new_player3.get_instance_id()
		VarG.setIDTank3(ID_Player3)
	if(NoPlayers==4):
		var new_player4 = Player.instance()
		new_player4.position = map_to_world(PLAYER4_STARTPOS) + half_tile_size
		grid[PLAYER4_STARTPOS.x][PLAYER4_STARTPOS.y] = PLAYER
		add_child(new_player4)
		ID_Player4 = new_player4.get_instance_id()
		VarG.setIDTank4(ID_Player4)

func actualizaDatos(ruta,valor):
	get_node(ruta).text=valor

func init():
	var NoCel = VarG.TamMap
	#print(NoCel)
	var Size = get_viewport_rect().size
	Size = Vector2(Size[0]*0.5,Size[1]*0.8)
	var tamCel = Vector2(Size[0]/NoCel,Size[1]/NoCel)
	VarG.SetTamCel(tamCel)
	get_node(".").cell_quadrant_size=NoCel
	get_node(".").cell_size=tamCel
	NoPlayers = VarG.NoEquipos

func playDisparo():
	var sound = get_node("../../../DisparoLineal")
	sound.play()

func playExplosionLineal():
	var sound = get_node("../../../ExplosionLineal")
	sound.play()

func playExplosionParabolica():
	var sound = get_node("../../../ExplosionParabolica")
	sound.play()
	
func playExplosionMina():
	var sound = get_node("../../../ExplosionMina")
	sound.play()

func playExplosionTanque():
	var sound = get_node("../../../ExplosionTanque")
	sound.play()

func explosionMina(var pos):
	var explosion = ExpM.instance()
	explosion.position = pos
	add_child(explosion)
	playExplosionMina()

func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

# Check if cell at direction is vacant


func is_cell_mine(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos)
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			# If within grid return true if target cell is empty
			if gridMinas[target_grid_pos.x][target_grid_pos.y] == MINA:
				var aux = minaPawn.find(target_grid_pos)
				var ID = minaPawnID[aux]
				minaPawn.remove(aux)
				minaPawnID.remove(aux)
				gridMinas[target_grid_pos.x][target_grid_pos.y] = EMPTY
				return ID
			else:
				return -1
		else:
			return -1
	return -1

func quitaMina(var ID):
	var aux = instance_from_id(ID)
	explosionMina(aux.position)
	aux.queue_free()

func ponMina(this_world_pos):
	var mina  = Mina.instance()
	mina.position = this_world_pos
	gridMinas[world_to_map(this_world_pos).x][world_to_map(this_world_pos).y] = MINA
	add_child(mina)
	minaPawn.append(world_to_map(this_world_pos))
	minaPawnID.append(mina.get_instance_id())
	return mina.get_instance_id()

func showMine(id):
	instance_from_id(id).show()

func check_cell(position_cell):
	if position_cell.x < grid_size.x && position_cell.x >= 0:
		if position_cell.y < grid_size.y && position_cell.y >= 0:
			if grid[position_cell.x][position_cell.y] == PLAYER:
				return 1
		else:
			return 0
	else:
		return 0

func check_cellDisL(position_cell):
	if position_cell.x < grid_size.x && position_cell.x >= 0:
		if position_cell.y < grid_size.y && position_cell.y >= 0:
			return 1
		else:
			return 0
	else:
		return 0

func disparaDisL(this_world_pos, dir):
	var auxPos
	var auxWorldPos
	if dir == "(N)":
		auxPos = world_to_map(this_world_pos)-Vector2(0,1)
		this_world_pos = map_to_world(auxPos)+Vector2(half_tile_size.x,(2*half_tile_size.y))
		auxWorldPos=this_world_pos+Vector2(0,half_tile_size.y)
	elif dir == "(S)":
		auxPos = world_to_map(this_world_pos)+Vector2(0,1)
		this_world_pos = map_to_world(auxPos)+Vector2(half_tile_size.x,0)
		auxWorldPos=this_world_pos-Vector2(0,half_tile_size.y)
	elif dir == "(E)":
		auxPos = world_to_map(this_world_pos)+Vector2(1,0)
		this_world_pos = map_to_world(auxPos)+Vector2(0,half_tile_size.y)
		auxWorldPos=this_world_pos-Vector2(half_tile_size.x,0)
	elif dir == "(O)":
		auxPos = world_to_map(this_world_pos)-Vector2(1,0)
		this_world_pos = map_to_world(auxPos)+Vector2((2*half_tile_size.x),half_tile_size.y)
		auxWorldPos=this_world_pos+Vector2(half_tile_size.x,0)
	var check = check_cellDisL(auxPos)
	if check == 0:
		VarG.setDireccionEL(dir);
		explosionDisL(auxWorldPos);
		return 1
	else:
#		print("caso else")
		var disLin = DisL.instance()
		disLin.position = this_world_pos
		add_child(disLin)
#	return disLin.get_instance_id()

func explosionDisL(var pos):
	var explosion = ExpL.instance()
	explosion.position = pos
	add_child(explosion)
	playExplosionLineal()

func posIniPar(position):
	VarG.setPositionPIni(world_to_map(position))

func whatIsMyPositionMap(position):
	return world_to_map(position)

func disparaPar(this_world_pos, dir):
	var auxPos
	if dir == "(N)":
		auxPos = world_to_map(this_world_pos)-Vector2(0,1)
		this_world_pos = map_to_world(auxPos)+Vector2(half_tile_size.x,(2*half_tile_size.y))
	elif dir == "(S)":
		auxPos = world_to_map(this_world_pos)+Vector2(0,1)
		this_world_pos = map_to_world(auxPos)+Vector2(half_tile_size.x,0)
	elif dir == "(E)":
		auxPos = world_to_map(this_world_pos)+Vector2(1,0)
		this_world_pos = map_to_world(auxPos)+Vector2(0,half_tile_size.y)
	elif dir == "(O)":
		auxPos = world_to_map(this_world_pos)-Vector2(1,0)
		this_world_pos = map_to_world(auxPos)+Vector2((2*half_tile_size.x),half_tile_size.y)
	var disPar = Par.instance()
	disPar.position = this_world_pos
	add_child(disPar)
#	return disLin.get_instance_id()

func porcentajeCasilla(var tam, ID, tamTank):
	var tank = instance_from_id(ID)
	var rCXI = tam.x-VarG.tamCel.x
	var rCXF = tam.x
	var rCYI = tam.y-VarG.tamCel.y
	var rCYF = tam.y
	var rTXI = tank.position.x-(tamTank.x/2)
	var rTXF = rTXI+tamTank.x
	var rTYI = tank.position.y-(tamTank.y/2)
	var rTYF = rTYI+tamTank.y
	if(rCXI<=rTXI && rTXF<=rCXF) && (rCYI<=rTYI && rTYF<=rCYF):
		return 100
	elif(rCXI<=rTXI && rCXF>=rTXI) && (rCYI<=rTYI && rTYF<=rCYF):
		var L = rCXF-rTXI
		L = L*tamTank.y
		var percent = (L/(tamTank.x*tamTank.y))*100
		return percent
	elif(rCXI<=rTXF && rCXF>=rTXF) && (rCYI<=rTYI && rTYF<=rCYF):
		var L = rTXF-rCXI
		L = L*tamTank.y
		var percent = (L/(tamTank.x*tamTank.y))*100
		return percent
	elif(rCYI<=rTYF && rCYF>=rTYF) && (rCXI<=rTXI && rTXF<=rCXF):
		var L = rTYF-rCYI
		L = L*tamTank.x
		var percent = (L/(tamTank.x*tamTank.y))*100
		return percent
	elif(rCYI<=rTYI && rCYF>=rTYI) && (rCXI<=rTXI && rTXF<=rCXF):
		var L = rCYF-rTYI
		L = L*tamTank.x
		var percent = (L/(tamTank.x*tamTank.y))*100
		return percent
	return 0

func explosionPar(var pos):
	var explosion = ExpP.instance()
	explosion.position = pos
	add_child(explosion)

func danoPar(var pos):
	var tank1 = ID_Player1
	var tamtank1 = VarG.tamTank1
	var tank2 = ID_Player2
	var tamtank2 = VarG.tamTank2
	var tank3 = -1
	var tamtank3 = VarG.tamTank3
	var tank4 = -1
	var tamtank4 = VarG.tamTank4
	if(VarG.NoEquipos==3):
		tank3 = ID_Player3
		tamtank3 = VarG.tamTank3
	elif(VarG.NoEquipos==4):
		tank3 = ID_Player3
		tamtank3 = VarG.tamTank3
		tank4 = ID_Player4
		tamtank4 = VarG.tamTank4
	if((pos.x>=0 && pos.x<=VarG.TamMap) && (pos.y>=0 && pos.y<=VarG.TamMap)):
		explosionPar(map_to_world(pos)+half_tile_size)
		var aux = map_to_world(pos)+VarG.tamCel
		if(tank1 != -1):
			var banderaTank1 = false
			var danoCentral = 0
			var danoLO = 0
			var danoLE = 0
			var danoLN = 0
			var danoLS = 0
			var danoENE = 0
			var danoESE = 0
			var danoENO = 0
			var danoESO = 0
			danoCentral = porcentajeCasilla(aux, tank1,tamtank1)
			if(danoCentral==100):
				instance_from_id(tank1).v-=VarG.hurtDisP
				banderaTank1 = true
			elif(danoCentral>50):
				instance_from_id(tank1).v-=VarG.hurtDisP
				banderaTank1 = true
			var LO = pos+Vector2(-1,0)
			if(LO.x>=0 && LO.x<=VarG.TamMap) && (LO.y>=0 && LO.y<=VarG.TamMap) && banderaTank1!=true:
				LO = map_to_world(LO)+VarG.tamCel
				danoLO = porcentajeCasilla(LO, tank1,tamtank1)
				if(danoLO == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoLO > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var LE = pos+Vector2(1,0)
			if(LE.x>=0 && LE.x<=VarG.TamMap) && (LE.y>=0 && LE.y<=VarG.TamMap) && banderaTank1!=true:
				LE = map_to_world(LE)+VarG.tamCel
				danoLE = porcentajeCasilla(LE, tank1,tamtank1)
				if(danoLE == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoLE > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var LN = pos+Vector2(0,-1)
			if(LN.x>=0 && LN.x<=VarG.TamMap) && (LN.y>=0 && LN.y<=VarG.TamMap) && banderaTank1!=true:
				LN = map_to_world(LN)+VarG.tamCel
				danoLN = porcentajeCasilla(LN, tank1,tamtank1)
				if(danoLN == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoLN > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var LS = pos+Vector2(0,1)
			if(LS.x>=0 && LS.x<=VarG.TamMap) && (LS.y>=0 && LS.y<=VarG.TamMap) && banderaTank1!=true:
				LS = map_to_world(LS)+VarG.tamCel
				danoLS = porcentajeCasilla(LS, tank1,tamtank1)
				if(danoLS == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoLS > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var ENE = pos+Vector2(1,-1)
			if(ENE.x>=0 && ENE.x<=VarG.TamMap) && (ENE.y>=0 && ENE.y<=VarG.TamMap) && banderaTank1!=true:
				ENE = map_to_world(ENE)+VarG.tamCel
				danoENE = porcentajeCasilla(ENE, tank1,tamtank1)
				if(danoENE == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoENE > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var ESE = pos+Vector2(1,1)
			if(ESE.x>=0 && ESE.x<=VarG.TamMap) && (ESE.y>=0 && ESE.y<=VarG.TamMap) && banderaTank1!=true:
				ESE = map_to_world(ESE)+VarG.tamCel
				danoESE = porcentajeCasilla(ESE, tank1,tamtank1)
				if(danoESE == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoESE > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var ENO = pos+Vector2(-1,-1)
			if(ENO.x>=0 && ENO.x<=VarG.TamMap) && (ENO.y>=0 && ENO.y<=VarG.TamMap) && banderaTank1!=true:
				ENO = map_to_world(ENO)+VarG.tamCel
				danoENO = porcentajeCasilla(ENO, tank1,tamtank1)
				if(danoENO == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoENO > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
			var ESO = pos+Vector2(-1,1)
			if(ESO.x>=0 && ESO.x<=VarG.TamMap) && (ESO.y>=0 && ESO.y<=VarG.TamMap) && banderaTank1!=true:
				ESO = map_to_world(ESO)+VarG.tamCel
				danoESO = porcentajeCasilla(ESO, tank1,tamtank1)
				if(danoESO == 100):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
				elif(danoENO > 50):
					instance_from_id(tank1).v-=VarG.hurtDisPL
					banderaTank1 = true
		if(tank2 != -1):
			var banderaTank2 = false
			var danoCentral = 0
			var danoLO = 0
			var danoLE = 0
			var danoLN = 0
			var danoLS = 0
			var danoENE = 0
			var danoESE = 0
			var danoENO = 0
			var danoESO = 0
			danoCentral = porcentajeCasilla(aux, tank2,tamtank2)
			if(danoCentral==100):
				instance_from_id(tank2).v-=VarG.hurtDisP
				banderaTank2 = true
			elif(danoCentral>50):
				instance_from_id(tank2).v-=VarG.hurtDisP
				banderaTank2 = true
			var LO = pos+Vector2(-1,0)
			if(LO.x>=0 && LO.x<=VarG.TamMap) && (LO.y>=0 && LO.y<=VarG.TamMap) && banderaTank2!=true:
				LO = map_to_world(LO)+VarG.tamCel
				danoLO = porcentajeCasilla(LO, tank2,tamtank2)
				if(danoLO == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoLO > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var LE = pos+Vector2(1,0)
			if(LE.x>=0 && LE.x<=VarG.TamMap) && (LE.y>=0 && LE.y<=VarG.TamMap) && banderaTank2!=true:
				LE = map_to_world(LE)+VarG.tamCel
				danoLE = porcentajeCasilla(LE, tank2,tamtank2)
				if(danoLE == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoLE > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var LN = pos+Vector2(0,-1)
			if(LN.x>=0 && LN.x<=VarG.TamMap) && (LN.y>=0 && LN.y<=VarG.TamMap) && banderaTank2!=true:
				LN = map_to_world(LN)+VarG.tamCel
				danoLN = porcentajeCasilla(LN, tank2,tamtank2)
				if(danoLN == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoLN > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var LS = pos+Vector2(0,1)
			if(LS.x>=0 && LS.x<=VarG.TamMap) && (LS.y>=0 && LS.y<=VarG.TamMap) && banderaTank2!=true:
				LS = map_to_world(LS)+VarG.tamCel
				danoLS = porcentajeCasilla(LS, tank2,tamtank2)
				if(danoLS == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoLS > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var ENE = pos+Vector2(1,-1)
			if(ENE.x>=0 && ENE.x<=VarG.TamMap) && (ENE.y>=0 && ENE.y<=VarG.TamMap) && banderaTank2!=true:
				ENE = map_to_world(ENE)+VarG.tamCel
				danoENE = porcentajeCasilla(ENE, tank2,tamtank2)
				if(danoENE == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoENE > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var ESE = pos+Vector2(1,1)
			if(ESE.x>=0 && ESE.x<=VarG.TamMap) && (ESE.y>=0 && ESE.y<=VarG.TamMap) && banderaTank2!=true:
				ESE = map_to_world(ESE)+VarG.tamCel
				danoESE = porcentajeCasilla(ESE, tank2,tamtank2)
				if(danoESE == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoESE > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var ENO = pos+Vector2(-1,-1)
			if(ENO.x>=0 && ENO.x<=VarG.TamMap) && (ENO.y>=0 && ENO.y<=VarG.TamMap) && banderaTank2!=true:
				ENO = map_to_world(ENO)+VarG.tamCel
				danoENO = porcentajeCasilla(ENO, tank2,tamtank2)
				if(danoENO == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoENO > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
			var ESO = pos+Vector2(-1,1)
			if(ESO.x>=0 && ESO.x<=VarG.TamMap) && (ESO.y>=0 && ESO.y<=VarG.TamMap) && banderaTank2!=true:
				ESO = map_to_world(ESO)+VarG.tamCel
				danoESO = porcentajeCasilla(ESO, tank2,tamtank2)
				if(danoESO == 100):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
				elif(danoENO > 50):
					instance_from_id(tank2).v-=VarG.hurtDisPL
					banderaTank2 = true
		if(tank3 != -1):
			var banderaTank3 = false
			var danoCentral = 0
			var danoLO = 0
			var danoLE = 0
			var danoLN = 0
			var danoLS = 0
			var danoENE = 0
			var danoESE = 0
			var danoENO = 0
			var danoESO = 0
			danoCentral = porcentajeCasilla(aux, tank3,tamtank3)
			if(danoCentral==100):
				instance_from_id(tank3).v-=VarG.hurtDisP
				banderaTank3 = true
			elif(danoCentral>50):
				instance_from_id(tank3).v-=VarG.hurtDisP
				banderaTank3 = true
			var LO = pos+Vector2(-1,0)
			if(LO.x>=0 && LO.x<=VarG.TamMap) && (LO.y>=0 && LO.y<=VarG.TamMap) && banderaTank3!=true:
				LO = map_to_world(LO)+VarG.tamCel
				danoLO = porcentajeCasilla(LO, tank3,tamtank3)
				if(danoLO == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoLO > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var LE = pos+Vector2(1,0)
			if(LE.x>=0 && LE.x<=VarG.TamMap) && (LE.y>=0 && LE.y<=VarG.TamMap) && banderaTank3!=true:
				LE = map_to_world(LE)+VarG.tamCel
				danoLE = porcentajeCasilla(LE, tank3,tamtank3)
				if(danoLE == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoLE > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var LN = pos+Vector2(0,-1)
			if(LN.x>=0 && LN.x<=VarG.TamMap) && (LN.y>=0 && LN.y<=VarG.TamMap) && banderaTank3!=true:
				LN = map_to_world(LN)+VarG.tamCel
				danoLN = porcentajeCasilla(LN, tank3,tamtank3)
				if(danoLN == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoLN > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var LS = pos+Vector2(0,1)
			if(LS.x>=0 && LS.x<=VarG.TamMap) && (LS.y>=0 && LS.y<=VarG.TamMap) && banderaTank3!=true:
				LS = map_to_world(LS)+VarG.tamCel
				danoLS = porcentajeCasilla(LS, tank3,tamtank3)
				if(danoLS == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoLS > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var ENE = pos+Vector2(1,-1)
			if(ENE.x>=0 && ENE.x<=VarG.TamMap) && (ENE.y>=0 && ENE.y<=VarG.TamMap) && banderaTank3!=true:
				ENE = map_to_world(ENE)+VarG.tamCel
				danoENE = porcentajeCasilla(ENE, tank3,tamtank3)
				if(danoENE == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoENE > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var ESE = pos+Vector2(1,1)
			if(ESE.x>=0 && ESE.x<=VarG.TamMap) && (ESE.y>=0 && ESE.y<=VarG.TamMap) && banderaTank3!=true:
				ESE = map_to_world(ESE)+VarG.tamCel
				danoESE = porcentajeCasilla(ESE, tank3,tamtank3)
				if(danoESE == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoESE > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var ENO = pos+Vector2(-1,-1)
			if(ENO.x>=0 && ENO.x<=VarG.TamMap) && (ENO.y>=0 && ENO.y<=VarG.TamMap) && banderaTank3!=true:
				ENO = map_to_world(ENO)+VarG.tamCel
				danoENO = porcentajeCasilla(ENO, tank3,tamtank3)
				if(danoENO == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoENO > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
			var ESO = pos+Vector2(-1,1)
			if(ESO.x>=0 && ESO.x<=VarG.TamMap) && (ESO.y>=0 && ESO.y<=VarG.TamMap) && banderaTank3!=true:
				ESO = map_to_world(ESO)+VarG.tamCel
				danoESO = porcentajeCasilla(ESO, tank3,tamtank3)
				if(danoESO == 100):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
				elif(danoENO > 50):
					instance_from_id(tank3).v-=VarG.hurtDisPL
					banderaTank3 = true
		if(tank4 != -1):
			var banderaTank4 = false
			var danoCentral = 0
			var danoLO = 0
			var danoLE = 0
			var danoLN = 0
			var danoLS = 0
			var danoENE = 0
			var danoESE = 0
			var danoENO = 0
			var danoESO = 0
			danoCentral = porcentajeCasilla(aux, tank4,tamtank4)
			if(danoCentral==100):
				instance_from_id(tank4).v-=VarG.hurtDisP
				banderaTank4 = true
			elif(danoCentral>50):
				instance_from_id(tank4).v-=VarG.hurtDisP
				banderaTank4 = true
			var LO = pos+Vector2(-1,0)
			if(LO.x>=0 && LO.x<=VarG.TamMap) && (LO.y>=0 && LO.y<=VarG.TamMap) && banderaTank4!=true:
				LO = map_to_world(LO)+VarG.tamCel
				danoLO = porcentajeCasilla(LO, tank4,tamtank4)
				if(danoLO == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoLO > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var LE = pos+Vector2(1,0)
			if(LE.x>=0 && LE.x<=VarG.TamMap) && (LE.y>=0 && LE.y<=VarG.TamMap) && banderaTank4!=true:
				LE = map_to_world(LE)+VarG.tamCel
				danoLE = porcentajeCasilla(LE, tank4,tamtank4)
				if(danoLE == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoLE > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var LN = pos+Vector2(0,-1)
			if(LN.x>=0 && LN.x<=VarG.TamMap) && (LN.y>=0 && LN.y<=VarG.TamMap) && banderaTank4!=true:
				LN = map_to_world(LN)+VarG.tamCel
				danoLN = porcentajeCasilla(LN, tank4,tamtank4)
				if(danoLN == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoLN > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var LS = pos+Vector2(0,1)
			if(LS.x>=0 && LS.x<=VarG.TamMap) && (LS.y>=0 && LS.y<=VarG.TamMap) && banderaTank4!=true:
				LS = map_to_world(LS)+VarG.tamCel
				danoLS = porcentajeCasilla(LS, tank4,tamtank4)
				if(danoLS == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoLS > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var ENE = pos+Vector2(1,-1)
			if(ENE.x>=0 && ENE.x<=VarG.TamMap) && (ENE.y>=0 && ENE.y<=VarG.TamMap) && banderaTank4!=true:
				ENE = map_to_world(ENE)+VarG.tamCel
				danoENE = porcentajeCasilla(ENE, tank4,tamtank4)
				if(danoENE == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoENE > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var ESE = pos+Vector2(1,1)
			if(ESE.x>=0 && ESE.x<=VarG.TamMap) && (ESE.y>=0 && ESE.y<=VarG.TamMap) && banderaTank4!=true:
				ESE = map_to_world(ESE)+VarG.tamCel
				danoESE = porcentajeCasilla(ESE, tank4,tamtank4)
				if(danoESE == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoESE > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var ENO = pos+Vector2(-1,-1)
			if(ENO.x>=0 && ENO.x<=VarG.TamMap) && (ENO.y>=0 && ENO.y<=VarG.TamMap) && banderaTank4!=true:
				ENO = map_to_world(ENO)+VarG.tamCel
				danoENO = porcentajeCasilla(ENO, tank4,tamtank4)
				if(danoENO == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoENO > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
			var ESO = pos+Vector2(-1,1)
			if(ESO.x>=0 && ESO.x<=VarG.TamMap) && (ESO.y>=0 && ESO.y<=VarG.TamMap) && banderaTank4!=true:
				ESO = map_to_world(ESO)+VarG.tamCel
				danoESO = porcentajeCasilla(ESO, tank4,tamtank4)
				if(danoESO == 100):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
				elif(danoENO > 50):
					instance_from_id(tank4).v-=VarG.hurtDisPL
					banderaTank4 = true
		return false
	else:
		return false

func quita(var id):
	var bien = instance_from_id(id)
	bien.queue_free()

func explosionTank(var pos):
	var explosion = ExpT.instance()
	explosion.position = pos
	add_child(explosion)

func quitaTank(var id):
	var bien = instance_from_id(id)
	var pos = world_to_map(bien.position)
	explosionTank(bien.position)
	grid[pos.x][pos.y]=EMPTY
	if(id==ID_Player1):
		ID_Player1=-1
		VarG.setIDTank1(ID_Player1)
	elif(id==ID_Player2):
		ID_Player2=-1
		VarG.setIDTank2(ID_Player2)
	if(id==ID_Player3):
		ID_Player3=-1
		VarG.setIDTank3(ID_Player3)
	elif(id==ID_Player4):
		ID_Player4=-1
		VarG.setIDTank4(ID_Player4)
	bien.queue_free()
	EndGame()
	playExplosionTanque()

func getPosiciones(var pos):
	var posiciones = []
	var tank1
	var tank2
	var tank3
	var tank4
	if(ID_Player1!=-1):
		tank1=instance_from_id(ID_Player1)
		if(pos!=tank1.position):
			posiciones.append(world_to_map(tank1.position))
	if(ID_Player2!=-1):
		tank2=instance_from_id(ID_Player2)
		if(pos!=tank2.position):
			posiciones.append(world_to_map(tank2.position))
	if(VarG.NoEquipos>=3 && ID_Player3!=-1):
		tank3=instance_from_id(ID_Player3)
		if(pos!=tank3.position):
			posiciones.append(world_to_map(tank3.position))
	if(VarG.NoEquipos==4 && ID_Player4!=-1):
		tank4=instance_from_id(ID_Player4)
		if(pos!=tank4.position):
			posiciones.append(world_to_map(tank4.position))
	return posiciones

func cell_in_front_is_mine(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			if gridMinas[target_grid_pos.x][target_grid_pos.y] == MINA:
				return true
	else:
		return false

func is_cell_vacant(this_grid_pos=Vector2(), direction=Vector2()):
	var target_grid_pos = world_to_map(this_grid_pos) + direction

	# Check if target cell is within the grid
	if target_grid_pos.x < grid_size.x and target_grid_pos.x >= 0:
		if target_grid_pos.y < grid_size.y and target_grid_pos.y >= 0:
			if grid[target_grid_pos.x][target_grid_pos.y] != PLAYER && grid[target_grid_pos.x][target_grid_pos.y] != SACO:
				return true
			else:
				return false
	return false


func no_update_child_pos(this_world_pos, direction):
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction
	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos

# Remove node from current cell, add it to the new cell,
# returns the new world target position
func update_child_pos(this_world_pos, direction, type):
	var this_grid_pos = world_to_map(this_world_pos)
	var new_grid_pos = this_grid_pos + direction

	# remove player from current grid location
	if(type==MINA):
		gridMinas[this_grid_pos.x][this_grid_pos.y] = EMPTY

		# place player on new grid location
		gridMinas[new_grid_pos.x][new_grid_pos.y] = type
	else:
		grid[this_grid_pos.x][this_grid_pos.y] = EMPTY
	
		# place player on new grid location
		grid[new_grid_pos.x][new_grid_pos.y] = type

	var new_world_pos = map_to_world(new_grid_pos) + half_tile_size
	return new_world_pos

func estableceVida(Eq,vida):
	if(Eq == 0):
		get_node("../../../Posiciones/Player1/Panel/Vida").texture=load(Imgvida[vida])
	elif(Eq == 1):
		get_node("../../../Posiciones/Player2/Panel/Vida").texture=load(Imgvida[vida])
	elif(Eq == 2):
		get_node("../../../Posiciones/Player3/Panel/Vida").texture=load(Imgvida[vida])
	elif(Eq == 3):
		get_node("../../../Posiciones/Player4/Panel/Vida").texture=load(Imgvida[vida])

func estableceAmmoDisL(Eq,ammoL):
	if(Eq == 0):
		if(ammoL == 21):
			get_node("../../../Posiciones/Player1/Panel/PanelDL/Label").text="?"
		elif(ammoL == 0):
			get_node("../../../Posiciones/Player1/Panel/PanelDL/Label").text="0"
		else:
			get_node("../../../Posiciones/Player1/Panel/PanelDL/Label").text=str("x",ammoL)
	elif(Eq == 1):
		if(ammoL == 21):
			get_node("../../../Posiciones/Player2/Panel/PanelDL/Label").text="?"
		elif(ammoL == 0):
			get_node("../../../Posiciones/Player2/Panel/PanelDL/Label").text="0"
		else:
			get_node("../../../Posiciones/Player2/Panel/PanelDL/Label").text=str("x",ammoL)
	elif(Eq == 2):
		if(ammoL == 21):
			get_node("../../../Posiciones/Player3/Panel/PanelDL/Label").text="?"
		elif(ammoL == 0):
			get_node("../../../Posiciones/Player3/Panel/PanelDL/Label").text="0"
		else:
			get_node("../../../Posiciones/Player3/Panel/PanelDL/Label").text=str("x",ammoL)
	elif(Eq == 3):
		if(ammoL == 21):
			get_node("../../../Posiciones/Player4/Panel/PanelDL/Label").text="?"
		elif(ammoL == 0):
			get_node("../../../Posiciones/Player4/Panel/PanelDL/Label").text="0"
		else:
			get_node("../../../Posiciones/Player4/Panel/PanelDL/Label").text=str("x",ammoL)

func estableceAmmoDisP(Eq,ammoP):
	if(Eq == 0):
		if(ammoP == 21):
			get_node("../../../Posiciones/Player1/Panel/PanelDP/Label").text="?"
		elif(ammoP == 0):
			get_node("../../../Posiciones/Player1/Panel/PanelDP/Label").text="0"
		else:
			get_node("../../../Posiciones/Player1/Panel/PanelDP/Label").text=str("x",ammoP)
	elif(Eq == 1):
		if(ammoP == 21):
			get_node("../../../Posiciones/Player2/Panel/PanelDP/Label").text="?"
		elif(ammoP == 0):
			get_node("../../../Posiciones/Player2/Panel/PanelDP/Label").text="0"
		else:
			get_node("../../../Posiciones/Player2/Panel/PanelDP/Label").text=str("x",ammoP)
	elif(Eq == 2):
		if(ammoP == 21):
			get_node("../../../Posiciones/Player3/Panel/PanelDP/Label").text="?"
		elif(ammoP == 0):
			get_node("../../../Posiciones/Player3/Panel/PanelDP/Label").text="0"
		else:
			get_node("../../../Posiciones/Player3/Panel/PanelDP/Label").text=str("x",ammoP)
	elif(Eq == 3):
		if(ammoP == 21):
			get_node("../../../Posiciones/Player4/Panel/PanelDP/Label").text="?"
		elif(ammoP == 0):
			get_node("../../../Posiciones/Player4/Panel/PanelDP/Label").text="0"
		else:
			get_node("../../../Posiciones/Player4/Panel/PanelDP/Label").text=str("x",ammoP)
		

func estableceAmmoMin(Eq, ammoM):
	if(Eq == 0):
		if(ammoM == 21):
			get_node("../../../Posiciones/Player1/Panel/PanelMin/Label").text="?"
		elif(ammoM == 0):
			get_node("../../../Posiciones/Player1/Panel/PanelMin/Label").text="0"
		else:
			get_node("../../../Posiciones/Player1/Panel/PanelMin/Label").text=str("x",ammoM)
	elif(Eq == 1):
		if(ammoM == 21):
			get_node("../../../Posiciones/Player2/Panel/PanelMin/Label").text="?"
		elif(ammoM == 0):
			get_node("../../../Posiciones/Player2/Panel/PanelMin/Label").text="0"
		else:
			get_node("../../../Posiciones/Player2/Panel/PanelMin/Label").text=str("x",ammoM)
	elif(Eq == 2):
		if(ammoM == 21):
			get_node("../../../Posiciones/Player3/Panel/PanelMin/Label").text="?"
		elif(ammoM == 0):
			get_node("../../../Posiciones/Player3/Panel/PanelMin/Label").text="0"
		else:
			get_node("../../../Posiciones/Player3/Panel/PanelMin/Label").text=str("x",ammoM)
	elif(Eq == 3):
		if(ammoM == 21):
			get_node("../../../Posiciones/Player4/Panel/PanelMin/Label").text="?"
		elif(ammoM == 0):
			get_node("../../../Posiciones/Player4/Panel/PanelMin/Label").text="0"
		else:
			get_node("../../../Posiciones/Player4/Panel/PanelMin/Label").text=str("x",ammoM)

func estableceCodigo(Eq,lineas):
	if(Eq == 0):
		get_node("../../../Instrucciones/Jugador1").text=lineas
	elif(Eq == 1):
		get_node("../../../Instrucciones/Jugador2").text=lineas
	elif(Eq == 2):
		get_node("../../../Instrucciones/Jugador3").text=lineas
	elif(Eq == 3):
		get_node("../../../Instrucciones/Jugador4").text=lineas

func _on_Salir_pressed():
	get_tree().paused = false
	VarG.setInstancia(0)
	VarG.NoEquipos=2
	get_tree().reload_current_scene()
	VarG.setInstancia(0)
	VarG.NoEquipos=0
	TransicionPerdedor.ejecuta()



func EndGame():
	endGame = endGame-1
	var cont = 4
	if(VarG.IDTank1==-1):
		cont-=1
	if(VarG.IDTank2==-1):
		cont-=1
	if(VarG.IDTank3==-1):
		cont-=1
	if(VarG.IDTank4==-1):
		cont-=1
	if(endGame == 1 && cont!=0):
		get_node("../../../Timer").start(3)
	elif(cont == 0):
		get_node("../../../Timer").stop()
		get_node("../../../TimerPerdedor").start(3)



func _on_Timer_timeout():
	VarG.setInstancia(0)
	VarG.NoEquipos=2
	get_tree().reload_current_scene()
	VarG.setInstancia(0)
	VarG.NoEquipos=0
	if(VarG.IDTank1!=-1):
		VarG.setWinner(1)
	if(VarG.IDTank2!=-1):
		VarG.setWinner(2)
	if(VarG.IDTank3!=-1):
		VarG.setWinner(3)
	if(VarG.IDTank4!=-1):
		VarG.setWinner(4)
	Transicion.cambio("res://Escenas/winner.tscn")


func _on_pausa_pressed():
	get_tree().paused = !get_tree().paused


func _on_TimerPerdedor_timeout():
	get_tree().reload_current_scene()
	VarG.setInstancia(0)
	VarG.NoEquipos=0
	TransicionPerdedor.ejecuta()
