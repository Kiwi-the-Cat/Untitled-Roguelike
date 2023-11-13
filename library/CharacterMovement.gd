extends CharacterBody2D

#Combat variables
signal knife_active

@export var health:int = 20

#Physics variables
@export var speed:int = 300
@export var friction:float = 0.1
@export var acceleration:float = 0.7

#Variables for rolling
var rolling:bool
var roll_time:float = .5 #How long the player rolls
var roll_timer:Timer #Timer active while rolling
var roll_cooldown:Timer #Timer to prevent consecutive rolling

#Animation Variables
@onready var _player = $PlayerCollision/AnimatedSprite2D
@onready var animation_tree:AnimationTree = $AnimationTree

func _ready():
	#Sets variables to coressponding timers
	roll_timer = $RollTimer
	roll_cooldown = $RollCooldown

func _physics_process(delta):
	move()
	if rolling: #Spins while rolling
#		$CollisionShape2D.rotation += 12.6 * delta
		pass
	else:
		pass

func roll():
	rolling = !roll_timer.is_stopped()
	if Input.is_action_just_pressed("roll") && roll_cooldown.get_time_left() == 0:
		var tween = get_tree().create_tween()
		roll_timer.start(roll_time)
		roll_cooldown.start(roll_time * 5)
		tween.tween_property($PlayerCollision, "rotation_degrees", 360, 0.5)
		$PlayerCollision.rotation_degrees = 0


func move(): #All stuff to make character move
	#Speed adjustment if rolling
	if rolling:
		speed = 400
	else:
		speed = 200
	
	#Horizontal movement
	var xDir = Input.get_axis("left", "right")
	if xDir != 0:
		velocity.x = lerp(velocity.x, xDir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	#Vertical movement
	var yDir = Input.get_axis("up", "down")
	if yDir != 0:
		velocity.y = lerp(velocity.y, yDir * speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0.0, friction)
	
	#Calling other nessicary movement functions
	roll()
	move_and_slide()
	velocity.normalized()

func _process(delta):
	var rota:String = str($PlayerCollision.rotation_degrees)
	
	var mousePos:Vector2i = get_global_mouse_position() #Global mouse position
	var screenX:float = get_viewport().size.x #Viewport X axis 
	var screenY:float = get_viewport().size.y #Viewport Y axis
	var xPercent:float = mousePos.x / screenX
	var yPercent:float = mousePos.y / screenY
	

	#Enables knife attack when mouse is clicked
	if Input.is_action_pressed("attack"):
		$Knife.visible = true
		$Knife/KnifeCollision.disabled = false
		$Knife.look_at(Vector2(mousePos.x, mousePos.y))
	else:
		$Knife.visible = false
		$Knife/KnifeCollision.disabled = true

func _on_exit_body_entered(body): #Level Transistions
	match get_tree().current_scene.name:
		"LevelOne":
			get_tree().change_scene_to_file("res://levels/LevelTwo.tscn")
		"LevelTwo":
			get_tree().change_scene_to_file("res://levels/LevelThree.tscn")

func update_animation_parameters():
	if (get_angle_to(get_global_mouse_position()) <= 2.54 and get_angle_to(get_global_mouse_position()) >= 0.5):
		animation_tree["parameters/conditions/facing_down"] = true
		animation_tree["parameters/conditions/facing_left"] = false
		animation_tree["parameters/conditions/facing_right"] = false
		animation_tree["parameters/conditions/facing_up"] = false
	elif (get_angle_to(get_global_mouse_position()) >= 2.65 or get_angle_to(get_global_mouse_position()) <= -2.6):
		animation_tree["parameters/conditions/facing_down"] = false
		animation_tree["parameters/conditions/facing_left"] = true
		animation_tree["parameters/conditions/facing_right"] = false
		animation_tree["parameters/conditions/facing_up"] = false
	elif (get_angle_to(get_global_mouse_position()) >= -0.5 and get_angle_to(get_global_mouse_position()) <= .5):
		animation_tree["parameters/conditions/facing_down"] = false
		animation_tree["parameters/conditions/facing_left"] = false
		animation_tree["parameters/conditions/facing_right"] = true
		animation_tree["parameters/conditions/facing_up"] = false
	elif (get_angle_to(get_global_mouse_position()) >= -2.9 and get_angle_to(get_global_mouse_position()) <= -0.53):
		animation_tree["parameters/conditions/facing_down"] = false
		animation_tree["parameters/conditions/facing_left"] = false
		animation_tree["parameters/conditions/facing_right"] = false
		animation_tree["parameters/conditions/facing_up"] = true

func _on_knife_body_entered(body):
	knife_active.emit()

func hurt():
	health -= 2;
	print("Player: ", health)

func _on_enemy_enemy_attack():
	hurt();
