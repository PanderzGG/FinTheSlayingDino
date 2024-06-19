extends Area2D

@export var baseRange: float = 50
@export var rangeUpgradeStrength = 5
@export var reloadTime: float = 2

var range: float = 0
var upgradeCount: int = 0
var timeElapsed: float = 2
var enemyClass = load("res://Scripts/EnemySmall.gd")

var shape: CircleShape2D

func _ready():
	shape = CircleShape2D.new()
	
	updateRadius()
	$CollisionShape2D.set_shape(shape)
	
	pass # Replace with function body.

func _physics_process(delta):
	timeElapsed += delta
	
	if timeElapsed >= reloadTime:
		var target: Node2D = getTarget()
		
		if target != null:
			target.queue_free()
			upgradeCount += 1
			updateRadius()
			timeElapsed = 0
		
	pass

func updateRadius():
	shape.radius = baseRange + upgradeCount * rangeUpgradeStrength
	pass

func getTarget():
	var overlappingBodies = get_overlapping_bodies()
	var targetNode: Node2D = null
	var closestDistance: float = 0
	
	print(overlappingBodies.size())
	
	for node: Node2D in overlappingBodies:
		var distance = node.global_position.distance_to(global_position)
		
		if (targetNode == null || distance < closestDistance):
			targetNode = node
			closestDistance = distance
	
	return targetNode
