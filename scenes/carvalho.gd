extends Area2D

var hits: int = 3
var player_in_range: bool = false
var ja_entrou: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player.connect("ataque", _on_ataque_recebido)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func caindo():
	var tween = create_tween()
	tween.tween_property($Marker2D, "rotation", deg_to_rad(-90), 4).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(5).timeout
	queue_free()



func _on_ataque_recebido():
	if player_in_range:
		print("Jogador atacou dentro da área da árvore!")
		hits -= 1
		print(hits)
		if hits == 0:
			$Marker2D/AnimationPlayer.play("cortando")
		if hits <= 0:
			caindo()
			


func _on_area_entered(area: Area2D) -> void:
	player_in_range = true


func _on_area_exited(area: Area2D) -> void:
	player_in_range = false
