extends Node2D

@onready var tween : Tween = $FrogCharacter.create_tween()

func jump():
	$FrogCharacter/Sprite2D.play("jump")
	tween.tween_property($FrogCharacter/Sprite2D, "scale", Vector2(10, 10), 1)
	tween.tween_property($FrogCharacter/Sprite2D, "scale", Vector2(1, 1), 1)
	
func _ready() -> void:
	$FrogCharacter.position = Vector2(500, 250)
	jump()
