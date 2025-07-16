extends Inimigo_Template

var direcao

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direcao = Vector2.LEFT
	scale.x = -1
	$AnimationPlayer.play("flying")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	velocity = direcao * 200
	move_and_slide()
	if global_position.x < 200:
		direcao = Vector2.RIGHT
		scale.x = -1
	if global_position.x > 1000:
		direcao = Vector2.LEFT
		scale.x = -1
