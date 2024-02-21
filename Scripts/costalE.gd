extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func rota(ang):
	get_node("Costal").rotation_degrees=ang

func escala(escala):
	var scala = VarG.tamCel/escala
	get_node("Costal").set("scale",scala)

func _ready():
	var zona = RectangleShape2D.new()
	var tam = Vector2(72,36)/VarG.tamCel
	zona.extents=tam
	get_node("CollisionShape2D").shape=zona


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
