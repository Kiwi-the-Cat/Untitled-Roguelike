extends Node2D

#The play field will be 16 x 16 for now
@export var x:int = 16 #The width of the field
@export var y:int = 16 #The height of the field
var coords:Vector2i = Vector2i(x, y)

#Things I need to put in the tile data func:
	#The atlas location of all the tiles
	#what tiles can go next to eachother
	

var atlas:Dictionary = {
	0 :Vector2i(2, 0), #Grass with small rock and flowers
	1 :Vector2i(3, 0), #Grass with white flowers
	2 :Vector2i(4, 0), #Top left outter dirt inner grass corner
	3 :Vector2i(5, 0), #Top outer dirt inner grass
	4 :Vector2i(6, 0), #Top right outter dirt inner grass
	5 :Vector2i(2, 1), #Grass with Big rock and flowers
	6 :Vector2i(3, 1), #Grass with mulicolored flowers
	7 :Vector2i(4, 1), #Left Outter dirt inner grass
	8 :Vector2i(5, 1), #Grass
	9 :Vector2i(6, 1), #Right outter dirt inner grass
	10:Vector2i(2, 2), #Grass with tree stump
	11:Vector2i(3, 2), #Grass with pebbles and muschrooms
	12:Vector2i(4, 2), #Bottom left outter dirt inner grass
	13:Vector2i(5, 2), #Bottom outer dirt inner grass
	14:Vector2i(6, 2), #Bottom right outter dirt inner grass
	15:Vector2i(),
	16:Vector2i(),
	17:Vector2i(),
	18:Vector2i(),
	19:Vector2i(),
	20:Vector2i(),
	21:Vector2i(),
	22:Vector2i(),
	23:Vector2i(),
	24:Vector2i(),
	25:Vector2i(),
	26:Vector2i(),
}

func _ready():
#	$TileMap.clear()
	var tileIndex:Array #An array that contains the index of all the tiles in the spritesheet
	
	
