
extends CharacterBody3D

var life=true
var animation_died=1
var up=10

const SPEED = 600.0
const JUMP_VELOCITY = 6.5

var jump = true

var direction = 1

func _physics_process(delta: float) -> void:
	move_and_slide()
	if life:
		if !is_on_floor():
			CAMERA(delta)
			if direction == 1:
				velocity.x = 2.5
				$"spr".flip_h = false
			else:
				velocity.x = -2.5
				$"spr".flip_h = true
			velocity.y -= 9 * delta
		else:
			velocity.x = 0
		if velocity.y > 0:
			$"spr".play("up")
		else:
			$"spr".play("down")
		if $"direction_right".is_colliding() and direction == 1:
			direction = -1
		elif $"direction_left".is_colliding() and direction == -1:
			direction = 1
			
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and jump:
			velocity.y = JUMP_VELOCITY
			jump = false
			$"jumper_time".start()
			var particle = preload("res://objetos/pum.tscn").instantiate()
			get_tree().root.add_child(particle)
			particle.global_position = $".".global_position
			particle.position.y += 0.15
			particle.emitting=true
	else:
		$"spr".play("hurt")
		velocity.x=0
		if animation_died==1:
			velocity.y+=0.7
			up-=1
			if up<=0:
				animation_died=2
		else:
			velocity.y -= 0.5


@export var camera_speed: float = 10 

func CAMERA(delta: float) -> void:
	var target_rotation_y: float = direction * -5.0
	
	$"Camera3D".rotation_degrees.y = lerp(
		$"Camera3D".rotation_degrees.y, 
		target_rotation_y, 
		camera_speed * delta
	)

func _on_jumper_time_timeout() -> void:
	jump = true

func _on_dano_area_entered(_area: Area3D) -> void:
	velocity.y=0
	life=false
