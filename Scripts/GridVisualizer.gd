extends Node2D

onready var grid = get_parent()

func _ready():
	modulate = Color( 0, 0, 0, 0.2 )


func _draw():
	var LINE_COLOR = Color(0, 0, 0)
	var LINE_WIDTH = 4
#	var window_size = OS.get_window_size()
	var QSize = get_node("..").cell_quadrant_size
	var CellSizeX = get_node("..").cell_size.x
	var CellSizeY = get_node("..").cell_size.y
	for x in range(1,QSize):
		var col_pos = x * CellSizeX
		var limit = CellSizeY * QSize-CellSizeY
		draw_line(Vector2(col_pos, CellSizeY), Vector2(col_pos, limit), LINE_COLOR, LINE_WIDTH)
	for y in range(1,QSize):
		var row_pos = y * CellSizeY
		var limit = CellSizeX * QSize-CellSizeX
		draw_line(Vector2(CellSizeX, row_pos), Vector2(limit, row_pos), LINE_COLOR, LINE_WIDTH)
