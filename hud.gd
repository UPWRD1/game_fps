extends Node2D

@onready var parts = {
	"health": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D/health,
	"stamina": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D/stamina,
}

@onready var player_vars = get_node("/root/PlayerVars")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateHUD():
	# Update labelAbility text
	# Update labelAbility text
	 # Update labelAbility text
	if PlayerVars.ability <= 5:
		var abilityBar = "! ["
		for i in range(PlayerVars.ability):
			abilityBar += "="
		for i in range(5 - PlayerVars.ability):
			abilityBar += " "
		abilityBar += "]"

		parts.stamina.text = abilityBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateHUD()
