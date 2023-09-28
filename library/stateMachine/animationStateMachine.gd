class_name ASM #Animation state machine
extends Node

#2 states
@export var facing : Facing
@export var moving : Node


func _ready():
	change_state(facing)
	pass

func change_state(new_state : Facing):
	if facing is Facing:
		facing._exit_state()
	new_state._enter_state()
	facing = new_state
