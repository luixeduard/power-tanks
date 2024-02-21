extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	playBoton()
	get_tree().paused = true
	var Pos = get_node("../Control").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../Control").rect_position = neg
	get_node("../Control").show()
	get_node("../Control/EfectoPausa").interpolate_property(get_node("../Control"),"rect_position",neg,Pos,2,Tween.TRANS_LINEAR)
	get_node("../Control/EfectoPausa").start()


func _on_Reanudar_pressed():
	playBoton()
	get_tree().paused = false
	var Pos = get_node("../Control").rect_position
	var positionX = Pos[0]*-1
	var positionY = Pos[1]*-1
	var neg = Vector2(positionX,positionY)
	get_node("../Control/EfectoPausa").interpolate_property(get_node("../Control"),"rect_position",Pos,neg,2,Tween.TRANS_LINEAR)
	get_node("../Control/EfectoPausa").start()
	get_node("../Control").hide()
	
func playBoton():
	$clik.volume_db = 1
	get_node("clik").play()



func _on_Conf_pressed():
	get_node("../Control/Background").show()
	get_node("../Configuracion").show()
