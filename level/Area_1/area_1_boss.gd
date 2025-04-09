extends Node2D

func _ready():
	$Player.setCameraLimits(-95, 510, -65, 1250)
	if (get_parent() != null):
		get_parent().set_exits([$Exit1/CollisionShape2D, $Exit2/CollisionShape2D])
		get_parent().set_enemy_count(2)
