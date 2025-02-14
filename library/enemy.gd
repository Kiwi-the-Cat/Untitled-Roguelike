extends CharacterBody2D

@export var speed : int = 20

var playerChase : bool = false
var player = null

func _ready() -> void:
	$Sprite.play("idle")

func _physics_process(delta: float) -> void:
	if playerChase:
		position += (player.position - position)/speed
		
		if (player.position.x - position.x) < 0:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	playerChase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	playerChase = false

func enemy():
	pass
