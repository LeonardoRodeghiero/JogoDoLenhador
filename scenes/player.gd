extends CharacterBody2D


var direcao: String
const GRAVITY = 800
const PULO = -400
var velocidade: int = 400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Animacao.play("correr_dir")
	direcao = 'dir'
	$Animacao.stop()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction_velocity:Vector2
	
	
	if is_on_floor():
		if $Animacao.animation == "pulo_dir" or $Animacao.animation == "pulo_esq":
			if direcao == "dir":
				$Animacao.play("correr_dir")
				$Animacao.pause()
			if direcao == 'esq':
				$Animacao.play("correr_esq")
				$Animacao.pause()
		#print("ta no chao")
		if Input.is_action_pressed("ataque"):
			if direcao == 'dir':
				$Animacao.play("ataque_dir")
			if direcao == 'esq':
				$Animacao.play("ataque_esq")
				
		elif Input.is_action_pressed("direita"):
			$Animacao.play("correr_dir")
			direction_velocity[0] = 1
			direcao = "dir"
		elif Input.is_action_pressed("esquerda"):
			$Animacao.play("correr_esq")
			direction_velocity[0] = -1
			direcao = "esq"
		else:
			if direcao == 'dir':
				$Animacao.play("correr_dir")
				$Animacao.pause()
			if direcao == 'esq':
				$Animacao.play("correr_esq")
				$Animacao.pause()
		velocity = direction_velocity * velocidade
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y += PULO
		if direcao == 'dir':
			$Animacao.play("pulo_dir")
		if direcao == 'esq':
			$Animacao.play("pulo_esq")
			
	else:
		
		velocity.y += GRAVITY * delta
		#print("nao ta no chao")
	
	#print(pulando)
	
	
	
	
	move_and_slide()
