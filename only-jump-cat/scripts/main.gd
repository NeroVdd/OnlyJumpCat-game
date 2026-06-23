extends Node3D

var posicao_y_jogador = 0

var exit=false

var start = false

var MAX_trap = 6
var trap = randi_range(1,MAX_trap)

func _ready() -> void:
	#$"player".process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = true
	randomize()
	for i in 3:
		_gerar()
	posicao_y_jogador = $"player".position.y

var speed_lava = 0.005

var AlturaObjetos = {
	"parede" : 10,
	"armadilha" : 10
}

var cloud=false

func _process(_delta: float) -> void:
	if $"player":
		if abs($"player".position.y - posicao_y_jogador) > 5:
			posicao_y_jogador = $"player".position.y
			_gerar()
		if $"player".position.y < ($"Object/Lava".position.y - 1):
			get_tree().paused = true
			$"HUB/Intro/AnimationPlayer".play("out")
		if $"player".position.y > 50 and !cloud:
			$"Object/clouds/clouds".emitting = true
		$"Object/clouds".position.y = $"player".position.y + 1
			
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and !start:
		start=true
	if start:
		$"Object/Lava".position.y += speed_lava
		$"Object/Lava/Mesh".mesh.material.uv1_offset += Vector3(0, 0, 1) * delta
		speed_lava += 0.00001
		

func _gerar() -> void:
	var terra = preload("res://objetos/walls.tscn").instantiate()
	add_child(terra)
	terra.global_position.y = AlturaObjetos["parede"]
	AlturaObjetos["parede"] += 10
	if trap == 1:
		var cerra = preload("res://objetos/cerra_pequena.tscn").instantiate()
		add_child(cerra)
		cerra.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 5
		random_trap()
	elif trap == 2:
		var cerra = preload("res://objetos/duas_cerras.tscn").instantiate()
		add_child(cerra)
		cerra.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 5
		random_trap()
	elif trap == 3:
		var platform=preload("res://objetos/plataforma_1.tscn").instantiate()
		add_child(platform)
		platform.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 5
		random_trap()
	elif trap == 4:
		var trap=preload("res://objetos/cerra_girando.tscn").instantiate()
		add_child(trap)
		trap.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 6
		random_trap()
	elif trap == 5:
		var trap=preload("res://objetos/cerra_grande.tscn").instantiate()
		add_child(trap)
		trap.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 6
		random_trap()
	elif trap == 6:
		var trap=preload("res://objetos/cerra_direcao.tscn").instantiate()
		add_child(trap)
		trap.position.y = AlturaObjetos["armadilha"]
		AlturaObjetos["armadilha"] += 5
		random_trap()
	

func random_trap() -> void:
	trap = randi_range(1,MAX_trap)


func _on_lava_body_entered(body: Node3D) -> void:
	body.queue_free()


func _on_play_pressed() -> void:
	get_tree().paused = false
	$"HUB/button play/Play".disabled = true
	$"HUB/Intro/AnimationPlayer".play("play")


func _on_exit_pressed() -> void:
	get_tree().paused = true
	exit=true
	$"HUB/Intro/AnimationPlayer".play("out")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "out":
		if exit:
			get_tree().quit()
		else:
			get_tree().change_scene_to_file("res://main.tscn")


func _on_dano_area_entered(area: Area3D) -> void:
	$"HUB/Intro/AnimationPlayer".play("out")
