extends Node2D

func _ready():
	$Player.setCameraLimits(0, 550, 0, 1150)
	

func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/level_3.tscn")
