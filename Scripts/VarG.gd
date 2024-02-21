extends Node

var TamMap = 6
var NoEquipos = 2
var tamPantalla = Vector2(0,0)
var tamCel = Vector2(0,0)

var selEq1
var selEq2
var selEq3
var selEq4

var scriptEq1
var scriptEq2
var scriptEq3
var scriptEq4

var ammoMin
var ammoDisP
var ammoDisL

var hurtMin
var hurtDisP
var hurtDisL
var hurtDisPE
var hurtDisPL

var instanciado = 0

var direccionL = "-"
var direccionEL = "-"
var direccionP = "-"
var positionPIni = Vector2(-1,-1)
var positionPFin = -1

var tamTank1 = Vector2(0,0)
var tamTank2 = Vector2(0,0)
var tamTank3 = Vector2(0,0)
var tamTank4 = Vector2(0,0)

var IDTank1 = -1
var IDTank2 = -1
var IDTank3 = -1
var IDTank4 = -1

var tutorial = true;

var ImgArrow
var win
var tiempo #tiempo de reproduccion del tema principal
func _ready():
	pass

func SetNoEquipos(NoEqui):
	VarG.NoEquipos = NoEqui

func SetTamMap(NoMap):
	if(NoMap==0):
		TamMap=8
	elif(NoMap==1):
		TamMap=10
	elif(NoMap==2):
		TamMap=12
	VarG.TamMap=TamMap


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files

func SetTamCel(var Tam):
	VarG.tamCel = Tam
	
func setSelEq1(var Sel):
	VarG.selEq1 = Sel
	
func setSelEq2(var Sel):
	VarG.selEq2 = Sel
	
func setSelEq3(var Sel):
	VarG.selEq3 = Sel
	
func setSelEq4(var Sel):
	VarG.selEq4 = Sel
	
func setScriptEq1(var ScriptEq):
	VarG.scriptEq1 = ScriptEq
	
func setScriptEq2(var ScriptEq):
	VarG.scriptEq2 = ScriptEq
	
func setScriptEq3(var ScriptEq):
	VarG.scriptEq3 = ScriptEq
	
func setScriptEq4(var ScriptEq):
	VarG.scriptEq4 = ScriptEq

func setInstancia(var instancia):
	VarG.instanciado = instancia

func setAmmoMin(var ammo):
	VarG.ammoMin = ammo
	
func setAmmoDisP(var ammo):
	VarG.ammoDisP = ammo

func setAmmoDisL(var ammo):
	VarG.ammoDisL = ammo

func setHurtMin(var hurt):
	VarG.hurtMin = hurt+1

func setHurtDisP(var hurt):
	VarG.hurtDisP = hurt+1
	VarG.hurtDisPE = hurt-1
	if(VarG.hurtDisPE<0):
		VarG.hurtDisPE=0
	VarG.hurtDisPL = hurt
	if(VarG.hurtDisPL<0):
		VarG.hurtDisPL=0

func setHurtDisL(var hurt):
	VarG.hurtDisL = hurt+1

func setDireccionL(var dir):
	VarG.direccionL = dir

func getDireccionL():
	var aux = VarG.direccionL
	VarG.direccionL = "-"
	return aux

func setDireccionEL(var dir):
	VarG.direccionEL = dir

func getDireccionEL():
	var aux = VarG.direccionEL
	VarG.direccionEL = "-"
	return aux

func setDireccionP(var dir):
	VarG.direccionP = dir

func getDireccionP():
	var aux = VarG.direccionP
	VarG.direccionP = "-"
	return aux

func setPositionPFin(var pos):
	VarG.positionPFin = pos

func getPositionPFin():
	var aux = VarG.positionPFin
	VarG.positionPFin = -1
	return aux

func setPositionPIni(var pos):
	VarG.positionPIni = pos

func getPositionPini():
	var aux = VarG.positionPIni
	VarG.positionPIni = Vector2(-1,-1)
	return aux

func setIDTank1(var ID):
	VarG.IDTank1 = ID

func setIDTank2(var ID):
	VarG.IDTank2 = ID

func setIDTank3(var ID):
	VarG.IDTank3 = ID

func setIDTank4(var ID):
	VarG.IDTank4 = ID

func setTamTank1(var tam):
	VarG.tamTank1 = tam

func setTamTank2(var tam):
	VarG.tamTank2 = tam

func setTamTank3(var tam):
	VarG.tamTank3 = tam

func setTamTank4(var tam):
	VarG.tamTank4 = tam
func setTime(var segundos):
	VarG.tiempo = segundos

func getTime():
	return VarG.tiempo

func setArrow(var img):
	VarG.ImgArrow = img

func setWinner(ID):
	VarG.win = ID
	
func setTutorial(boole):
	VarG.tutorial=boole
