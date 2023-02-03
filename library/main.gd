extends Node2D

var width = 36
var height = 21
# Called when the node enters the scene tree for the first time.
func _ready():
	# play field max size 240x240
	# current size for testing 20x20
	for x in width:
		for y in height:
			$TileMap.set_cell(0, Vector2i(x, y), 0, Vector2i(5, 1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
