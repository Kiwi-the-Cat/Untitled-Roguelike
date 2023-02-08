extends Node2D

var width = 72 # width of the play field
var height = 40 # height of the play field

var start_x = randi_range(0, width)
var start_y = randi_range(3, height)
var coords = []

var wave_active = true

var cell_bottom_neighbor
var cell_top_neighbor
var cell_left_neighbor
var cell_right_neighbor

var floor_center = Vector2i(5, 1)
var floor_top = Vector2i(5, 0)
var floor_top_left = Vector2i(4, 0)
var floor_top_right = Vector2i(6, 0)
var floor_left = Vector2i(4, 1)
var floor_right = Vector2i(6, 1)
var floor_bottom = Vector2i(5, 2)
var floor_bottom_left = Vector2i(4, 2)
var floor_bottom_right = Vector2i(6, 2)
var top_wall = [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)] 

var increment = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# play field max size 240x240
	# wavefunction collapse algorithm
	if (start_y == 3): # if the 1st point's y is equal to the point at which the floor becomes the wall
		floor_top_generation(start_x, start_y)

	elif (start_y < height): # checks if the starting point is in the middle on the sides
		floor_edge_generation(start_x, start_y)

	wall_fill() # generates the wall
	
	neighbors(start_x, start_y)
	
	while (wave_active == true):
		if (cell_top_neighbor.y > 2):
			coords.append(cell_top_neighbor)
			
		if (cell_bottom_neighbor.y <= height):
			coords.append(cell_bottom_neighbor)
			
		if (cell_left_neighbor.x > -1):
			coords.append(cell_left_neighbor)
			
		if (cell_right_neighbor.x <= width):
			coords.append(cell_right_neighbor)
			
		neighbors(coords[increment][0], coords[increment][1])
		
		increment += 1
		
		if (increment == (width) * (height - 3) - 1):
			break
			
	for x in coords:
		pass

func floor_top_generation(x, y):
		if (x == 0): # checks to see if the starting point is in the top left coner of the floor
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_top_left)

		elif (x == width): # checks to see if the starting point is in the top right corner of the floor
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_top_right)

		elif (x != 0) and (x != width): # if the starting point is neither the left nor right corner
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_top)

func floor_edge_generation(x, y):
		if (x == 0): # checks to see if the starting point is on the left side
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_left)

		elif (x == width): # checks to see if the starting point is on the right side
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_right)

		else:
			$TileMap.set_cell(0, Vector2i(x, y), 0, floor_center)

func wall_generation(x): # generates a wall, what can I say
	$TileMap.set_cell(0, Vector2i(x, 0), 0, top_wall[0])
	$TileMap.set_cell(0, Vector2i(x, 1), 0, top_wall[1])
	$TileMap.set_cell(0, Vector2i(x, 2), 0, top_wall[2])



func wall_fill(): # fills in the top row of walls
	var x = width
	while (x > -1):
		wall_generation(x)
		x -= 1

func neighbors(x, y):
	# get_neighbor_cell returns a Vector2i in (x, y) format
	cell_bottom_neighbor = $TileMap.get_neighbor_cell(Vector2i(x, y), TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
	cell_top_neighbor = $TileMap.get_neighbor_cell(Vector2i(x, y), TileSet.CELL_NEIGHBOR_TOP_SIDE)
	cell_left_neighbor = $TileMap.get_neighbor_cell(Vector2i(x, y), TileSet.CELL_NEIGHBOR_LEFT_SIDE)
	cell_right_neighbor = $TileMap.get_neighbor_cell(Vector2i(x, y), TileSet.CELL_NEIGHBOR_RIGHT_SIDE)

