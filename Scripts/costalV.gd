extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var scala = VarG.tamCel/Vector2(72,72)
	get_node("Costal").set("scale",scala)
	var zona = RectangleShape2D.new()
	var tam = Vector2(36,72)/VarG.tamCel
	zona.extents=tam
	get_node("CollisionShape2D").shape=zona
