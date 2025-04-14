extends Node2D

# enums
enum Attacks {JUMP = 0, FIREBALL = 1, SUMMON = 2} # help keep track of what attack was last used

@export var scene_x : int
@export var scene_y : int

# public variables
var is_attacking := false

# private variables
var _last_attack : int

@onready var frog : Sprite2D = $FrogCharacter/Sprite2D
@onready var tween : Tween = $FrogCharacter.create_tween()

func jump():
	_last_attack = Attacks.JUMP
	frog.play("jump")
	tween.tween_property(frog, "scale", Vector2(10, 10), 1)
	tween.tween_property(frog, "position", Vector2(randi_range(0, scene_x), randi_range(0, scene_y)), 2)
	tween.tween_property(frog, "scale", Vector2(1, 1), 1)
	# this isn't ideal, but it'll work
	is_attacking = true
	
	
func _ready() -> void:
	$FrogCharacter.position = Vector2(500, 250)
	jump()
