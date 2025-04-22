extends Node2D

# enums
enum Attacks {JUMP = 0, FIREBALL = 1, SUMMON = 2} # help keep track of what attack was last used

@export var scene_x : int
@export var scene_y : int

# public variables
@export var health : int = 15
signal enemy_death #Lets the level know that the enemy has died
var is_attacking := false

# private variables
var _last_attack : int
var i_frames:bool = false
var player_in_range:bool = false

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
	pass

func deal_damage() -> void:
	if player_in_range and Global.player_current_attack:
		if !i_frames:
			$FrogCharacter/Sprite2D.play("hurt")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	deal_damage()

func _on_sprite_2d_animation_looped() -> void:
	match($FrogCharacter/Sprite2D.animation):
		"hurt":
			health -= 1
			print("Boss takes damage")
			i_frames = true
			$IFrames.start()
			
			if health <= 0:
				$FrogCharacter/Sprite2D.play("death")
			else:
				$FrogCharacter/Sprite2D.play("idle")
		"death":
			enemy_death.emit()
			self.queue_free()
		_:
			$FrogCharacter/Sprite2D.play("idle")

func _on_i_frames_timeout() -> void:
	i_frames = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
