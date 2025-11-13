extends KinematicBody2D

export var velocity := 700
var motion := Vector2.ZERO
const ROTATION_CORRECTION := PI/2  

func _ready():
	pass

func set_direccion(dir: Vector2):
	motion = dir.normalized()
	rotation = motion.angle() + ROTATION_CORRECTION

func _physics_process(delta):
	if motion == Vector2.ZERO:
		return

	# desplazamiento para este frame (move_and_collide espera un desplazamiento en px para este frame)
	var displacement = motion * velocity * delta
	var collision = move_and_collide(displacement)
	if collision:
		queue_free()


func _on_zona_colicion_body_entered(body): #Con esta area detecta y resta las vidas con cada disparo
	if body.is_in_group("enemigo"):
		body.recibir_dano()
		queue_free()
	pass # Replace with function body.
