extends KinematicBody2D


var motion = Vector2.ZERO

var Jugador = null


var velocity = 700

func _ready():
	motion = Vector2(0,-1).rotated(rotation)

func _physics_process(delta):
	var velocity_vector = motion * velocity
	move_and_slide(velocity_vector)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Jugador"):
		body.recibir_dano()
		queue_free()
	self.queue_free()

func _on_Area2D_body_exited(body):
	if body == Jugador:
		Jugador = null

