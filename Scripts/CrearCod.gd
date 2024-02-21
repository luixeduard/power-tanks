extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var senial = 0
var nJugador = 1
var senialIf = 0
var operador = 0
var dir = "-"
var contador = 1
var aborrar = []

var operadores = [">",">=","==","<=","<","!="]

var contadorMientras = 0

var senialWhile = 0

var presionadoSi = false

var presionadoMientras = false

var tablaMientras = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func reiniciarVar():
	senial=0
	senialIf=0
	senialWhile=0
	operador=0
	presionadoSi=false
	presionadoMientras=false

func _on_Mov_pressed():
	playBoton()
	if senialIf == 0:
		get_node("Direccion").show()
		senial = 1
	elif senialIf == 1:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 11
	elif senialIf == 2:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 21
	elif senialIf == 3:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 31
	elif senialIf == 4:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 41
	elif senialIf == 5:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 51

func _on_Disp_pressed():
	playBoton()
	if senialIf == 0:
		get_node("Direccion").show()
		senial = 2
	elif senialIf == 1:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 12
	elif senialIf == 2:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 22
	elif senialIf == 3:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 32
	elif senialIf == 4:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 42
	elif senialIf == 5:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 52

func _on_Par_pressed():
	playBoton()
	if senialIf == 0:
		get_node("Direccion").show()
		senial = 3
	elif senialIf == 1:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 13
	elif senialIf == 2:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 23
	elif senialIf == 3:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 33
	elif senialIf == 4:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 43
	elif senialIf == 5:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 53

func _on_Min_pressed():
	playBoton()
	if senialIf == 0:
		agregaComando("Min()")
	elif senialIf == 1:
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxV,"Min()")
		get_node("ComandosIf").hide()
	elif senialIf == 2:
		var auxP = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxP,"Min()")
		get_node("ComandosIf").hide()
	elif senialIf == 3:
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxM,"Min()")
		get_node("ComandosIf").hide()
	elif senialIf == 4:
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxR,"Min()")
		get_node("ComandosIf").hide()
	elif senialIf == 5:
		var auxL = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxL,"Min()")
		get_node("ComandosIf").hide()

func _on_Rad_pressed():
	playBoton()
	if senialIf == 0:
		get_node("Direccion").show()
		senial=4
	elif senialIf == 1:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 14
	elif senialIf == 2:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 24
	elif senialIf == 3:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 34
	elif senialIf == 5:
		get_node("ComandosIf").hide()
		get_node("Direccion").show()
		senialIf = 54

func _on_Si_pressed():
	playBoton()
	presionadoSi=true
	get_node("Registros").show()

func _on_Mientras_pressed():
	playBoton()
	presionadoMientras=true
	get_node("Registros").show()

func tablaWhile():
	var pila = []
	for i in range(get_node("Panel/Instrucciones").get_line_count()):
		var linea = get_node("Panel/Instrucciones").get_line(i).replace("\t","")
		if(linea.begins_with("Mientras")):
			pila.append(i)
		elif(linea=="Fin Mientras"):
			var pos = pila.pop_back()
			tablaMientras.append(Vector2(pos,i))
	while pila.size()>0:
		tablaMientras.append(Vector2(pila.pop_back(),-1))

func _on_Borrar_pressed():
	playBoton()
	tablaWhile()
	var instrucciones = []
	if(aborrar.size()!=0):
		aborrar.sort()
		if(aborrar.size()==get_node("Panel/Instrucciones").get_line_count()):
			aborrar.pop_back()
		var auxAborrar = aborrar.duplicate()
		var auxTablaMientras = tablaMientras.duplicate()
		for j in range(auxTablaMientras.size()):
			var aux = auxTablaMientras.pop_back()
			if(aux.y!=-1):
				if aborrar.find(int(aux.x))>-1:
					if aborrar.find(int(aux.y))<0:
						auxAborrar.append(aux.y)
				elif aborrar.find(int(aux.y))>-1:
					if aborrar.find(int(aux.x))<0:
						auxAborrar.append(aux.x)
		auxAborrar.sort()
		var lineas = []
		for i in range(get_node("Panel/Instrucciones").get_line_count()):
			lineas.append(get_node("Panel/Instrucciones").get_line(i).replace("\t",""))
		for i in auxAborrar.size():
			lineas[auxAborrar[i]]="&&"
		var linNew =[]
		for i in lineas.size():
			if lineas[i]!="&&":
				linNew.append(lineas[i])
		var LineaString = linNew[0]
		for i in range(1,linNew.size()):
			LineaString=LineaString+"\n"+linNew[i]
		get_node("Panel/Instrucciones").text=""
		get_node("Panel/Instrucciones").text=LineaString
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)
		get_node("Panel/Instrucciones").remove_breakpoints()
		auxAborrar.clear()
		aborrar.clear()
	if get_node("Panel/Instrucciones").get_breakpoints().size()==0:
		estetico()
		compruebaWhiles()
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)

func comandoIf(var arreglo, var IndexOperador, var limite, var comando):
	var instruccion = "Si "+arreglo+" "+operadores[IndexOperador]+" "+str(limite)+" Entonces "+comando
	agregaComando(instruccion)
	presionadoSi=false

func comandoWhile(var registro, var IndexOperador, var limite):
	var instruccion = "Mientras "+registro+" "+operadores[IndexOperador]+" "+str(limite)
	agregaComando(instruccion)
	presionadoMientras = false

func reemplazaComando(var pos, var Str):
	var lineas = []
	for i in range(get_node("Panel/Instrucciones").get_line_count()):
		if(i!=pos):
			lineas.append(get_node("Panel/Instrucciones").get_line(i))
		else:
			var linea=""
			if get_node("Panel/Instrucciones").get_line(i).begins_with("\t"):
				linea=get_node("Panel/Instrucciones").get_line(i).substr(0,get_node("Panel/Instrucciones").get_line(i).find_last("\t")+1)
			linea = linea+Str
			lineas.append(linea)
	get_node("Panel/Instrucciones").text=""
	var nLineas = lineas[0]
	for i in range(1,lineas.size()):
		nLineas = nLineas+"\n"+lineas[i]
	get_node("Panel/Instrucciones").text=nLineas
	get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)

func agregaComando(var Str):
	if(aborrar.size()==1):
		reemplazaComando(aborrar.pop_back(),Str)
		aborrar.clear()
		get_node("Panel/Instrucciones").remove_breakpoints()
		get_node("ComandosBasicos/VBoxContainer/Borrar").disabled=true
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)
	elif aborrar.size()<1:
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)
		get_node("Panel/Instrucciones").insert_text_at_cursor(Str+"\n")
	if get_node("Panel/Instrucciones").get_breakpoints().size()==0:
		estetico()
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)


func _on_Norte_pressed():
	playBoton()
	#pass # Replace with function body.
	dir = "N"
	if senialIf==0:
		if senial == 1:
			agregaComando("Mov(N)")
		elif senial == 2:
			agregaComando("Dis(N)")
		elif senial == 3:
			get_node("Distancia").show()
		elif senial == 4:
			agregaComando("Rad(N)")
		get_node("Direccion").hide()
		get_node("ComandosBasicos").show()
	elif senialIf==11:
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxV,"Mov(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==12:
		var auxD = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxD,"Dis(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==13:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==14:
		var auxR = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxR,"Rad(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==21:
		var auxM = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxM,"Mov(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==22:
		var auxD = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxD,"Dis(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==23:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==24:
		var auxR = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxR,"Rad(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==31:
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxM,"Mov(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==32:
		var auxD = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxD,"Dis(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==33:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==34:
		var auxR = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxR,"Rad(N)")	
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==41:
		var auxM = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxM,"Mov(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==42:
		var auxD = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxD,"Dis(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==43:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==44:
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxR,"Rad(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==51:
		var auxM = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxM,"Mov(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==52:
		var auxD = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxD,"Dis(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==53:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==54:
		var auxR = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxR,"Rad(N)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()

func _on_Sur_pressed():
	playBoton()
	dir="S"
	if senialIf == 0:
		if senial == 1:
			agregaComando("Mov(S)")
		elif senial == 2:
			agregaComando("Dis(S)")
		elif senial == 3:
			get_node("Distancia").show()
		elif senial == 4:
			agregaComando("Rad(S)")
		if senialIf==0:
			get_node("Direccion").hide()
			get_node("ComandosBasicos").show()
	elif senialIf==11:
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxV,"Mov(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==12:
		var auxD = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxD,"Dis(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==13:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==14:
		var auxR = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxR,"Rad(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==21:
		var auxM = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxM,"Mov(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==22:
		var auxD = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxD,"Dis(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==23:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==24:
		var auxR = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxR,"Rad(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==31:
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxM,"Mov(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==32:
		var auxD = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxD,"Dis(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==33:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==34:
		var auxR = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxR,"Rad(S)")	
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==41:
		var auxM = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxM,"Mov(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==42:
		var auxD = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxD,"Dis(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==43:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==44:
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxR,"Rad(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==51:
		var auxM = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxM,"Mov(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==52:
		var auxD = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxD,"Dis(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==53:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==54:
		var auxR = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxR,"Rad(S)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()

func _on_Este_pressed():
	playBoton()
	dir="E"
	if senialIf == 0:
		if senial == 1:
			agregaComando("Mov(E)")
		elif senial == 2:
			agregaComando("Dis(E)")
		elif senial == 3:
			get_node("Distancia").show()
		elif senial == 4:
			agregaComando("Rad(E)")
		if senialIf==0:
			get_node("Direccion").hide()
			get_node("ComandosBasicos").show()
	elif senialIf==11:
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxV,"Mov(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==12:
		var auxD = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxD,"Dis(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==13:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==14:
		var auxR = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxR,"Rad(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==21:
		var auxM = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxM,"Mov(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==22:
		var auxD = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxD,"Dis(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==23:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==24:
		var auxR = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxR,"Rad(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==31:
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxM,"Mov(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==32:
		var auxD = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxD,"Dis(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==33:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==34:
		var auxR = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxR,"Rad(E)")	
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==41:
		var auxM = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxM,"Mov(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==42:
		var auxD = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxD,"Dis(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==43:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==44:
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxR,"Rad(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==51:
		var auxM = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxM,"Mov(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==52:
		var auxD = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxD,"Dis(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==53:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==54:
		var auxR = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxR,"Rad(E)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()

func _on_Oeste_pressed():
	playBoton()
	dir = "O"
	if senialIf == 0:
		if senial == 1:
			agregaComando("Mov(O)")
		elif senial == 2:
			agregaComando("Dis(O)")
		elif senial == 3:
			get_node("Distancia").show()
		elif senial == 4:
			agregaComando("Rad(O)")
		if senialIf==0:
			get_node("Direccion").hide()
			get_node("ComandosBasicos").show()
	elif senialIf==11:
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxV,"Mov(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==12:
		var auxD = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxD,"Dis(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==13:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==14:
		var auxR = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxR,"Rad(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==21:
		var auxM = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxM,"Mov(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==22:
		var auxD = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxD,"Dis(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==23:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==24:
		var auxR = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxR,"Rad(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==31:
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxM,"Mov(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==32:
		var auxD = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxD,"Dis(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==33:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==34:
		var auxR = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxR,"Rad(O)")	
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==41:
		var auxM = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxM,"Mov(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==42:
		var auxD = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxD,"Dis(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==43:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==44:
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxR,"Rad(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==51:
		var auxM = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxM,"Mov(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==52:
		var auxD = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxD,"Dis(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==53:
		get_node("Distancia").show()
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()
	elif senialIf==54:
		var auxR = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxR,"Rad(O)")
		get_node("Direccion").hide()
		get_node("ComandosIf").hide()

func _on_Regresar_pressed():
	playBoton()
	get_node("Direccion").hide()#Bien
	get_node("Registros").hide()#Bien
	get_node("Operadores").hide()#Bien
	get_node("CondicionesIf").hide()#Bien
	get_node("CondicionesIf/Vida").hide()#Bien
	get_node("CondicionesIf/DisparosParabolicos").hide()#Bien
	get_node("CondicionesIf/DisparosLineales").hide()#Bien
	get_node("CondicionesIf/Minas").hide()#Bien
	get_node("CondicionesIf/Radar").hide()#Bien
	get_node("ComandosIf").hide()#Bien
	get_node("Distancia").hide()#Bien
	get_node("ComandosBasicos").show()
	reiniciarVar()

func _on_Guardar_pressed():
	playBoton()
	##Necesitamos hacer un parser o maquina de turing para los while
	var n = compruebaWhiles()
	if(n==0):
		get_tree().paused = true
		var Pos = get_node("../Codigo").rect_position
		var positionX = Pos[0]*-1
		var positionY = Pos[1]*-1
		var neg = Vector2(positionX,positionY)
		get_node("../Codigo").rect_position = neg
		get_node("../Codigo").show()
		get_node("../Codigo/EfectoCodigo").interpolate_property(get_node("../Codigo"),"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
		get_node("../Codigo/EfectoCodigo").start()
	else:
		get_tree().paused = true
		var Pos = get_node("../ErrorMessage").rect_position
		var positionX = Pos[0]*-1
		var positionY = Pos[1]*-1
		var neg = Vector2(positionX,positionY)
		get_node("../ErrorMessage").rect_position = neg
		get_node("../ErrorMessage").show()
		get_node("../ErrorMessage/EfectoError").interpolate_property(get_node("../Codigo"),"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
		get_node("../ErrorMessage/EfectoError").start()

func _on_Vida_pressed():
	playBoton()
	get_node("Registros").hide()
	get_node("Operadores").show()
	if(presionadoSi==true):
		senialIf=1
	elif(presionadoMientras==true):
		senialWhile=1

func _on_AceptarVida_pressed():
	playBoton()
	if(presionadoSi==true):
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Vida").hide()
		get_node("ComandosIf").show()
	elif(presionadoMientras==true):
		var auxV = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoWhile("V",operador-1,auxV)
		contadorMientras+=1
		if(contadorMientras>0):
			get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Vida").hide()

func _on_TirosPara_pressed():
	playBoton()
	get_node("Registros").hide()
	get_node("Operadores").show()
	if(presionadoSi==true):
		senialIf=2
	elif(presionadoMientras==true):
		senialWhile=2

func _on_TirosLin_pressed():
	playBoton()
	get_node("Registros").hide()
	get_node("Operadores").show()
	if(presionadoSi==true):
		senialIf=5
	elif(presionadoMientras==true):
		senialWhile=5

func _on_TirosParaAceptar_pressed():
	playBoton()
	if(presionadoSi==true):
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/DisparosParabolicos").hide()
		get_node("ComandosIf").show()
	elif(presionadoMientras==true):
		var auxP = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoWhile("P",operador-1,auxP)
		contadorMientras+=1
		if(contadorMientras>0):
			get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/DisparosParabolicos").hide()

func _on_TirosLinealesAceptar_pressed():
	playBoton()
	if(presionadoSi==true):
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/DisparosLineales").hide()
		get_node("ComandosIf").show()
	elif(presionadoMientras==true):
		var auxL = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoWhile("L",operador-1,auxL)
		contadorMientras+=1
		if(contadorMientras>0):
			get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/DisparosLineales").hide()

func _on_Minas_pressed():
	playBoton()
	get_node("Registros").hide()
	get_node("Operadores").show()
	if(presionadoSi==true):
		senialIf=3
	elif(presionadoMientras==true):
		senialWhile=3

func _on_MinasAceptar_pressed():
	playBoton()
	if(presionadoSi==true):
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Minas").hide()
		get_node("ComandosIf").show()
	elif(presionadoMientras==true):
		var auxM = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoWhile("M",operador-1,auxM)
		contadorMientras+=1
		if(contadorMientras>0):
			get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Minas").hide()

func _on_Radar_pressed():
	playBoton()
	get_node("Registros").hide()
	get_node("Operadores").show()
	if(presionadoSi==true):
		senialIf=4
	elif(presionadoMientras==true):
		senialWhile=4

func _on_RadarAceptar_pressed():
	playBoton()
	if(presionadoSi==true):
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Radar").hide()
		get_node("ComandosIf").show()
	elif(presionadoMientras==true):
		var auxR = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoWhile("R",operador-1,auxR)
		contadorMientras+=1
		if(contadorMientras>0):
			get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
		get_node("CondicionesIf").hide()
		get_node("CondicionesIf/Radar").hide()

func _on_Mayor_pressed():
	playBoton()
	operador = 1
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_Mayor_Igual_pressed():
	playBoton()
	operador = 2
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_Igual_pressed():
	playBoton()
	operador = 3
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_Menor_Igual_pressed():
	playBoton()
	operador = 4
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_Menor_pressed():
	playBoton()
	operador = 5
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_Diferente_pressed():
	playBoton()
	operador = 6
	if senialIf == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialIf == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialIf == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialIf == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialIf == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	if senialWhile == 1:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Vida").show()
	elif senialWhile == 2:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosParabolicos").show()
	elif senialWhile == 3:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Minas").show()
	elif senialWhile == 4:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/Radar").show()
	elif senialWhile == 5:
		get_node("CondicionesIf").show()
		get_node("CondicionesIf/DisparosLineales").show()
	get_node("Operadores").hide()

func _on_regresa_pressed():
	if get_node("Panel/Instrucciones").get_line_count()>1:
		get_tree().paused = true
		var Pos = get_node("../ErrorMessage2").rect_position
		var positionX = Pos[0]*-1
		var positionY = Pos[1]*-1
		var neg = Vector2(positionX,positionY)
		get_node("../ErrorMessage2").rect_position = neg
		get_node("../ErrorMessage2").show()
		get_node("../ErrorMessage2/EfectoError").interpolate_property(get_node("../Codigo"),"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
		get_node("../ErrorMessage2/EfectoError").start()
	else:
		playBoton()
		Transicion.cambio2("res://Escenas/Main.tscn")

func _on_AceptarDistancia_pressed():
	playBoton()
	var distancia = str(get_node("Distancia/VBoxContainer/HBoxContainer/ContadorDistancia").value)
	if senialIf==0:
		if senial == 3:
			agregaComando("Par("+dir+","+distancia+")")
	elif senialIf==13:
		var auxP = get_node("CondicionesIf/Vida/HBoxContainer/ContadorVida").value
		comandoIf("V",operador-1,auxP,"Par("+dir+","+distancia+")")
	elif senialIf==23:
		var auxP = get_node("CondicionesIf/DisparosParabolicos/HBoxContainer/ContadorDisparosParabolicos").value
		comandoIf("P",operador-1,auxP,"Par("+dir+","+distancia+")")
	elif senialIf==33:
		var auxP = get_node("CondicionesIf/Minas/HBoxContainer/ContadorMinas").value
		comandoIf("M",operador-1,auxP,"Par("+dir+","+distancia+")")
	elif senialIf==43:
		var auxP = get_node("CondicionesIf/Radar/HBoxContainer/ContadorRadar").value
		comandoIf("R",operador-1,auxP,"Par("+dir+","+distancia+")")
	elif senialIf==53:
		var auxP = get_node("CondicionesIf/DisparosLineales/HBoxContainer/ContadorDisparosLineales").value
		comandoIf("L",operador-1,auxP,"Par("+dir+","+distancia+")")
	get_node("Distancia").hide()

func compruebaWhiles():
	var cMientras=0
	for i in range(get_node("Panel/Instrucciones").get_line_count()):
		var linea = get_node("Panel/Instrucciones").get_line(i).replace("\t","")
		if linea.begins_with("Mientras"):
			cMientras+=1
		elif linea.begins_with("Fin Mientras"):
			cMientras-=1
	if cMientras>0:
		get_node("ComandosBasicos/VBoxContainer/Fin Mientras").show()
	else:
		get_node("ComandosBasicos/VBoxContainer/Fin Mientras").hide()
	return cMientras

func estetico():
	var espacios = 0;
	var lineas = []
	for i in range(get_node("Panel/Instrucciones").get_line_count()):
		var Str = get_node("Panel/Instrucciones").get_line(i).replace("\t","")
		if(Str.begins_with("Mientras")):
			for j in espacios:
				Str= "\t"+Str
			espacios+=1
		elif(Str == "Fin Mientras"):
			for j in (espacios-1):
				Str="\t"+Str
			espacios-=1
		else:
			for j in espacios:
				Str="\t"+Str
		lineas.append(Str)
	var stringLineas = lineas[0]
	for i in range(1,lineas.size()):
		stringLineas = stringLineas+"\n"+lineas[i]
	get_node("Panel/Instrucciones").text=""
	get_node("Panel/Instrucciones").text=stringLineas

func _on_Instrucciones_draw():
	reiniciarVar()
	compruebaWhiles()

func _on_Instrucciones_breakpoint_toggled(row):
	if(aborrar.find(row)<0):
		get_node("Panel/Instrucciones").cursor_set_line(row,false)
		aborrar.append(row)
	else:
		var ind = aborrar.find(row)
		aborrar.remove(ind)
		get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)
	if aborrar.size()>0:
		get_node("ComandosBasicos/VBoxContainer/Borrar").disabled=false
	else:
		get_node("ComandosBasicos/VBoxContainer/Borrar").disabled=true

func _on_Cancelar_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = get_node("../Codigo").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../Codigo/EfectoCodigo").interpolate_property(get_node("../Codigo"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../Codigo/EfectoCodigo").start()
	get_node("../Codigo").hide()

func _on_Aceptar_pressed():
	playBoton()
	var file = File.new()
	var player = str("user://Codigos/",get_node("../Codigo/Panel/Panel/nombreArchivo").text,".txt")
	file.open(player,File.WRITE)
	file.store_string(get_node("Panel/Instrucciones").text)
	file.close()
	get_tree().paused = false
	var Pos = get_node("../Codigo").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../Codigo/EfectoCodigo").interpolate_property(get_node("../Codigo"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../Codigo/EfectoCodigo").start()
	get_node("../Codigo").hide()
	get_tree().change_scene("res://Escenas/Main.tscn")

func playBoton():
	get_node("../cloc").play()

func _on_Fin_Mientras_pressed():
	playBoton()
	agregaComando("Fin Mientras")
	contadorMientras-=1
	if(contadorMientras==0):
		get_node("ComandosBasicos/VBoxContainer/Fin Mientras").hide()

func _on_ErrorButton_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = get_node("../ErrorMessage").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../ErrorMessage/EfectoError").interpolate_property(get_node("../Codigo"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../ErrorMessage/EfectoError").start()
	get_node("../ErrorMessage").hide()


func _on_Abrir_pressed():
	get_node("../Abrir").show()
	get_node("../Abrir").popup()

func _input(event):
	if Input.is_action_just_pressed('enter'):
		if aborrar.size()==1:
			get_node("Panel/Instrucciones").cursor_set_line(aborrar.pop_back()+1,false)
			get_node("Panel/Instrucciones").insert_text_at_cursor("\n")
			get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)
			get_node("Panel/Instrucciones").remove_breakpoints()

func _on_Abrir_file_selected(path):
	var arch = File.new()
	arch.open(path,arch.READ)
	var texto =  arch.get_as_text()
	arch.close()
	get_node("Panel/Instrucciones").text=texto
	get_node("Panel/Instrucciones").cursor_set_line(get_node("Panel/Instrucciones").get_line_count(),false)



func _on_AceptarProgreso_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = get_node("../ErrorMessage2").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../ErrorMessage2/EfectoError").interpolate_property(get_node("../Codigo"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../ErrorMessage/EfectoError").start()
	get_node("../ErrorMessage2").hide()
	Transicion.cambio2("res://Escenas/Main.tscn")
		

func _on_CancelarProgreso_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = get_node("../ErrorMessage2").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../ErrorMessage2/EfectoError").interpolate_property(get_node("../Codigo"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../ErrorMessage2/EfectoError").start()
	get_node("../ErrorMessage2").hide()
