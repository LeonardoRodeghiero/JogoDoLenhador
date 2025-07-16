extends Inimigo_Template

var direcao
var player_in_range: bool = false

@onready var walking = preload("res://graphics/inimigos/arvore_inimiga/walking.png")
@onready var attacking = preload("res://graphics/inimigos/arvore_inimiga/attacking.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player.connect("ataque", _on_ataque_recebido)
	vida = 50
	barraVida.max_value = vida
	barraVida.value = vida
	
	direcao = Vector2.LEFT
	$AnimationPlayer.play("walking")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	atualizar_area_ataque()
	barraVida.value = vida
	if $AnimationPlayer.current_animation == "walking":
		velocity = direcao * 100
		move_and_slide()
	if global_position.x < 200:
		direcao = Vector2.RIGHT
		scale.x = -1
		$BarraVida.scale.x = -1
		
	if global_position.x > 1000:
		direcao = Vector2.LEFT
		scale.x = -1
		$BarraVida.scale.x = 1
		

	

func atualizar_area_ataque():
	$AttackArea.position.x = -15
	
func attack():
	Globals.vida -= 10
	

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body == Globals.player:
		player_in_range = true
		$AnimationPlayer.play("attacking")


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == Globals.player:
		player_in_range = false
		$AnimationPlayer.play("walking")


func _on_ataque_recebido(dano):
	vida -= dano
	if vida <= 0:
		queue_free()
