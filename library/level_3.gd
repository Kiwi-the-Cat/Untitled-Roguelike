extends Node2D

func _ready():
	$Player.setCameraLimits(-60, 420, 0, 1150)
	if (get_parent().scene_file_path == "res://level/main.tscn"):
		get_parent().set_exits([$Exit/CollisionShape2D])
		get_parent().set_enemy_count(1)

func _on_enemy_death():
	if (get_parent().scene_file_path == "res://level/main.tscn"):
		get_parent().enemy_death()
	
func _on_exit_body_entered(body: Node2D) -> void:
	if (get_parent().scene_file_path == "res://level/main.tscn"):
		get_parent().change_level("res://level/level_4.tscn")
