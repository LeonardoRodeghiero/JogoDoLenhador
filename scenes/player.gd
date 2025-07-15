extends CharacterBody2D

enum Estado { CORRENDO, ATACANDO, PULANDO }
var estado_atual
var direcao: String
const GRAVITY = 800
const PULO = -400
var velocidade: int = 400
var pulando: bool = false
var parado: bool = false
signal ataque

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Animacao.play("correr_dir")
	direcao = 'dir'
	$Animacao.stop()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction_velocity:Vector2
	
	if Input.is_action_pressed("esquerda") and Input.is_action_pressed("direita") and $Animacao.animation not in ['ataque_dir', 'ataque_esq']:
		if direcao == 'dir':
			$Animacao.play("rest_dir")
		if direcao == 'esq':
			$Animacao.play("rest_esq")
		parado = true
	elif Input.is_action_pressed("direita") and $Animacao.animation not in ['ataque_dir', 'ataque_esq']:
		direction_velocity.x = 1
		direcao = "dir"
		parado = false
	elif Input.is_action_pressed("esquerda") and $Animacao.animation not in ['ataque_dir', 'ataque_esq']:
		direction_velocity.x = -1
		direcao = "esq"
		parado = false
	
	if is_on_floor():
		pulando = false
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
			elif direcao == 'esq':
				$Animacao.play("ataque_esq")
		
		elif Input.is_action_pressed("direita") and not parado:
			$Animacao.play("correr_dir")
		elif Input.is_action_pressed("esquerda") and not parado:
			$Animacao.play("correr_esq")
		
		
		elif not Input.is_action_pressed("direita") and not  Input.is_action_pressed("esquerda"):
			if direcao == 'dir':
				$Animacao.play("rest_dir")
			elif direcao == 'esq':
				$Animacao.play("rest_esq")
				
				
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y += PULO
		pulando = true
		if direcao == 'dir':
			$Animacao.play("pulo_dir")
		if direcao == 'esq':
			$Animacao.play("pulo_esq")
	
	else:
		
		velocity.y += GRAVITY * delta
		#print("nao ta no chao")
	if not is_on_floor() and pulando:
		if direcao == 'dir':
			if $Animacao.frame == 2:
				$Animacao.play("pulo_dir")
				$Animacao.stop()
				$Animacao.frame = 2
			
			
			#if $Animacao.animation == "pulo_dir" and $Animacao.frame == 2:
				#$Animacao.pause()
		if direcao == 'esq':
			if $Animacao.frame == 2:
				$Animacao.play("pulo_esq")
				$Animacao.stop()
				$Animacao.frame = 2
			
			

			#if $Animacao.animation == "pulo_esq" and $Animacao.frame == 2:
				#$Animacao.pause()
	velocity.x = direction_velocity.x * velocidade

	#print(pulando)
	
	
	
	
	move_and_slide()


	

func _on_animacao_animation_looped() -> void:
	if $Animacao.animation == 'ataque_dir' or $Animacao.animation == 'ataque_esq':
		print("terminou o ataque")
		ataque.emit()
