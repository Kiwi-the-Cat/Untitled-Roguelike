extends Node2D

# map size 15 x 15 for test
@export var width:int = 15
@export var height:int = 15 

var map:Array = [] # map with all possitions for possible tiles
var constraints:Dictionary = { # rules for tile placement (maybe)
	# rules contains tiles that are allowed to connect
	# Green is floor
	# Orange is Wall 
	# 0-8 is Green
	# 9-17 is Orange
	"parts": [
		{"index": 0, "name":[0,0,0,0,0,0], "rules":{"right":[0, 1], "top":[0, 2], "left":[0, 3], "down":[0, 4]}}, # Center tile
		{"index": 1, "name":[1,0,0,0,0,0], "rules":{"right":[12, 15, 17], "top":[1, 5], "left":[0, 3], "down":[1, 7]}}, # Right Tile
		{"index": 2, "name":[0,1,0,0,0,0], "rules":{"right":[2, 5], "top":[13, 16, 17], "left":[2, 6], "down":[0, 4]}}, # Top Tile        
		{"index": 3, "name":[1,1,0,0,0,0], "rules":{"right":[0, 1], "top":[3, 6], "left":[10, 14, 16], "down":[3, 7]}}, # Left Tile       
		{"index": 4, "name":[0,0,1,0,0,0], "rules":{"right":[4, 7], "top":[0, 2], "left":[4, 8], "down":[11, 14, 15]}}, # Bottom Tile      
		{"index": 5, "name":[1,0,1,0,0,0], "rules":{"right":[12], "top":[13, 16], "left":[2 ,6], "down":[1, 7]}}, # Top Right Tile   
		{"index": 6, "name":[0,1,1,0,0,0], "rules":{"right":[2, 5], "top":[13, 16], "left":[10, 16], "down":[3, 8]}}, # Top Left Tile    
		{"index": 7, "name":[1,1,1,0,0,0], "rules":{"right":[12, 15], "top":[1, 5], "left":[4, 8], "down":[11, 15]}}, # Bottom Right Tile
		{"index": 8, "name":[0,0,0,1,0,0], "rules":{"right":[4, 7], "top":[3 ,6], "left":[10, 14], "down":[11, 14]}}, # Bottom Left Tile
		{"index": 9, "name":[1,0,0,1,0,0], "rules":{"right":[9, 10], "top":[9, 11], "left":[9, 12], "down":[9, 13]}}, # Center tile       
		{"index":10, "name":[0,1,0,1,0,0], "rules":{"right":[3, 6, 8], "top":[10, 14], "left":[9, 12], "down":[10, 16]}}, # Right Tile        
		{"index":11, "name":[1,1,0,1,0,0], "rules":{"right":[11, 14], "top":[4, 7], "left":[11, 15], "down":[9, 13]}}, # Top Tile          
		{"index":12, "name":[0,0,1,1,0,0], "rules":{"right":[9, 10], "top":[12, 15], "left":[1, 5, 7], "down":[12, 17]}}, # Left Tile         
		{"index":13, "name":[1,0,1,1,0,0], "rules":{"right":[13, 16], "top":[9, 11], "left":[13, 17], "down":[2, 5, 6]}}, # Bottom Tile       
		{"index":14, "name":[0,1,1,1,0,0], "rules":{"right":[3], "top":[4,7], "left":[11, 15], "down":[10, 16]}}, # Top Right Tile    
		{"index":15, "name":[1,1,1,1,0,0], "rules":{"right":[11, 14], "top":[4, 7], "left":[1, 7], "down":[12, 17]}}, # Top Left Tile     
		{"index":16, "name":[0,0,0,0,1,0], "rules":{"right":[3, 6], "top":[10, 14], "left":[13, 17], "down":[2, 6]}}, # Bottom Right Tile 
		{"index":17, "name":[1,0,0,0,1,0], "rules":{"right":[13, 16], "top":[12, 15], "left":[1, 5], "down":[2, 5]}}, # Bottom Left Tile  
	]
}

var rng:RandomNumberGenerator = RandomNumberGenerator.new() # defines the random number generator
var def_pos:Array = [] # default values for all tiles

# initializations
func _ready():
	randomize() # randomize the seed every time the game is run
	# adds the tile indexes to def_pos
	for i in range(constraints["parts"].size()):
		def_pos.append(i)
	print(def_pos)
	_generate()

func _generate():
	# initializes map with all possible positions
		for _i in range(width):
			var line:Array = []
			for _j in range(height):
				var possible:Array = def_pos.duplicate(true)
				possible.reverse()
				line.append_array(possible)
			map.append_array(line)
		
		print("entering")
		#starts first walk on random position
		var le_pos:Vector2i = Vector2i(
			rng.randi_range(0, width),
			rng.randi_range(0, height)
			)
		#The whole process consists on 3 steps:
			#Collapsing:
			#Collapsing a tile, selects one of the possible options.
			#On the first tile all options are available so one is selected
			#to start the process
		_collapse(_calc_entropy()[1])
		#Propagation:
			#Based on the current tile, propagates (applies the constraints)
			#to adjacent tiles, the algorithm chooses then to proceed to the
			#adjacent tile with lesser entropy (which has better chance to collapse)
		_propagate(_calc_entropy()[1], 0)
		#Update:
			#update values on gridmap
			#_update_map()
		
		#We then repeat the process until all tiles are collapsed
		#(Indicated by the smaller entropy possible, which is 
		#width*height, which states that all tiles have one possible
		#state)
		var ent:Array = _calc_entropy()
		#Rinse and repeat
		while ent[0] > width * height:
			#Yield is here to help visualization, whithout it
			#the algorithm only shows results when done
			await(get_tree().create_timer(0.01))
			ent = _calc_entropy()
			_collapse(ent[1])
			_propagate(ent[1], 0)
			_update_map()
			

#Updates Tilemap showing values
func _update_map():
	#Uncommenting this slows the process a lot on larger grids
	#It shows available tiles for each position, adding one
	#label per position on the grid.
	#_print_Values()
	
	#For each tile on the grid, get selected tile from map
	#and grid orientation from constraints
	for i in range(width):
		for j in range(height):
			var possible_tiles = map[i][j]
			if possible_tiles.size() == 1:
				var tile_id:int = constraints["parts"][possible_tiles[0]]["tile_id"]



#Calculates map entropy
#Returns whole map entropy and the position with
#lesser entropy
func _calc_entropy() -> Array:
	var entropy:int = 0
	var lowest:Vector2i = Vector2i.ZERO
	var positions:Array = []
	for i in range(width): # creates an array of all the posible positions of possible tiles, I think
		for j in range(height):
			var possible_tiles:Array = map[i][j]
			if possible_tiles.size() > 1:
				positions.append(Vector2i(i, j))
			entropy += possible_tiles.size()
	
	var lowest_en:int = 100.0
	for pos in positions:
		var possible_tiles:Array = map[pos.x][pos.y]
		if possible_tiles.size() < lowest_en:
			lowest = Vector2(pos.x, pos.y)
			lowest_en = possible_tiles.size()
	return[entropy, lowest]


#Applies rules on the desired position to all neighbors
#For now only horizontal rules (NORTH, SOUTH, EAST and WEST)
#Top and bottom are actually NORTH and SOUTH
func _propagate(pos:Vector2, level:int):
	#There could be deadlocks on rule calculation,
	#Level cap avoids that
	if level > 250:
		return

	#For each tile rule
	#Apply tile to neighbor and stores possible directions
	#(if a tile is collapsed or out of bounds, it's discarded)
	var rules:Dictionary = constraints["parts"][map[pos.x][pos.y][0]]["rules"]
	var possible_dirs:Array = []
	for rule in rules:
		match rule:
			"top":
				if pos.y - 1 >= 0:
					var pos_l:Vector2i = Vector2i(pos.x, pos.y - 1)
					_apply_rules(rules["top"], pos_l)
			"down":
				if pos.y + 1 < 0:
					var pos_l:Vector2i = Vector2i(pos.x, pos.y + 1)
					_apply_rules(rules["down"], pos_l)
			"left":
				if pos.x - 1 >= 0:
					var pos_l:Vector2i = Vector2i(pos.x - 1, pos.y)
					_apply_rules(rules["left"], pos_l)
			"right":
				if pos.x + 1 < 0:
					var pos_l:Vector2i = Vector2i(pos.x + 1, pos.y)
					_apply_rules(rules["right"], pos_l)
	
	#Propagates rules to the lowest entropy
	#non-collapsed tile
	if possible_dirs.size() > 0:
		var lowest_en:int = 100
		var lowest_en_pos = Vector2i.ZERO
		var found:bool = false
		for pos_dir in possible_dirs:
			var possible_tiles:Array = map[pos_dir.x][pos_dir.y]
			if lowest_en > possible_tiles.size() and possible_tiles.size() > 1:
				lowest_en = possible_tiles.size()
				lowest_en_pos = pos_dir
				found = true
		
		if found:
			_collapse(lowest_en_pos)
			_propagate(lowest_en_pos, level + 1)


func _print_Values():
	pass


#Collapses a tile, using a random possible tile from
#possible remaining tiles
func _collapse(le_pos:Vector2i):
	var select:Array = map[le_pos.x][le_pos.y]
	map[le_pos.x][le_pos.y] = [select[rng.randi_range(0, select.size() -1)]]


#Remove all non-possible tiles from current at position
#If all tiles are removed, defaults to all possible for
#new calculation
func _apply_rules(rules:Array, pos:Vector2):
	var possible_tiles:Array = map[pos.x][pos.y]
	if possible_tiles.size() == 1:
		return
	
	var to_remove:Array = []
	for i in range(possible_tiles.size()):
		var value = possible_tiles[i]
		if !(value in rules):
			to_remove.append(value)
	
	if to_remove.size() == 0:
		return
	
	for i in range(to_remove.size()):
		map[pos.x][pos.y].remove(possible_tiles.find(to_remove[i]))
	
	if possible_tiles.size() == 0:
		map[pos.x][pos.y] = def_pos.duplicate(true)
		return
	
	return














