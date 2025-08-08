extends Area2D

var vida: int = 30
var player_in_range: bool = false
var ja_entrou: bool = false
var cair: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player.connect("ataque", _on_ataque_recebido)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#print(self, vida)

func caindo():
	cair = true
	var tween = create_tween()
	tween.tween_property($Marker2D, "rotation", deg_to_rad(-90), 4).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(5).timeout
	queue_free()



func _on_ataque_recebido(dano):
	print(dano)
	if player_in_range:
		print("Jogador atacou dentro da área da árvore!")
		vida -= dano
		if vida == 0:
			$Marker2D/AnimationPlayer.play("cortando")
		if vida <= 0 and not cair:
			caindo()
			


func _on_area_entered(_area: Area2D) -> void:
	player_in_range = true


func _on_area_exited(_area: Area2D) -> void:
	player_in_range = false
