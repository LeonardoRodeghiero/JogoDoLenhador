extends CharacterBody2D

enum Estado { CORRENDO, ATACANDO, PULANDO }
var estado_atual
var direcao: String

var velocidade: int = 400
var parado: bool = false
var terminou_ataque: bool = false
var dano_ataque_fisico: int = 10
var dano_longo_alcance: int = 10

# PULO
const GRAVITY = 980
const PULO = -750
var pulando: bool = false
var fall_multiplier = 2.5

const COYOTE_TIME = 0.1 # segundos
var coyote_timer = 0

const JUMP_BUFFER_TIME = 0.1 
var jump_buffer_timer = 0



var machado_scene: PackedScene = preload("res://scenes/CenasPlayer/machado_arr.tscn")
var pode_arremessar: bool = true
var arremessando: bool = false

var pode_dash: bool = true



signal ataque(dano)
signal arremessavel()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = self
	$Animacao.play("correr")
	direcao = 'dir'
	$Animacao.stop()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction_velocity:Vector2
	
	if direcao == "dir":
		$Animacao.flip_h = false
		$AttackArea.position.x = 15
		
		
	elif direcao == "esq":
		$Animacao.flip_h = true
		$AttackArea.position.x = -15
		
	if Input.is_action_pressed("arremessavel") and $Animacao.animation not in ['ataque']:
		if pode_arremessar:
			$Animacao.play("arremesso")
			arremessavel.emit()
			$Timers/ArremessavelTimer.start()
			pode_arremessar = false
		
	# Vou deixar o dash (por enquanto), mas nao pretendo fazer	
	#if Input.is_action_pressed("dash") and pode_dash:
		#pode_dash = false
		#$Animacao.play("dash_dir")
		#$Timers/DashTimer.start()
	
	if Input.is_action_pressed("esquerda") and Input.is_action_pressed("direita") and $Animacao.animation not in ['ataque', 'pulo']:
		$Animacao.play("rest")
		parado = true
	elif Input.is_action_pressed("direita") and $Animacao.animation not in ['ataque']:
		direction_velocity.x = 1
		direcao = "dir"
		parado = false
	elif Input.is_action_pressed("esquerda") and $Animacao.animation not in ['ataque']:
		direction_velocity.x = -1
		direcao = "esq"
		parado = false
	
	if is_on_floor():
		pulando = false
		
			
		
			#print("ta no chao")
		if Input.is_action_pressed("ataque"):
			
			iniciar_ataque("ataque")
			
		
			
			
		elif (Input.is_action_pressed("direita") or Input.is_action_pressed("esquerda")) and not parado and not pulando:
			$Animacao.play("correr")
		
		
		
		elif not Input.is_action_pressed("direita") and not  Input.is_action_pressed("esquerda") and not Input.is_action_pressed("arremessavel") and not Input.is_action_pressed("pulo") and not Input.is_action_pressed("ataque"):
			
			$Animacao.play("rest")
			
				
	if is_on_floor():
		if not Input.is_action_pressed("direita") and not Input.is_action_pressed("esquerda") and not Input.is_action_pressed("ataque") and not Input.is_action_pressed("arremessavel"):
			$Animacao.play("rest")

		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta
		
	
		
	if Input.is_action_just_pressed("pulo"):
		jump_buffer_timer = JUMP_BUFFER_TIME
		pulando = true
		$Animacao.play("pulo")
		
			
	else:
		jump_buffer_timer -= delta
	
	if coyote_timer > 0 and jump_buffer_timer > 0:
		velocity.y = PULO
		coyote_timer = 0
		jump_buffer_timer = 0
	if not is_on_floor() and pulando:
		
		if $Animacao.frame == 2:
			$Animacao.play("pulo")
			$Animacao.stop()
			$Animacao.frame = 2
			
	velocity.y += GRAVITY * fall_multiplier * delta

	velocity.x = direction_velocity.x * velocidade
	
	
	
	move_and_slide()

func iniciar_ataque(animacao):
	terminou_ataque = false
	$Animacao.play(animacao)
	


	
	
func _on_animacao_animation_looped() -> void:
	if $Animacao.animation == 'ataque':
		print(dano_ataque_fisico)
		terminou_ataque = true
		print("sinal de ataque emitido")
		ataque.emit(dano_ataque_fisico)


func _on_arremessavel() -> void:
	#print("arremessou no y ", pos, direcao)
	var machado = machado_scene.instantiate() as Area2D
	machado.position = self.position

	$"../Arremessaveis".add_child(machado)


func _on_arremessavel_timer_timeout() -> void:
	pode_arremessar = true


func _on_dash_timer_timeout() -> void:
	pode_dash = true
