extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func randomLevel(zone, enter_direction):
	var level_path:String = "res://level/" + zone + "/" + enter_direction + "_" + randi_range(1, 2) + ".tscn"
	get_tree().change_scene_to_file(level_path)
