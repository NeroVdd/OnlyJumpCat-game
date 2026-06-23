extends CPUParticles3D

func _process(_delta: float) -> void:
	if !$".".emitting:
		$".".queue_free()
