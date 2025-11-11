extends StaticBody2D


func _on_Area_de_impacto_body_entered(body):
	if body.is_in_group("Jugador"):
		print("aya")
		self.queue_free()
