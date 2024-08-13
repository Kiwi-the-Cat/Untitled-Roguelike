extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_next_level(area:String):
	var direction:String = ""
	match(randi_range(0, 1)):
		0:
			direction = "bottom_"
		_:
			direction = "left"
			
	var level_path:String = "res://level/" + area + "/" + direction + str(randi_range(1, 3)) + ".tscn"
	return level_path
