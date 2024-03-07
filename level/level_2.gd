extends Node2D


func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/level_3.tscn")
