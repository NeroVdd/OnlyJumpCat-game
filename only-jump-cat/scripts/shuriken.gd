extends RigidBody3D

@export_range(1,8) var direcao: int = 1

func _ready() -> void:
	$"CollisionShape3D".disabled = true
	if direcao == 1:
		constant_force = Vector3(2.5,0,0)
	elif direcao == 2:
		constant_force = Vector3(-2.5,0,0)
	elif direcao == 3:
		constant_force = Vector3(0,2.5,0)
	elif direcao == 4:
		constant_force = Vector3(0,-2.5,0)
	elif direcao == 5:
		constant_force = Vector3(2.5,2.5,0)
	elif direcao == 6:
		constant_force = Vector3(-2.5,2.5,0)
	elif direcao == 7:
		constant_force = Vector3(-2.5,-2.5,0)
	elif direcao == 8:
		constant_force = Vector3(2.5,-2.5,0)


func _on_body_entered(_body: Node) -> void:
	#$"centro spr/spr/AnimationPlayer".stop()
	queue_free()


func _on_timer_timeout() -> void:
	$"CollisionShape3D".disabled = false
