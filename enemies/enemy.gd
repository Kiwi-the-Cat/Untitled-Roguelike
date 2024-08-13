extends CharacterBody2D

@onready var player : CharacterBody2D = get_parent().get_node("Player")
@onready var sprite : AnimatedSprite2D = $Sprite
@onready var spriteFrames : SpriteFrames = sprite.sprite_frames

#Combat variables
@onready var attackTimer : Timer = $Hitbox/AttackTimer
var health : int = 20
var attacking : bool = true
var state : String = "idle"
signal death

#Movement Variables
@onready var navAgent : NavigationAgent2D = $NavigationAgent2D
@export var speed : float = 200
var target : Vector2
var currentPos : Vector2
var nextPos : Vector2

func _process(_delta):
	$HealthBar.value = health
	if(player != null && state != "death"):
		move()
	
	#Checks for dying
	if(health <= 0):
		sprite.play("death")
		state = "death"
	else:
		sprite.play(state)

func move():
	target = player.position
	navAgent.set_target_position(target)
	
	currentPos = global_transform.origin
	nextPos = navAgent.get_next_path_position()
	velocity = (nextPos - currentPos).normalized() * speed
	
	if(state == "attack"): #Pause for attack animation to play
		velocity *= 0
	elif(!attacking): #Prevents enemy from repeatedly hitting player
		velocity *= -1
	
	sprite.flip_h = target.x > self.position.x
	move_and_slide()

func _on_attack_timer_timeout():
	match(state):
		"attack":
			state = "idle"
			attackTimer.start(1)
		"idle":
			attacking = true

func _on_hitbox_area_entered(area):
	if(area.get_parent().get_name() == "Player"): #Ensures that enemies don't collide with each other's hitboxes
		attackTimer.start(spriteFrames.get_frame_count("attack") / spriteFrames.get_animation_speed("attack"))
		attacking = false
		state = "attack"
		health -= 10

func _on_animated_sprite_2d_frame_changed():
	if(state == "death" && sprite.frame == 5):
		death.emit()
		self.queue_free()
