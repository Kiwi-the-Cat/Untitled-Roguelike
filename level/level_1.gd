extends Node2D

func _ready():
	$Player.setCameraLimits(0, 640, 0, 1150)
	get_parent().set_exits([$Exit/CollisionShape2D])
	get_parent().set_enemy_count(0)

func _on_exit_area_entered(area):
	if(area.get_parent().name == "Player"):
		get_parent().change_level("res://level/level_2.tscn")
