extends CharacterBody2D

signal dead

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0

@export var health := 6

var enemyInRange := false
var attackCooldown := true
var isAlive := true
var attack_ip := false

@onready var playerSprite : AnimatedSprite2D = $Sprite


func _physics_process(_delta):
	attack()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _process(_delta):
	if (health <= 0):
		isAlive = false
		dead.emit()
	
	if (velocity == Vector2(0, 0)):
		playerSprite.play("idle")
	elif (velocity.x > 0 or velocity.x < 0) or (velocity.y > .1 or velocity.y < -.1):
		playerSprite.play("walk")
	
	var mouseAngle = rad_to_deg(get_angle_to(get_global_mouse_position()))
	$Sprite.flip_h = mouseAngle > -90 && mouseAngle < 90

func setCameraLimits(top, bottom, left, right):
	$Camera2D.zoom = Vector2(1.5, 1.5) #Sets a default zoom in case we want to do level-specific things
	$Camera2D.limit_top = top
	$Camera2D.limit_bottom = bottom
	$Camera2D.limit_left = left
	$Camera2D.limit_right = right

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if (body.has_method("enemy")):
		enemyInRange = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if (body.has_method("enemy")):
		enemyInRange = false
		
func enemyAttack():
	if (enemyInRange and attackCooldown):
		attackCooldown = false
		health -= 1
		$AttackCooldown.start()
		print("Player took damage", health)


func _on_attack_cooldown_timeout() -> void:
	attackCooldown = true
	Global.player_current_attack = false
	attack_ip = false

func attack() -> void:
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		playerSprite.play("attack_side")
		$AttackCooldown.start()
		print("attacked")
		
