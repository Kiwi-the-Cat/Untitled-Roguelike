extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_next_level(area:String, direction:String):
	var level_path:String = "res://level/" + area + "/" + direction + "_" + str(randi_range(1, 1)) + ".tscn"
	return level_path
