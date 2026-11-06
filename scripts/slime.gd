extends CharacterBody2D


const SPEED = 100.0
var target = null

func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print("Slime detected the "+ body.name)
		print("Slime is targetting "+ target.name)
