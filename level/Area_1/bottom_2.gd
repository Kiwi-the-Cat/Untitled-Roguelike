extends Node2D

func _ready():
	$Player.setCameraLimits(0, 1050, 0, 760)
	get_parent().set_exits([$Exit/CollisionShape2D])
	get_parent().set_enemy_count(3)

func _on_enemy_death():
	get_parent().enemy_death()

func _on_exit_area_entered(area):
	if(area.get_parent().name == "Player"):
		get_parent().change_level("Area_1_Bottom")
