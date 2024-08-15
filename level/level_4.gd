extends Node2D

func _ready():
	$Player.setCameraLimits(0, 480, 0, 800)


func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/Area_1/left_" + str(randi_range(1, 1)) + ".tscn")
