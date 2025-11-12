extends KinematicBody2D

var motion = Vector2.ZERO
var velocity = 100

var jugador_cerca = false
var jugador = null
var detenerce = false

func _physics_process(delta):
	motion = Vector2.ZERO
	
	if jugador_cerca == true and detenerce == false:
		motion = position.direction_to(jugador.position)
	
	motion = motion.normalized() * velocity
	
	if motion.length() > 0.1 and $Sprite:
		# Calcula el ángulo hacia donde se mueve
		var angulo = motion.angle() + PI/2 # Ajustá el offset si tu sprite mira hacia arriba 
		
		$Sprite.rotation = angulo
	move_and_slide(motion)

func _on_AreaDeActivacion_body_entered(body):
	if body.is_in_group("Jugador"):
		jugador = body
		jugador_cerca = true
		


func _on_AreaParaDetenerce_body_entered(body):
	if body.is_in_group("Jugador"):
		detenerce = true
		jugador = body
		motion = Vector2.ZERO




func _on_AreaParaDetenerce_body_exited(body):
	if body.is_in_group("Jugador"):
		detenerce = false
