extends CharacterBody2D

@export var health : int = 3
signal enemy_death #Lets the level know that the enemy has died

var player_chase : bool = false
var player = null
var player_in_range : bool

#Movement Variables
@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@export var speed : float = 100
var target : Vector2
var current_pos : Vector2
var next_pos : Vector2
var detect_range : int = 200

var i_frames := false

func _ready() -> void:
	$Sprite.play("idle")

func _physics_process(delta: float) -> void:
	deal_damage()
	
	if(player_chase):
		target = Vector2(player.position.x, player.position.y)
		navAgent.set_target_position(target)
		
		current_pos = global_transform.origin
		next_pos = navAgent.get_next_path_position()
		velocity = (next_pos - current_pos).normalized() * speed
		
		$Sprite.flip_h = target.x > self.position.x
		if(position.distance_to(target) > 15): #Doesn't move if too close to player
			move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func enemy():
	pass

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true

func _on_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
	
func deal_damage() -> void:
	if player_in_range and Global.player_current_attack:
		if !i_frames:
			$Sprite.play("hurt")

func _on_i_frames_timeout() -> void:
	i_frames = false

func _on_sprite_animation_looped() -> void:
	#Checks enemy condition after animations
	match($Sprite.animation):
		"hurt":
			health -= 1
			print("Enemy takes damage")
			i_frames = true
			$IFrames.start()
			
			if health <= 0:
				$Sprite.play("death")
			else:
				$Sprite.play("idle")
		"death":
			enemy_death.emit()
			self.queue_free()
		_:
			$Sprite.play("idle")
