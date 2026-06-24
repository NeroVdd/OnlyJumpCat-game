extends StaticBody3D

var rotacao=1

func _on_shoot_timeout() -> void:
	$"AudioStreamPlayer3D".play()
	var shoot = preload("res://objetos/shuriken.tscn").instantiate()
	shoot.direcao = 1
	get_tree().current_scene.add_child(shoot)
	shoot.global_position = $".".global_position


func _on_visible_on_screen_enabler_3d_screen_entered() -> void:
	$"AudioStreamPlayer3D".play()
	var shoot = preload("res://objetos/shuriken.tscn").instantiate()
	shoot.direcao = 1
	get_tree().current_scene.add_child(shoot)
	shoot.global_position = $".".global_position
