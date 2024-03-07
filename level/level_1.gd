extends Node2D

func _ready():
	$Player/Camera2D.limit_top = 0
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = 1150
	$Player/Camera2D.limit_bottom = 640

func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/level_2.tscn")
