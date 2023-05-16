extends Node2D

#The play field will be 16 x 16 for now
@export var x:int = 16 #The width of the field
@export var y:int = 16 #The height of the field
var coords:Vector2i = Vector2i(x, y)

#Things I need to put in the tile data func:
	#The atlas location of all the tiles
	#what tiles can go next to eachother
	
var tiles:Dictionary = {
	"tiles": [
		{"index":  0, "name": "00000", "atlas": Vector2i(4, 0), "rules": {"top": [6, 7, 8, 10, 13], "bottom": [3, 6], "left": [2, 5, 8, 12, 13], "right": [1, 2]}}, #Dirt to Grass top left corner
		{"index":  1, "name": "10000", "atlas": Vector2i(5, 0), "rules": {"top": [6, 7, 8, 10, 13], "bottom": [4, 7, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 25, 26], "left": [0, 1], "right": [1, 2]}}, #Dirt to Grass top
		{"index":  2, "name": "01000", "atlas": Vector2i(6, 0), "rules": {"top": [6, 7, 8, 10, 13], "bottom": [5, 8], "left": [0, 1], "right": [0, 3, 6, 13, 14]}}, #Dirt to Grass top right corner
		{"index":  3, "name": "11000", "atlas": Vector2i(4, 1), "rules": {"top": [0, 3], "bottom": [3, 8], "left": [2, 5, 8, 12, 13], "right": [4, 5, 9, 12, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Dirt to Grass left
		{"index":  4, "name": "00100", "atlas": Vector2i(5, 1), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Grass
		{"index":  5, "name": "10100", "atlas": Vector2i(6, 1), "rules": {"top": [2, 5], "bottom": [5, 8], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [2, 3, 8, 12, 13]}}, #Dirt to Grass right
		{"index":  6, "name": "01100", "atlas": Vector2i(4, 2), "rules": {"top": [0, 3], "bottom": [0, 1, 2, 13, 16], "left": [2, 5, 8, 12, 13], "right": [7, 8]}}, #Dirt to Grass bottom left corner
		{"index":  7, "name": "11100", "atlas": Vector2i(5, 2), "rules": {"top": [1, 4, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [0, 1, 2, 13, 16], "left": [6, 7], "right": [7, 8]}}, #Dirt to Grass bottom
		{"index":  8, "name": "00010", "atlas": Vector2i(6, 2), "rules": {"top": [2, 5], "bottom": [0, 1, 2, 13, 16], "left": [6, 7], "right": [0, 3, 6, 13, 14]}}, #Dirt to Grass bottom right corner

		{"index":  9, "name": "10010", "atlas": Vector2i(4, 3), "rules": {"top": [1, 4, 7, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [12, 15], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [10, 11]}}, #Grass to Dirt top left corner
		{"index": 10, "name": "01010", "atlas": Vector2i(5, 3), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [0, 1, 2, 13, 16], "left": [9, 10], "right": [10, 11]}}, #Grass to Dirt top
		{"index": 11, "name": "11010", "atlas": Vector2i(6, 3), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [14, 17], "left": [9, 10], "right": [4, 5, 9, 12, 15]}}, #Grass to Dirt top right corner
		{"index": 12, "name": "00110", "atlas": Vector2i(4, 4), "rules": {"top": [9, 12], "bottom": [12, 15], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [2, 3, 8, 12, 13]}}, #Grass to Dirt left
		{"index": 13, "name": "10110", "atlas": Vector2i(5, 4), "rules": {"top": [10, 13], "bottom": [13, 16], "left": [12, 13], "right": [13, 14]}}, #Dirt
		{"index": 14, "name": "01110", "atlas": Vector2i(6, 4), "rules": {"top": [11, 14], "bottom": [14, 17], "left": [2, 5, 8, 12, 13], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Grass to Dirt right
		{"index": 15, "name": "11110", "atlas": Vector2i(4, 5), "rules": {"top": [9, 12], "bottom": [4, 7, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [16, 17]}}, #Grass to Dirt bottom left corner
		{"index": 16, "name": "00001", "atlas": Vector2i(5, 5), "rules": {"top": [6, 7, 8, 10, 13], "bottom": [4, 7, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [15, 16], "right": [16, 17]}}, #Grass to Dirt bottom
		{"index": 17, "name": "10001", "atlas": Vector2i(6, 5), "rules": {"top": [11, 14], "bottom": [4, 7, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [15, 16], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Grass to Dirt bottom right corner

		{"index": 18, "name": "01001", "atlas": Vector2i(2, 0), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Small rock with mixed flowers
		{"index": 19, "name": "11001", "atlas": Vector2i(2, 1), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Big rock with mixed flowers
		{"index": 20, "name": "00101", "atlas": Vector2i(2, 2), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Tree stump
		{"index": 21, "name": "10101", "atlas": Vector2i(3, 0), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #White flowers
		{"index": 22, "name": "01101", "atlas": Vector2i(3, 1), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Mixed flowers
		{"index": 23, "name": "11101", "atlas": Vector2i(3, 2), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Pebbles
		{"index": 24, "name": "00011", "atlas": Vector2i(3, 3), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Small rock
		{"index": 25, "name": "10011", "atlas": Vector2i(3, 4), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Big rock
		{"index": 26, "name": "01011", "atlas": Vector2i(3, 5), "rules": {"top": [1, 4, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "bottom": [4, 6, 7, 8, 9, 10, 11, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "left": [3, 4, 11, 14, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26], "right": [4, 5, 9, 12, 15, 18, 19, 20, 21, 22, 23, 24, 24, 25, 26]}}, #Stick
	]
}

var map:Array = [] #Holds all the possible tiles for each cell
var minep:Array = [] #An array of all the tiles and therefore minimum entropy
var rng:RandomNumberGenerator = RandomNumberGenerator.new()


func _ready():
	randomize()
	$TileMap.clear()
	var tileIndex:Array #An array that contains the index of all the tiles in the spritesheet
	for i in range(tiles["tiles"].size()): #Makes minep contain a list of all the tile indexes
		minep.append(i)
	for _y in y: #Creating the map
		var xAxis:Array = []
		for _x in x:
			var _t := minep
			xAxis.append(_t)
		map.append(xAxis)
	
	var start_x:int = randi_range(0, x)
	var start_y:int = randi_range(0, y)
	$TileMap.set_cell(0, Vector2i(start_x, start_y), 1, pick_tile(start_x, start_y))

func pick_tile(_x:int, _y:int): #Picks a random tile for those available for a specific cell
	var rand_tile:int = randi_range(0, map[_y][_x].size())
	var _tiles:Array = tiles["tiles"]
	map[_x][_y] = _tiles[rand_tile]["index"]
	return _tiles[rand_tile]["atlas"]

func collapse(): #Collapses possiblities
	for _y in range(0, y):
		for _x in range(0, x):
			if map[_y][_x].size() != 1:
				entropy(_y, _x)

func entropy(_y, _x): #Not quite sure how to describe this yet
	if map[_y - 1][_x] >= 0:
		for i in map[_y][_x]:
			var _rules:Array = []
			for j in map[_y - 1][_x]:
				_rules.append(tiles["tiles"][j]["top"])
			if i not in _rules:
				map[_y][_x].erase(i)
	if map[_y + 1][_x] <= y:
		for i in map[_y][_x]:
			var _rules:Array = []
			for j in map[_y + 1][_x]:
				_rules.append(tiles["tiles"][j]["bottom"])
			if i not in _rules:
				map[_y][_x].erase(i)
	if map[_y][_x - 1]:
		for i in map[_y][_x]:
			var _rules:Array = []
			for j in map[_y][_x - 1]:
				_rules.append(tiles["tiles"][j]["left"])
			if i not in _rules:
				map[_y][_x].erase(i)
	if map[_y][_x + 1]:
		for i in map[_y][_x]:
			var _rules:Array = []
			for j in map[_y][_x + 1]:
				_rules.append(tiles["tiles"][j]["right"])
			if i not in _rules:
				map[_y][_x].erase(i)
