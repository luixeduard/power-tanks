extends KinematicBody2D

var direction = Vector2()
#
const MAX_SPEED = 200
#
var speed = 0
var velocity = Vector2()
#
var world_target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false
var type
var grid

var ant = "E"
var antC= "E"
var antAngC = 0

var directionAnt = Vector2()

var timer

var muevete = true

var Cuerpos = ["res://graphics/model/TopDown_soldier_tank_body1.png","res://graphics/model/TopDown_soldier_tank_body2.png","res://graphics/model/TopDown_soldier_tank_body3.png","res://graphics/model/TopDown_soldier_tank_body4.png","res://graphics/model/TopDown_soldier_tank_body5.png","res://graphics/model/TopDown_soldier_tank_body6.png","res://graphics/model/TopDown_soldier_tank_body7.png","res://graphics/model/TopDown_soldier_tank_body8.png","res://graphics/model/TopDown_soldier_tank_body9.png"]
var Cabezas = ["res://graphics/model/TopDown_soldier_tank_turrent1.png","res://graphics/model/TopDown_soldier_tank_turrent2.png","res://graphics/model/TopDown_soldier_tank_turrent3.png","res://graphics/model/TopDown_soldier_tank_turrent4.png","res://graphics/model/TopDown_soldier_tank_turrent5.png","res://graphics/model/TopDown_soldier_tank_turrent6.png","res://graphics/model/TopDown_soldier_tank_turrent7.png","res://graphics/model/TopDown_soldier_tank_turrent8.png","res://graphics/model/TopDown_soldier_tank_turrent9.png"]
var ParabolicCabezas = ["res://graphics/model/Parabolic_TopDown_soldier_tank_turrent1.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent2.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent3.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent4.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent5.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent6.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent7.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent8.png","res://graphics/model/Parabolic_TopDown_soldier_tank_turrent9.png"] 

var lineas
var lineasSep
var linea = "null"

var apuntador=0
var tamLineas

var jugador

var PMina=Vector2(-1,-1)
var explosionMina=-1

#Daño de los jugadores
var hurtMin = VarG.hurtMin
var hurtDisP = VarG.hurtDisP
var hurtDisL = VarG.hurtDisL

var tamTanque
var tamTanqueInv

#Municion del jugador

var L = VarG.ammoDisL
var P = VarG.ammoDisP
var M = VarG.ammoMin

#vida del jugador
var v = 20
var R = 0

# Mientras
var PilaInicioMientras = []
var PilaFinMientras = []
#var l

var mina = []

func separaLineas():
	lineas = lineas.substr(0,lineas.length()-1)
	lineas = lineas.replace("\t","")
	lineasSep=lineas.split("\n",true,0)

func tablaWhile():
	var pila = []
	var tablaMientras = []
	for i in lineasSep.size():
		var linea = lineasSep[i]
		if(linea.begins_with("Mientras")):
			pila.append(i)
		elif(linea=="Fin Mientras"):
			var pos = pila.pop_back()
			tablaMientras.append(Vector2(pos,i))
	for i in tablaMientras.size():
		PilaInicioMientras.append(int(tablaMientras[i].x))
		PilaFinMientras.append(int(tablaMientras[i].y))

func _ready():
	var scala = Vector2(VarG.tamCel[0]/680,VarG.tamCel[1]/480)
	tamTanque = scala*Vector2(428,280)
	tamTanqueInv = Vector2(tamTanque.y,tamTanque.x)
	var scal = Vector2(VarG.tamCel[0]/880,VarG.tamCel[1]/780)
	get_node("radarr").set("scale",scal)
	if(VarG.instanciado==0):
		lineas = leeArchivo(VarG.scriptEq1)
		get_node("Cuerpo").texture=load(Cuerpos[VarG.selEq1])
		get_node("Cabeza").texture=load(Cabezas[VarG.selEq1])
		get_node("CabezaParabolico").texture=load(ParabolicCabezas[VarG.selEq1])
		VarG.setTamTank1(tamTanque)
	elif(VarG.instanciado==1):
		lineas = leeArchivo(VarG.scriptEq2)
		get_node("Cuerpo").texture=load(Cuerpos[VarG.selEq2])
		get_node("Cabeza").texture=load(Cabezas[VarG.selEq2])
		get_node("CabezaParabolico").texture=load(ParabolicCabezas[VarG.selEq2])
		VarG.setTamTank2(tamTanque)
	elif(VarG.instanciado==2):
		lineas = leeArchivo(VarG.scriptEq3)
		get_node("Cuerpo").texture=load(Cuerpos[VarG.selEq3])
		get_node("Cabeza").texture=load(Cabezas[VarG.selEq3])
		get_node("CabezaParabolico").texture=load(ParabolicCabezas[VarG.selEq3])
		VarG.setTamTank3(tamTanque)
	elif(VarG.instanciado==3):
		lineas = leeArchivo(VarG.scriptEq4)
		get_node("Cuerpo").texture=load(Cuerpos[VarG.selEq4])
		get_node("Cabeza").texture=load(Cabezas[VarG.selEq4])
		get_node("CabezaParabolico").texture=load(ParabolicCabezas[VarG.selEq4])
		VarG.setTamTank4(tamTanque)
	separaLineas()
	tablaWhile()
	var scala2 = Vector2(VarG.tamCel[0]/780,VarG.tamCel[1]/480)
	get_node("Cuerpo").set("scale",scala)
	var col = RectangleShape2D.new()
	col.extents=Vector2(680,480)/VarG.tamCel
	get_node("Collision").shape=col
	get_node("Cabeza").set("scale",scala2)
	get_node("CabezaParabolico").set("scale",scala2)
	grid = get_parent()
	type = grid.PLAYER
	set_process(true)
	jugador = VarG.instanciado
	VarG.setInstancia(VarG.instanciado+1)

func leeArchivo(archivo):
	archivo = str("user://Codigos/",archivo)
	var file = File.new()
	file.open(archivo,File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func rota(ang):
	var t
	if(ang>0):
		ang = ang*180/PI
		var cont = 0
		while cont<ang:
			var rad = 15*PI/180
			get_node("Cuerpo").rotate(rad)
#			yield(get_tree().create_timer(0.001), "timeout")
			cont+=15
	else:
		ang = ang*180/PI
		var cont = 0
		while cont>ang:
			var rad = -15*PI/180
			get_node("Cuerpo").rotate(rad)
#			yield(get_tree().create_timer(0.001), "timeout")
			cont-=15
#	yield(get_tree().create_timer(0.001), "timeout")
	muevete=true
	

func mover(dir):
	var scala = Vector2(VarG.tamCel[0]/680,VarG.tamCel[1]/480)
	if dir == "(N)":
		get_node("Collision").rotation_degrees=90
		if VarG.IDTank1==get_instance_id():
			VarG.setTamTank1(tamTanqueInv)
		elif VarG.IDTank2==get_instance_id():
			VarG.setTamTank2(tamTanqueInv)
		elif VarG.IDTank3==get_instance_id():
			VarG.setTamTank3(tamTanqueInv)
		elif VarG.IDTank4==get_instance_id():
			VarG.setTamTank4(tamTanqueInv)
		if ant == "E":
			muevete = false
			rota(PI/2)
		elif ant == "O":
			muevete = false
			rota(-PI/2)
		direction.y = -1
		ant = "N"
	elif dir == "(S)":
		get_node("Collision").rotation_degrees=90
		if VarG.IDTank1==get_instance_id():
			VarG.setTamTank1(tamTanqueInv)
		elif VarG.IDTank2==get_instance_id():
			VarG.setTamTank2(tamTanqueInv)
		elif VarG.IDTank3==get_instance_id():
			VarG.setTamTank3(tamTanqueInv)
		elif VarG.IDTank4==get_instance_id():
			VarG.setTamTank4(tamTanqueInv)
		if ant == "E":
			muevete = false
			rota(-PI/2)
		elif ant == "O":
			muevete = false
			rota(PI/2)
		direction.y = 1
		ant = "S"
	elif dir == "(O)":
		get_node("Collision").rotation_degrees=0
		if VarG.IDTank1==get_instance_id():
			VarG.setTamTank1(tamTanque)
		elif VarG.IDTank2==get_instance_id():
			VarG.setTamTank2(tamTanque)
		elif VarG.IDTank3==get_instance_id():
			VarG.setTamTank3(tamTanque)
		elif VarG.IDTank4==get_instance_id():
			VarG.setTamTank4(tamTanque)
		if ant == "N":
			muevete = false
			rota(PI/2)
		elif ant == "S":
			muevete = false
			rota(-PI/2)
		direction.x = -1
		ant = "O"
	elif dir == "(E)":
		get_node("Collision").rotation_degrees=0
		if VarG.IDTank1==get_instance_id():
			VarG.setTamTank1(tamTanque)
		elif VarG.IDTank2==get_instance_id():
			VarG.setTamTank2(tamTanque)
		elif VarG.IDTank3==get_instance_id():
			VarG.setTamTank3(tamTanque)
		elif VarG.IDTank4==get_instance_id():
			VarG.setTamTank4(tamTanque)
		if ant == "N":
			muevete = false
			rota(-PI/2)
		elif ant == "S":
			muevete = false
			rota(PI/2)
		direction.x = 1
		ant = "E"

func rotaC(dir):
	var ang = 0
	if dir == "(N)":
		if antC == "E":
			muevete = false
			ang = -PI/2
		elif antC == "O":
			muevete = false
			ang = PI/2
		elif antC == "S":
			muevete = false
			ang = PI
		antC = "N"
	elif dir == "(S)":
		if antC == "E":
			muevete = false
			ang = PI/2
		elif antC == "O":
			muevete = false
			ang = -PI/2
		elif antC == "N":
			muevete = false
			ang = PI
		antC = "S"
	elif dir == "(O)":
		if antC == "N":
			muevete = false
			ang = -PI/2
		elif antC == "S":
			muevete = false
			ang = PI/2
		elif antC == "E":
			muevete = false
			ang = PI
		antC = "O"
	elif dir == "(E)":
		if antC == "N":
			muevete = false
			ang = PI/2
		elif antC == "S":
			muevete = false
			ang = -PI/2
		elif antC == "O":
			muevete = false
			ang = PI
		antC = "E"
	get_node("Cabeza").rotate(ang)
	get_node("CabezaParabolico").rotate(ang)
	muevete=true

func comandoRadar(var dir):
	get_node("radarr").show()
	var myPosition = grid.whatIsMyPositionMap(position)
	var posiciones = grid.getPosiciones(myPosition)
	if dir == "(N)":
		var rango = myPosition.y
		var iFin = rango
		rango-=1
		for i in iFin:
			for j in posiciones.size():
				if posiciones[j].y == rango && posiciones[j].x == myPosition.x:
					R=i+1
					return true
			rango-=1
		R=-iFin
		return false
	elif dir == "(E)":
		var rango = myPosition.x+1
		var iFin = VarG.TamMap-(rango)
		for i in iFin:
			for j in posiciones.size():
				if posiciones[j].x == rango  && posiciones[j].y == myPosition.y:
					R=i+1
					return true
			rango+=1
		R=-iFin
	elif dir == "(S)":
		var rango = myPosition.y+1
		var iFin = VarG.TamMap-(rango)
		for i in iFin:
			for j in posiciones.size():
				if posiciones[j].y == rango && posiciones[j].x == myPosition.x:
					R=i+1
					return true
			rango+=1
		R=-iFin
		return false
	elif dir == "(O)":
		var rango = myPosition.x
		var iFin = rango
		rango-=1
		for i in iFin:
			for j in posiciones.size():
				if posiciones[j].x == rango  && posiciones[j].y == myPosition.y:
					R=i+1
					return true
			rango-=1
		R=-iFin
		return false

func cumplioCondicion(lineaE):
	if(lineaE.substr(0,lineaE.findn("(",0))=="Mov"):
		Movimiento(lineaE)
	elif(linea.substr(0,lineaE.findn("(",0))=="Dis"):
		DisparoLineal(lineaE)
	elif(linea.substr(0,lineaE.findn("(",0))=="Par"):
		DisparoParabolico(lineaE)
	elif(lineaE=="Min()" && M>0):
		Mina()
	elif(lineaE.substr(0,lineaE.findn("(",0))=="Rad"):
		Radar(lineaE)

func comandoIF(var token):
	if(token[0]=="M"):
		if(token[1]==">"):
			if(M>int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]==">="):
			if(M>=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="=="):
			if(M==int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<"):
			if(M<int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<="):
			if(M<=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="!="):
			if(M!=int(token[2])):
				cumplioCondicion(token[3])
	elif(token[0]=="L"):
		if(token[1]==">"):
			if(L>int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]==">="):
			if(L>=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="=="):
			if(L==int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<"):
			if(L<int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<="):
			if(L<=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="!="):
			if(L!=int(token[2])):
				cumplioCondicion(token[3])
	elif(token[0]=="P"):
		if(token[1]==">"):
			if(P>int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]==">="):
			if(P>=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="=="):
			if(P==int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<"):
			if(P<int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<="):
			if(P<=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="!="):
			if(P!=int(token[2])):
				cumplioCondicion(token[3])
	elif(token[0]=="R"):
		if(token[1]==">"):
			if(R>int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]==">="):
			if(R>=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="=="):
			if(R==int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<"):
			if(R<int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="<="):
			if(R<=int(token[2])):
				cumplioCondicion(token[3])
		elif(token[1]=="!="):
			if(R!=int(token[2])):
				cumplioCondicion(token[3])
	elif(token[0]=="V"):
		if(token[1]==">"):
			if(v>(int(token[2])/5)):
				cumplioCondicion(token[3])
		elif(token[1]==">="):
			if(v>=(int(token[2])/5)):
				cumplioCondicion(token[3])
		elif(token[1]=="=="):
			if(v==(int(token[2])/5)):
				cumplioCondicion(token[3])
		elif(token[1]=="<"):
			if(v<(int(token[2])/5)):
				cumplioCondicion(token[3])
		elif(token[1]=="<="):
			if(v<=(int(token[2])/5)):
				cumplioCondicion(token[3])
		elif(token[1]=="!="):
			if(v!=(int(token[2])/5)):
				cumplioCondicion(token[3])

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 2
	timer.connect("timeout", self, "_timeout")


func _timeout():
	var auxlineas=""
	if(apuntador==lineasSep.size()):
		linea = ""
		grid.estableceCodigo(jugador,linea)
	else:
		linea = lineasSep[apuntador]
		auxlineas=lineasSep[apuntador]
		apuntador+=1
		for i in range(apuntador,lineasSep.size()):
			auxlineas=str(auxlineas,"\n",lineasSep[i])
		grid.estableceCodigo(jugador,auxlineas)
	
	

func DisparoLineal(var lineaAEjecutar):
	
	if(L>0):
		rotaC(lineaAEjecutar.substr(lineaAEjecutar.find("(")))
		VarG.setDireccionL(lineaAEjecutar.substr(lineaAEjecutar.find("(")))
		
		grid.disparaDisL(position,lineaAEjecutar.substr(lineaAEjecutar.find("(")))
		if(L!=21):
			L-=1

func DisparoParabolico(var lineaAEjecutar):
	if(P>0):
		rotaC(str(lineaAEjecutar.substr(lineaAEjecutar.find("("),2),")"))
		VarG.setDireccionP(str(lineaAEjecutar.substr(lineaAEjecutar.find("("),2),")"))
		var tam = lineaAEjecutar.find(")")-(lineaAEjecutar.find(",")+1)
		grid.posIniPar(position)
		VarG.setPositionPFin(lineaAEjecutar.substr(lineaAEjecutar.find(",")+1,tam))
		grid.disparaPar(position,str(lineaAEjecutar.substr(lineaAEjecutar.find("("),2),")"))
		if(P!=21):
			P-=1


func Radar(var lineaAEjecutar):
	comandoRadar(lineaAEjecutar.substr(lineaAEjecutar.find("(")))
	

func IF(var lineaAEjecutar):
	var lineaIF = lineaAEjecutar.replace("Si ","")
	lineaIF = lineaIF.replace(" Entonces "," ")
	var tokens = lineaIF.split(" ",true)
	comandoIF(tokens)

func Mina():
	PMina=position

func verificarCondicionMientras(var token):
	if(token[0]=="M"):
		if(token[1]==">"):
			if(M>int(token[2])):
				return true
		elif(token[1]==">="):
			if(M>=int(token[2])):
				return true
		elif(token[1]=="=="):
			if(M==int(token[2])):
				return true
		elif(token[1]=="<"):
			if(M<int(token[2])):
				return true
		elif(token[1]=="<="):
			if(M<=int(token[2])):
				return true
		elif(token[1]=="!="):
			if(M!=int(token[2])):
				return true
	if(token[0]=="L"):
		if(token[1]==">"):
			if(L>int(token[2])):
				return true
		elif(token[1]==">="):
			if(L>=int(token[2])):
				return true
		elif(token[1]=="=="):
			if(L==int(token[2])):
				return true
		elif(token[1]=="<"):
			if(L<int(token[2])):
				return true
		elif(token[1]=="<="):
			if(L<=int(token[2])):
				return true
		elif(token[1]=="!="):
			if(L!=int(token[2])):
				return true
	elif(token[0]=="P"):
		if(token[1]==">"):
			if(P>int(token[2])):
				return true
		elif(token[1]==">="):
			if(P>=int(token[2])):
				return true
		elif(token[1]=="=="):
			if(P==int(token[2])):
				return true
		elif(token[1]=="<"):
			if(P<int(token[2])):
				return true
		elif(token[1]=="<="):
			if(P<=int(token[2])):
				return true
		elif(token[1]=="!="):
			if(P!=int(token[2])):
				return true
	elif(token[0]=="R"):
		if(token[1]==">"):
			if(R>int(token[2])):
				return true
		elif(token[1]==">="):
			if(R>=int(token[2])):
				return true
		elif(token[1]=="=="):
			if(R==int(token[2])):
				return true
		elif(token[1]=="<"):
			if(R<int(token[2])):
				return true
		elif(token[1]=="<="):
			if(R<=int(token[2])):
				return true
		elif(token[1]=="!="):
			if(R!=int(token[2])):
				return true
	elif(token[0]=="V"):
		if(token[1]==">"):
			if(v>(int(token[2])/5)):
				return true
		elif(token[1]==">="):
			if(v>=(int(token[2])/5)):
				return true
		elif(token[1]=="=="):
			if(v==(int(token[2])/5)):
				return true
		elif(token[1]=="<"):
			if(v<(int(token[2])/5)):
				return true
		elif(token[1]=="<="):
			if(v<=(int(token[2])/5)):
				return true
		elif(token[1]=="!="):
			if(v!=(int(token[2])/5)):
				return true
	return false

func Mientras(var lineaAEjecutar):
	var lineaMientras = lineaAEjecutar.replace("Mientras ","")
	var tokens = lineaMientras.split(" ",true)
	if verificarCondicionMientras(tokens)==false:
		var index = PilaInicioMientras.find(apuntador-1,0)
		apuntador = PilaFinMientras[index]+1

func FinMientras():
	var index = PilaFinMientras.find(apuntador-1,0)
	apuntador = PilaInicioMientras[index]

func Movimiento(var lineaAEjecutar):
	mover(lineaAEjecutar.substr(lineaAEjecutar.find("(")))

func _process(delta):
#	print(lineas)
	grid.estableceVida(jugador,v)
	grid.estableceAmmoMin(jugador,M)
	grid.estableceAmmoDisP(jugador,P)
	grid.estableceAmmoDisL(jugador,L)
	direction = Vector2()
	speed = 0
	if(v<=0):
		v=0
		grid.estableceVida(jugador,v)
		grid.quitaTank(get_instance_id())
	if(linea.substr(0,linea.findn("(",0))=="Mov"):
		Movimiento(linea)
	elif(linea.substr(0,linea.findn("(",0))=="Dis"):
		if(get_node("CabezaParabolico").visible==true):
			get_node("Cabeza").show()
			get_node("CabezaParabolico").hide()
		DisparoLineal(linea)
	elif(linea.substr(0,linea.findn("(",0))=="Par"):
		if(get_node("CabezaParabolico").visible==false):
			get_node("Cabeza").hide()
			get_node("CabezaParabolico").show()
		DisparoParabolico(linea)
	elif(linea=="Min()" && M>0):
		Mina()
	elif(linea.substr(0,linea.findn("(",0))=="Rad"):
		Radar(linea)
	elif(linea.substr(0,2)=="Si"):
		IF(linea)
	elif(linea.substr(0,8)=="Mientras"):
		Mientras(linea)
	elif(linea=="Fin Mientras"):
		FinMientras()
	if(PMina!=position && PMina!=Vector2(-1,-1) && M>0):
		mina.append(grid.ponMina(PMina))
		if(M!=21):
			M-=1
		PMina=Vector2(-1,-1)
	if muevete == true:
		if not is_moving and direction != Vector2():
			# if player is not moving and has no direction
			# then set the target direction
			target_direction = direction.normalized()
			if grid.is_cell_vacant(position, direction):
				world_target_pos = grid.update_child_pos(position, direction,type)
				is_moving = true
			else:
				directionAnt=direction
		elif not is_moving and directionAnt!= Vector2():
			target_direction = directionAnt.normalized()
			if grid.is_cell_vacant(position, directionAnt):
				world_target_pos = grid.update_child_pos(position, directionAnt,type)
				is_moving = true
			directionAnt=Vector2() 
		elif is_moving:
			speed = MAX_SPEED
			velocity = speed * target_direction * delta
	
			var distance_to_target = position.distance_to(world_target_pos)
			var move_distance = velocity.length()
	
			# Set the last movement distance to the distance to the target
			# this will make the player stop exaclty on the target
			if distance_to_target < move_distance:
				velocity = target_direction * distance_to_target
				is_moving = false
			#if(rotacion!=Vector2(0,0)):
			#look_at(Vector2(0,0))
			
			if position.distance_to(world_target_pos)<=40:
				if(mina.size()>0):
					grid.showMine(mina.pop_back())
				explosionMina = grid.is_cell_mine(world_target_pos)
				if(explosionMina!=-1):
					grid.quitaMina(explosionMina)
					explosionMina=-1
					v-=hurtMin
					if(v<0):
						v=0
			move_and_collide(velocity)
			
	linea = "null"



func _on_radarr_animation_finished():
	get_node("radarr").hide()
