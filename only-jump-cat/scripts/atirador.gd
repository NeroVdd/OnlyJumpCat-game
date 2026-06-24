extends StaticBody3D

var rotacao=1

func _on_shoot_timeout() -> void:
	$"AudioStreamPlayer3D".play()
	if rotacao==1:
		for i in 4:
			var shoot = preload("res://objetos/shuriken.tscn").instantiate()
			shoot.direcao = i+1
			get_tree().current_scene.add_child(shoot)
			shoot.global_position = $".".global_position
		rotacao=2
		$"Atirador".rotation.z=0
	else:
		for i in 4:
			var shoot = preload("res://objetos/shuriken.tscn").instantiate()
			shoot.direcao = i+5
			get_tree().current_scene.add_child(shoot)
			shoot.global_position = $".".global_position
		rotacao=1
		$"Atirador".rotation.z=45


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	$"AudioStreamPlayer3D".play()
	for i in 4:
		var shoot = preload("res://objetos/shuriken.tscn").instantiate()
		shoot.direcao = i+1
		get_tree().current_scene.add_child(shoot)
		shoot.global_position = $".".global_position
	rotacao=2
	$"Atirador".rotation.z=0
