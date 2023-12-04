extends Node2D

@onready var parts = {
	"health": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D/health_human,
	"ability": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D2/ability,
	"shield": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D/health_machine,
	"ammo": $CanvasLayer/SubViewportContainer/SubViewport/Camera3D/Hud/Node3D2/ammo
}

@onready var player_vars = get_node("/root/PlayerVars")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func draw_bar(property: int, bar, symbol: String, reversed: bool):
	if reversed:
			if property <= 5:
				var abilityBar = symbol
				abilityBar += " ["
				for i in range(property):
					abilityBar += "="
				for i in range(5 - property):
					abilityBar += " "
				abilityBar += "]"
				bar.text = abilityBar
	else:
		if property <= 5:
			var abilityBar = "["
			for i in range(property):
				abilityBar += "="
			for i in range(5 - property):
				abilityBar += " "
			abilityBar += "] "
			abilityBar += symbol
			bar.text = abilityBar


func updateHUD():
	# Update labelAbility text
	# Update labelAbility text
	 # Update labelAbility text
	draw_bar(PlayerVars.ability, parts.ability, "!", true)
	draw_bar(PlayerVars.health, parts.health, "*", false)
	draw_bar(PlayerVars.shield, parts.shield, "+", false)
	draw_bar(PlayerVars.ammo, parts.ammo, "x", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	updateHUD()
