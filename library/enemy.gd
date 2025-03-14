extends CharacterBody2D

var playerChase : bool = false
var player = null

#Movement Variables
@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@export var speed : float = 100
var target : Vector2
var currentPos : Vector2
var nextPos : Vector2
var detect_range : int = 200

func _ready() -> void:
	$Sprite.play("idle")

func _physics_process(delta: float) -> void:
	if(playerChase):
		target = player.position
		navAgent.set_target_position(target)
		
		currentPos = global_transform.origin
		nextPos = navAgent.get_next_path_position()
		velocity = (nextPos - currentPos).normalized() * speed
		
		$Sprite.flip_h = target.x > self.position.x
		move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	playerChase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	playerChase = false

func enemy():
	pass
