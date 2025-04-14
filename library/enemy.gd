extends CharacterBody2D

@export var health : int

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

var i_frames := true

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
			health -= 1
			i_frames = true
			$IFrames.start()
			if health <= 0:
				self.queue_free()

func _on_i_frames_timeout() -> void:
	i_frames = false
