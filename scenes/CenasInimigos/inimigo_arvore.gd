extends Inimigo_Template

var direcao
@onready var walking = preload("res://graphics/inimigos/arvore_inimiga/walking.png")
@onready var attacking = preload("res://graphics/inimigos/arvore_inimiga/attacking.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direcao = Vector2.LEFT
	$AnimationPlayer.play("walking")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direcao * 100
	if global_position.x < 200:
		direcao = Vector2.RIGHT
		scale.x = -1
	if global_position.x > 1000:
		direcao = Vector2.LEFT
		scale.x = -1
	move_and_slide()
