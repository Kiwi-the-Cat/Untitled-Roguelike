extends Node2D

# enums
enum Attacks {JUMP = 0, FIREBALL = 1, SUMMON = 2} # help keep track of what attack was last used

@export var scene_x : int
@export var scene_y : int

# public variables
@export var health : int = 25
signal enemy_death #Lets the level know that the enemy has died
var is_attacking := false

# private variables
var _last_attack : int

@onready var frog : AnimatedSprite2D = $FrogCharacter/Sprite2D
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

func _process(delta: float) -> void:
	#Resets to idle animation whenever animations finish
	if($FrogCharacter/Sprite2D.animation_finished && $FrogCharacter/Sprite2D.animation != "idle"):
		$FrogCharacter/Sprite2D.play("idle")
	
	#Dying
	if(health <= 0):
		$FrogCharacter/Sprite2D.play("death")
	if ($FrogCharacter/Sprite2D.animation_finished): #only official die after death animation is over
		enemy_death.emit()
		self.queue_free()
