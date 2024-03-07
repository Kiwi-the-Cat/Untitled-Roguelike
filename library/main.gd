extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene_to_file("res://level/level_1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
