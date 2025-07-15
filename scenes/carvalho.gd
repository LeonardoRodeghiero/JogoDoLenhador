extends Area2D

var hits: int = 3
var player_in_range: bool = false
var ja_entrou: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func caindo():
	var tween = create_tween()
	tween.tween_property($Marker2D, "rotation", deg_to_rad(90), 4).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(5).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	player_in_range = true
	print("entrou")
	if not ja_entrou:
		body.connect("ataque", _on_ataque_recebido)
	ja_entrou = true


func _on_body_exited(_body: Node2D) -> void:
	player_in_range = false

func _on_ataque_recebido():
	if player_in_range:
		print("Jogador atacou dentro da área da árvore!")
		hits -= 1
		if hits <= 0:
			caindo()
			
