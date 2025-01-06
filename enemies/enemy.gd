extends CharacterBody2D

@export var speed : int = 25 
var playerChase : bool = false
var player = null

func _physics_process(delta: float) -> void:
	if playerChase:
		position += (player.position - position)/speed

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	playerChase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	playerChase = false
