extends Node2D

#change scene on start
func _process(delta): #_ready doesn't work for some reason
	if(get_tree().current_scene.name == "Main"): #Only change scenes if on main scene
		get_tree().change_scene_to_file("res://levels/LevelOne.tscn")
		
