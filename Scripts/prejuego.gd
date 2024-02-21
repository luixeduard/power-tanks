extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MapAct = 1
var NoEquipos = 0
var datos = ' '
var varG
var Maps = ["res://graphics/botones/6x6i.png","res://graphics/botones/8x8i.png","res://graphics/botones/10x10i.png"]
var tanks = ["res://graphics/selectable/tank1.png","res://graphics/selectable/tank2.png","res://graphics/selectable/tank3.png","res://graphics/selectable/tank4.png","res://graphics/selectable/tank5.png","res://graphics/selectable/tank6.png","res://graphics/selectable/tank7.png","res://graphics/selectable/tank8.png","res://graphics/selectable/tank9.png"]
var selEq1=0
var selEq2=0
var selEq3=0
var selEq4=0
var item_name
var danoMin = 6
var danoDispP = 4
var danoDispL = 2
var MunMin = 0
var MunDispP = 0
var MunDispL = 0

var contEq1 = 0
var contEq2 = 0
var contEq3 = 0
var contEq4 = 0

var ammo = ["res://graphics/ammo/Seleccion0.png","res://graphics/ammo/Seleccion1.png","res://graphics/ammo/Seleccion2.png","res://graphics/ammo/Seleccion3.png","res://graphics/ammo/Seleccion4.png","res://graphics/ammo/Seleccion5.png","res://graphics/ammo/Seleccion6.png","res://graphics/ammo/Seleccion7.png","res://graphics/ammo/Seleccion8.png","res://graphics/ammo/Seleccion9.png","res://graphics/ammo/Seleccion10.png","res://graphics/ammo/Seleccion11.png","res://graphics/ammo/Seleccion12.png","res://graphics/ammo/Seleccion13.png","res://graphics/ammo/Seleccion14.png","res://graphics/ammo/Seleccion15.png","res://graphics/ammo/Seleccion16.png","res://graphics/ammo/Seleccion17.png","res://graphics/ammo/Seleccion18.png","res://graphics/ammo/Seleccion19.png","res://graphics/ammo/Seleccion20.png","res://graphics/ammo/Seleccioninfinita.png"]
var fire = ["res://graphics/fire/5.png","res://graphics/fire/10.png","res://graphics/fire/15.png","res://graphics/fire/20.png","res://graphics/fire/25.png","res://graphics/fire/30.png","res://graphics/fire/35.png","res://graphics/fire/40.png","res://graphics/fire/45.png","res://graphics/fire/50.png","res://graphics/fire/55.png","res://graphics/fire/60.png","res://graphics/fire/65.png","res://graphics/fire/70.png","res://graphics/fire/75.png","res://graphics/fire/80.png","res://graphics/fire/85.png","res://graphics/fire/90.png","res://graphics/fire/95.png","res://graphics/fire/100.png"]

# Called when the node enters the scene tree for the first time.

func setArrows():
	var tam = get_node("All/NumeroDeEquipos/NEquipos").rect_size.y
	var img = load("res://graphics/botones/arrow.png")
	img.resize(tam,tam)
	var imgText = ImageTexture.new()
	imgText.create_from_image(img)
	get_node("All/NumeroDeEquipos/NEquipos").set("custom_icons/arrow",imgText)
	var tam2 = get_node("All/Equipo 4/VBoxContainer/ScriptEquipo4").rect_size.y
	var img2 = load("res://graphics/botones/arrow.png")
	img2.resize(tam2,tam2)
	var imgText2 = ImageTexture.new()
	imgText2.create_from_image(img2)
	get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").set("custom_icons/arrow",imgText2)
	get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").set("custom_icons/arrow",imgText2)
	get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").set("custom_icons/arrow",imgText2)
	get_node("All/Equipo 4/VBoxContainer/ScriptEquipo4").set("custom_icons/arrow",imgText2)
	

func _ready():
	setArrows()
	var scripts = VarG.list_files_in_directory("user://Codigos/")
	for i in scripts:
		get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_popup().add_item(i)
		get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_popup().add_item(i)
		get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").get_popup().add_item(i)
		get_node("All/Equipo 4/VBoxContainer/ScriptEquipo4").get_popup().add_item(i)

	if(get_node("All/NumeroDeEquipos/NEquipos")!=null):
		get_node("All/NumeroDeEquipos/NEquipos").get_popup().add_item('2')
		get_node("All/NumeroDeEquipos/NEquipos").get_popup().add_item('3')
		get_node("All/NumeroDeEquipos/NEquipos").get_popup().add_item('4')
	get_node("All/Panel2/Aceptar").disabled = true
	get_node("Hurt/Panel/Panel/PanelM/DanoMin").texture_normal=load(fire[danoMin])
	get_node("Hurt/Panel/Panel/PanelM/DanoMin/num").text=str(((danoMin+1)*5),"%")
	get_node("Hurt/Panel/Panel/PanelDP/DañoDispP").texture_normal=load(fire[danoDispP])
	get_node("Hurt/Panel/Panel/PanelDP/DañoDispP/num").text=str(((danoDispP+1)*5),"%")
	get_node("Hurt/Panel/Panel/PanelDL/DañoDispL").texture_normal=load(fire[danoDispL])
	get_node("Hurt/Panel/Panel/PanelDL/DañoDispL/num").text=str(((danoDispL+1)*5),"%")
	if(MapAct==0):
		MunMin=2
		MunDispL=21
		MunDispP=3
	elif(MapAct==1):
		MunMin=4
		MunDispL=21
		MunDispP=6
	elif(MapAct==2):
		MunMin=6
		MunDispL=21
		MunDispP=9
	get_node("Loot/Panel/Panel/PanelM/MunMin").texture_normal=load(ammo[MunMin])
	get_node("Loot/Panel/Panel/PanelDP/MunDispP").texture_normal=load(ammo[MunDispP])
	get_node("Loot/Panel/Panel/PanelDL/MunDispL").texture_normal=load(ammo[MunDispL])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_item_pressed(id):
	playBoton()
	item_name = get_node("All/NumeroDeEquipos/NEquipos").get_popup().get_item_text(id)
	#print(item_name)
	if(item_name == '2'):
		get_node("All/Equipo 1").show()
		get_node("All/Equipo 2").show()
		get_node("All/Equipo 3").hide()
		get_node("All/Equipo 4").hide()
		NoEquipos=2
		puedoSeguir()
	elif(item_name == '3'):
		get_node("All/Equipo 1").show()
		get_node("All/Equipo 2").show()
		get_node("All/Equipo 3").show()
		get_node("All/Equipo 4").hide()
		NoEquipos=3
		puedoSeguir()
	elif(item_name == '4'):
		get_node("All/Equipo 1").show()
		get_node("All/Equipo 2").show()
		get_node("All/Equipo 3").show()
		get_node("All/Equipo 4").show()
		NoEquipos=4
		puedoSeguir()


func _on_Menor_pressed():
	playBoton()
	MapAct = MapAct-1
	get_node("All/Panel/Control3/Mayor").show()
	if(MapAct==0):
		get_node("All/Panel/Control/Menor").hide()
	get_node("All/Panel/Control2/Mapa").texture=load(Maps[MapAct])


func _on_Mayor_pressed():
	playBoton()
	MapAct = MapAct+1
	get_node("All/Panel/Control/Menor").show()
	if(MapAct==2):
		get_node("All/Panel/Control3/Mayor").hide()
	get_node("All/Panel/Control2/Mapa").texture=load(Maps[MapAct])


func _on_regresa_pressed():
	playBoton()
	Transicion.cambio2("res://Escenas/Main.tscn")



func _on_TanqueEquipo1_pressed():
	playBoton()
	if(selEq1<8):
		selEq1+=1
	else:
		selEq1=0
	get_node("All/Equipo 1/Panel/TanqueEquipo1").texture_normal=load(tanks[selEq1])


func _on_TanqueEquipo2_pressed():
	playBoton()
	if(selEq2<8):
		selEq2+=1
	else:
		selEq2=0
	get_node("All/Equipo 2/Panel/TanqueEquipo2").texture_normal=load(tanks[selEq2])



func _on_TanqueEquipo3_pressed():
	playBoton()
	if(selEq3<8):
		selEq3+=1
	else:
		selEq3=0
	get_node("All/Equipo 3/Panel/TanqueEquipo3").texture_normal=load(tanks[selEq3])

func _on_TanqueEquipo4_pressed():
	playBoton()
	if(selEq4<8):
		selEq4+=1
	else:
		selEq4=0
	get_node("All/Equipo 4/Panel/TanqueEquipo4").texture_normal=load(tanks[selEq4])

func _on_Dao_Disp_pressed():
	playBoton()
	get_tree().paused = true
	var Pos = $Hurt.rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	$Hurt.rect_position = neg
	$Hurt.show()
	get_node("Hurt/EfectoHurt").interpolate_property($Hurt,"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
	get_node("Hurt/EfectoHurt").start()

func _on_DaoMin_pressed():
	playBoton()
	if danoMin==19:
		danoMin=0
	else:
		danoMin+=1
	get_node("Hurt/Panel/Panel/PanelM/DanoMin/num").text=str(((danoMin+1)*5),"%")
	get_node("Hurt/Panel/Panel/PanelM/DanoMin").texture_normal=load(fire[danoMin])

func _on_DaoDispP_pressed():
	playBoton()
	if danoDispP==19:
		danoDispP=0
	else:
		danoDispP+=1
	get_node("Hurt/Panel/Panel/PanelDP/DañoDispP/num").text=str(((danoDispP+1)*5),"%")
	get_node("Hurt/Panel/Panel/PanelDP/DañoDispP").texture_normal=load(fire[danoDispP])

func _on_DaoDispL_pressed():
	playBoton()
	if danoDispL==19:
		danoDispL=0
	else:
		danoDispL+=1
	get_node("Hurt/Panel/Panel/PanelDL/DañoDispL/num").text=str(((danoDispL+1)*5),"%")
	get_node("Hurt/Panel/Panel/PanelDL/DañoDispL").texture_normal=load(fire[danoDispL])



func _on_AceptarHurt_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = $Hurt.rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("Hurt/EfectoHurt").interpolate_property($Hurt,"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("Hurt/EfectoHurt").start()
	$Hurt.hide()


func _on_Num_Disp_pressed():
	playBoton()
	get_tree().paused = true
	var Pos = $Loot.rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	$Loot.rect_position = neg
	$Loot.show()
	get_node("Loot/EfectoLoot").interpolate_property($Loot,"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
	get_node("Loot/EfectoLoot").start()

func _on_MunMin_pressed():
	playBoton()
	if MunMin==21:
		MunMin=0
	else:
		MunMin+=1
	get_node("Loot/Panel/Panel/PanelM/MunMin").texture_normal=load(ammo[MunMin])


func _on_MunDispP_pressed():
	playBoton()
	if MunDispP==21:
		MunDispP=0
	else:
		MunDispP+=1
	get_node("Loot/Panel/Panel/PanelDP/MunDispP").texture_normal=load(ammo[MunDispP])


func _on_MunDispL_pressed():
	playBoton()
	if MunDispL==21:
		MunDispL=0
	else:
		MunDispL+=1
	get_node("Loot/Panel/Panel/PanelDL/MunDispL").texture_normal=load(ammo[MunDispL])



func _on_AceptarLoot_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = $Loot.rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("Loot/EfectoLoot").interpolate_property($Loot,"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("Loot/EfectoLoot").start()
	$Loot.hide()

func puedoSeguir():
	var existen = contEq1+contEq2+contEq3+contEq4
	if (NoEquipos == existen && NoEquipos!=0):
		get_node("All/Panel2/Aceptar").disabled = false
	else:
		get_node("All/Panel2/Aceptar").disabled = true
		

func _on_Aceptar_pressed():
	playBoton()
	MainTheme.stop()
	#add_to_group("NewGame",true)
	VarG.SetTamMap(MapAct)
	VarG.SetNoEquipos(NoEquipos)
	VarG.setAmmoDisL(MunDispL)
	VarG.setAmmoDisP(MunDispP)
	VarG.setAmmoMin(MunMin)
	VarG.setHurtDisL(danoDispL)
	VarG.setHurtDisP(danoDispP)
	VarG.setHurtMin(danoMin)
	if(NoEquipos>=2):
		if item_name == '2':
			VarG.setSelEq1(selEq1)
			VarG.setSelEq2(selEq2)
			VarG.setScriptEq1(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_item_text(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_selected_id()))
			VarG.setScriptEq2(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_item_text(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_selected_id()))
		if item_name == '3':
			VarG.setSelEq1(selEq1)
			VarG.setSelEq2(selEq2)
			VarG.setSelEq3(selEq3)
			VarG.setScriptEq1(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_item_text(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_selected_id()))
			VarG.setScriptEq2(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_item_text(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_selected_id()))
			VarG.setScriptEq3(get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").get_item_text(get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").get_selected_id()))
		elif item_name == '4':
			VarG.setSelEq1(selEq1)
			VarG.setSelEq2(selEq2)
			VarG.setSelEq3(selEq3)
			VarG.setSelEq4(selEq4)
			VarG.setScriptEq1(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_item_text(get_node("All/Equipo 1/VBoxContainer/ScriptEquipo1").get_selected_id()))
			VarG.setScriptEq2(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_item_text(get_node("All/Equipo 2/VBoxContainer/ScriptEquipo2").get_selected_id()))
			VarG.setScriptEq3(get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").get_item_text(get_node("All/Equipo 3/VBoxContainer/ScriptEquipo3").get_selected_id()))
			VarG.setScriptEq4(get_node("All/Equipo 4/VBoxContainer/ScriptEquipo4").get_item_text(get_node("All/Equipo 4/VBoxContainer/ScriptEquipo4").get_selected_id()))
		MainTheme.pausa()
		GameTheme.inicia()
		get_tree().change_scene("res://Escenas/Juego.tscn")
	


func _on_ScriptEquipo1_item_selected(id):
	contEq1 = 1
	puedoSeguir()
	playBoton()


func _on_ScriptEquipo2_item_selected(id):
	contEq2 = 1
	puedoSeguir()
	playBoton()


func _on_ScriptEquipo3_item_selected(id):
	contEq3 = 1
	puedoSeguir()
	playBoton()


func _on_ScriptEquipo4_item_selected(id):
	contEq4 = 1
	puedoSeguir()
	playBoton()

func playBoton():
	get_node("cluc").play()

