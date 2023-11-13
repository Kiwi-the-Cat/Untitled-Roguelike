extends CharacterBody2D

@export var health:int = 20

func hurt():
	health -= 2
	print("ow: ", health)


func _on_player_knife_active():
	hurt()
