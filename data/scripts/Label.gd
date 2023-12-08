extends Label

var text1 := "BOOT: Dumping boot logs...
	MACHINE_ID: K0 (0x4b2d30312d50)
	BOOT_TYPE: 003 (EXTERNAL_EMERGENCY_FORCE)
	BOOT_TIME: 0000-00-05T15:46:09+00:00
	BOOT_LOGS:
		...
		0000-00-05T12:14:29+23:15 External power: LOW
		0000-00-05T15:37:03+03:27 External power reserves depleted.
		0000-00-05T15:52:05+12:05 Initializing Emergency Startup
		...
BOOT: Handing off to BIOS...
PRESS ENTER TO CONTINUE
"

var text2 := "Loading initial ramdisk...
ACPI: FACS 0x00000000D9F60F80 000040
ACPI: DSDT 0x00000000D9F60C40 00393F (v02 OVERTR-K0   00000002 OVERTR-K0 20181115)
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
e820: last_pfn = 0x9f800 max_arch_pfn = 0x400000000
Detected hardware: OVERTR-K0, CPU: OVERTR-Xk(7) @ 3.60GHz
RAMDISK: [mem 0x365a7000-0x3727bfff]
ACPI: Early table checksum verification disabled
ACPI: XSDT 0x00000000D9F60DE8 0000E4 (v01 00000002 OVERTR-K0 20181115)
efi: TPMFinalLog=0x9f4e1000 ACPI 2.0=0xd9f7b000 ACPI=0xd9f7b000 TPMEventLog=0xd9f52000
BIOS-provided physical RAM map:
 BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
 BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reserved
 ...

BOOT: Ok

PRESS ENTER TO CONTINUE
"
var text3 := "
 NX (Execute Disable) protection: active
CORE: 257 devices found (7 groups). Connecting...

  COL_V: OK
  INF_V: OK
  AUDIO: OK
  MOTOR: OK
  BIO:   OK
  IPU:   OK
  MEM:   OK

CORE: Psychointegrity verification check: enabled
CORE: Checking whether boot environment
 is sane... OK
CORE: Checking for callibration profile... Found
CORE: Using callibration profile: latest
CORE: Ready

PRESS ENTER TO CONTINUE
"

var typing_speed := 0.001  # Adjust the speed of typing

var current_text: String = ""
var typing_timer: float = 0.0
var done := false
var stage := 0
var glitch_vis = false

signal keypressed
signal finished
signal hudvis

func clear():
	text = ""

func _ready():
	var g = get_parent().get_node("CanvasLayer/glitch")
	g.visible = false
	# Initialize the label with an empty text
	text = ""

func flicker():
	var g = get_parent().get_node("CanvasLayer/glitch")
	var bg = get_parent().get_node("ColorRect")
	bg.visible = false
	g.visible = false
	await get_tree().create_timer(0.1).timeout
	bg.visible = true
	g.visible = true
	await get_tree().create_timer(0.05).timeout
	bg.visible = false
	g.visible = false
	await get_tree().create_timer(0.005).timeout
	bg.visible = true
	g.visible = true
	await get_tree().create_timer(0.005).timeout
	bg.visible = false
	g.visible = false

func write_typewriter(item: String):
	typing_timer += 0.1
	if typing_timer >= typing_speed:
		typing_timer = 0.0
		# Add one character to the displayed text
		current_text = item.left(current_text.length() + 1)
		text = current_text

func check():
	if Input.is_action_just_pressed("ui_enter"):
		keypressed.emit()
		stage += 1

func _process(_delta):
	await _on_player_ready()
	if stage == 0:
		await write_typewriter(text1)
		check()
		await keypressed
	elif stage == 1:
		await write_typewriter(text2)
		check()
		await keypressed
	elif stage == 2:
		flicker()
		await write_typewriter(text3)
		check()
		await keypressed
		hudvis.emit()
	elif stage == 3:
		var g = get_parent().get_node("CanvasLayer/glitch")
		var bg = get_parent().get_node("ColorRect")
		bg.visible = false
		g.visible = false
		visible = false
		finished.emit()
		queue_free()
		

func _on_player_ready():
	pass # Replace with function body.
