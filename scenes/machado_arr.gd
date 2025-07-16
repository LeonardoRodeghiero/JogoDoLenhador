extends Area2D

var direcao: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direcao = Globals.player.direcao
	if direcao == 'dir':
		$AnimationPlayer.play("girando_dir")
	else:
		$AnimationPlayer.play("girando_esq")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direcao == 'dir':
		position.x += 400 * delta
	else:
		position.x -= 400 * delta
	
	
	


func _on_destroy_timer_timeout() -> void:
	queue_free()
