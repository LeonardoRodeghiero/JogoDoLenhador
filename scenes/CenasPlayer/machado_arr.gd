extends Area2D

var direcao: String
var direction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direcao = Globals.player.direcao
	if direcao == 'dir':
		direction = Vector2.RIGHT

		$AnimationPlayer.play("girando_dir")
	else:
		direction = Vector2.LEFT

		$AnimationPlayer.play("girando_esq")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * 700 * delta
	
	
	


func _on_destroy_timer_timeout() -> void:
	queue_free()
