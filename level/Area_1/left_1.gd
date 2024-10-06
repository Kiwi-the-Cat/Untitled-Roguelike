extends Node2D

func _ready():
	$Player.setCameraLimits(0, 670, 0, 1240)
	get_parent().set_exits([$Exit/CollisionShape2D, $Exit2/CollisionShape2D])
	get_parent().set_enemy_count(0)

func _on_enemy_death():
	get_parent().enemy_death()

func _on_exit_1_area_entered(area):
	if(area.get_parent().name == "Player"):
		get_parent().change_level("Area_1_Left")

func _on_exit_2_area_entered(area):
	if(area.get_parent().name == "Player"):
		get_parent().change_level("Area_1_Bottom")
