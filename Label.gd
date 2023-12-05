extends Label

var pc: float

@onready var label = get_tree("msgs")

func _ready():
	label.percent_visible = 0.0
	pc = 1.0 / text.length() # percent to add to the label each time the timer times out - with 150 characters this will give you 0.006667 per update, enough for 1 character per update.
	$Timer.start()

func _on_Timer_timeout():
	label.percent_visible += pc
	if label.percent_visible >= 1.0:
		$Timer.stop()
