extends Node2D

#Level variables
var enemyCount:int
var exits:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Main Ready")
	change_level("res://level/level_1.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called from each level to, well, change the level
func change_level(_filePath:String):
	print("\nChanging level")
	#Removes all children (there should only be one)
	for child:Node in get_children():
		remove_child(child)
	
	#Sets file path based on what the level passes for _filePath
	var path:String = ""
	var area_1 = [ #Array of all of the levels
		["res://level/Area_1/left_1.tscn", "res://level/Area_1/left_2.tscn"], #Index 0: Enter from left
		["res://level/Area_1/bottom_1.tscn", "res://level/Area_1/bottom_2.tscn"] #Index 1: Enter from bottom
	]
	match(_filePath):
		"Area_1_Left": #random level entering from left
			path = area_1[0][randi_range(0, area_1[0].size() - 1)]
		"Area_1_Bottom": #random level entering from bottom
			path = area_1[1][randi_range(0, area_1[1].size() - 1)]
		_: #exact level from _filePath
			path = _filePath
	
	#Adds new level as child from path variable
	print(path)
	var level = load(path) #Loads path
	var levelNode = level.instantiate() #Turns path to node
	add_child(levelNode) #Adds node

# Adds collisions for level exits (the exit itself isn't relevant)
# Separate from change_level because the level needs to be loaded and added before exits can be added
func set_exits(_exits:Array): 
	exits = _exits

# Sets the number of enemies
# Separate from change_level because the levels are sometimes randomly generated
func set_enemy_count(_enemyCount:int):
	enemyCount = _enemyCount
	print("Enemies:" + str(enemyCount))

# Triggers on enemy death, self explanatory
func enemy_death():
	enemyCount -= 1
	print("Enemy Died")
	#Enables all exits once all enemies are dead
	if(enemyCount <= 0):
		print("Exits open")
		for exit:CollisionShape2D in exits:
			exit.disabled = false
