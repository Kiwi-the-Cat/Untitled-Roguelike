extends Node2D

func _ready():
	$Player.setCameraLimits(-90, 630, -40, 1240)
	if (get_parent().scene_file_path == "res://level/main.tscn"):
		get_parent().set_exits([$Exit1/CollisionShape2D, $Exit2/CollisionShape2D])
		get_parent().set_enemy_count(2)

#Starts the boss fight when player walks into area
func _on_area_2d_body_entered(body: Node2D) -> void: 
	#Enable invisible wall preventing player from exiting area
	$Walls.enabled = true
	
	#Expands player camera so they can see the full field
	$Player/Camera2D.zoom = Vector2(0.9, 0.9)
	
	#Plays summon animation
	$FrogBoss/FrogCharacter/Sprite2D.play("summon")
	
	#Disables self to prevent accidental resetting of the boss
	$BossStart.monitoring = false
