extends Node2D

#Declare a board side with Vector2i
#Integers are default size
var x:int = 15
var y:int = 15
@export var board:Vector2i = Vector2i(x, y)

#This array will contain the coords of every spot on the board
var map:Array = []

#Atlas coords of all the tiles
var t00000:Vector2i = Vector2i(4, 0)
var t10000:Vector2i = Vector2i(5, 0)
var t01000:Vector2i = Vector2i(6, 0)
var t11000:Vector2i = Vector2i(4, 1)
var t00100:Vector2i = Vector2i(5, 1)
var t10100:Vector2i = Vector2i(6, 1)
var t01100:Vector2i = Vector2i(4, 2)
var t11100:Vector2i = Vector2i(5, 2)
var t00010:Vector2i = Vector2i(6, 2)
var t10010:Vector2i = Vector2i(4, 3)
var t01010:Vector2i = Vector2i(5, 3)
var t11010:Vector2i = Vector2i(6, 3)
var t00110:Vector2i = Vector2i(4, 4)
var t10110:Vector2i = Vector2i(5, 4)
var t01110:Vector2i = Vector2i(6, 4)
var t11110:Vector2i = Vector2i(4, 5)
var t00001:Vector2i = Vector2i(5, 5)
var t10001:Vector2i = Vector2i(6, 5)
var t01001:Vector2i = Vector2i(2, 0)
var t11001:Vector2i = Vector2i(2, 1)
var t00101:Vector2i = Vector2i(2, 2)
var t10101:Vector2i = Vector2i(3, 0)
var t01101:Vector2i = Vector2i(3, 1)
var t11101:Vector2i = Vector2i(3, 2)
var t00011:Vector2i = Vector2i(3, 3)
var t10011:Vector2i = Vector2i(3, 4)
var t01011:Vector2i = Vector2i(3, 5)

#This dict contains all the info for the tiles and rules for wave function collapse
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

var rng:RandomNumberGenerator = RandomNumberGenerator.new() #Define the random number generator
var def_pos:Array =[]

func _ready():
	randomize() #Get random seed
	for i in range(tiles["tiles"].size()): #Makes def_pos contain 0-26
		def_pos.append(i)
	print(def_pos)
	for i in x:
		var column:Array = []
		for j in y:
			column.append(i)
		map.append(column)
	print(map)







