extends CharacterBody2D

@export var health:int = 20

func hurt():
	health -= 2
	if(health > 0):
		print("Health: ", health)
	else:
		print("Dead")
		get_parent().remove_child(self)


func _on_player_knife_active():
	hurt()
