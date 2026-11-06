extends CharacterBody2D
const SPEED:int = 100
const KNOCKBACK_FORCE: int = 100
var health: int = 100
var target = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var take_damage_sound: AudioStreamPlayer2D = $TakeDamage

func _physics_process(delta: float) -> void:
	if target:
		_attack(delta)

func _attack(delta: float) -> void:
	var direction = (target.position - position).normalized()
	position += direction * SPEED * delta
	animated_sprite_2d.play("attack")
func take_damage(damage: int, attacker_position: Vector2) -> void:
	health -= damage
	take_damage_sound.play()
	print(health)
	#Knockback
	var knockback_direction = (position - attacker_position).normalized()
	var target_position = position + knockback_direction * KNOCKBACK_FORCE
	var tween = create_tween()
	tween.tween_property(self, "position",target_position, 0.5)
func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		print("Slime detected the "+ body.name)
		print("Slime is targetting "+ target.name)


func _on_sight_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		target = null
		animated_sprite_2d.play("idle")
