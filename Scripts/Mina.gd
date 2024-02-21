extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grid
var type
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	var scala = Vector2(VarG.tamCel[0]/880,VarG.tamCel[1]/680)
#	var rad = 150*(880*VarG.tamCel.x)
#	rad = rad/880
	get_node("ammo").set("scale",scala)
#	var shape = CircleShape2D.new()
#	shape.radius=rad
#	get_node("CollisionShape2D").shape=shape
#
#func colisionActivate():
#	get_node("CollisionShape2D").disabled=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
