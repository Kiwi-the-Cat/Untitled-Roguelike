extends Node2D

func _ready():
	print(get_parent())
	if (get_parent().scene_file_path == "res://level/main.tscn"):
		$Player.setCameraLimits(-95, 510, -65, 1250)
		get_parent().set_exits([$Exit1/CollisionShape2D, $Exit2/CollisionShape2D])
		get_parent().set_enemy_count(2)
