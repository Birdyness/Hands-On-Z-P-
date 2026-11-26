extends Node2D
#ENTITIES
const _1___THE_CONE_MAN = preload("res://Assets/Guidebook/Entities/1 - The Cone Man.png")
const _2___AETHERAX = preload("res://Assets/Guidebook/Entities/2 - Aetherax.png")
const _3___GNAWING_GNOME = preload("res://Assets/Guidebook/Entities/3 - Gnawing Gnome.png")
const _4___FROGMAN = preload("res://Assets/Guidebook/Entities/4 - Frogman.png")
const _5___CHUPPACABRA = preload("res://Assets/Guidebook/Entities/5 - Chuppacabra.png")
const _6___MOMMY = preload("res://Assets/Guidebook/Entities/6 - Mommy.png")
const _7___VAMPIERRE = preload("res://Assets/Guidebook/Entities/7 - Vampierre.png")
const _8___ABELLA = preload("res://Assets/Guidebook/Entities/8 - Abella.png")
const _9___SYLCLOP = preload("res://Assets/Guidebook/Entities/9 - Sylclop.png")
const _10___THE_HERMIT = preload("res://Assets/Guidebook/Entities/10 - The Hermit.png")
const _11___MARAVAS = preload("res://Assets/Guidebook/Entities/11 - Maravas.png")
const _12___AGAROSE = preload("res://Assets/Guidebook/Entities/12 - Agarose.png")
const _13___BHAEL = preload("res://Assets/Guidebook/Entities/13 - Bhael.png")

#TOOLS
const _1___ANALOG_RADIO = preload("res://Assets/Guidebook/Tools/1 - Analog Radio.png")
const _2___TEMPERATURE_SCANNER = preload("res://Assets/Guidebook/Tools/2 - Temperature Scanner.png")
const _3___PLANTATION = preload("res://Assets/Guidebook/Tools/3 - Plantation.png")
const _4___METAL_DETECTOR = preload("res://Assets/Guidebook/Tools/4 - Metal Detector.png")
const _5___EXECUTION_PANEL_PAGE_1 = preload("res://Assets/Guidebook/Tools/5 - Execution Panel Page 1.png")
const _5___EXECUTION_PANEL_PAGE_2 = preload("res://Assets/Guidebook/Tools/5 - Execution Panel Page 2.png")

#TRAITS
const _1___IN_BAND_INTERFERENCE = preload("res://Assets/Guidebook/Traits/1 - In-Band Interference.png")
const _2___BLOOD_TEMPERATURE = preload("res://Assets/Guidebook/Traits/2 - Blood Temperature.png")
const _3___PLANT_GROWTH = preload("res://Assets/Guidebook/Traits/3 - Plant Growth.png")
const _4___METAL_TRAITS = preload("res://Assets/Guidebook/Traits/4 - Metal Traits.png")

#BOOK PAGE
@onready var display: Sprite2D = $BookBase

#TAB GROUPS
@onready var entities_labels: CanvasItem = $"Entities Labels"
@onready var entity_buttons: CanvasItem = $"Entity Buttons"
@onready var tools_labels: CanvasItem = $"Tools Labels"
@onready var tools_buttons: CanvasItem = $"Tools Buttons"
@onready var traits_labels: CanvasItem = $"Traits Labels"
@onready var traits_buttons: CanvasItem = $"Traits Buttons"

#ENTITY LABELS
@onready var cone_man: Sprite2D = $"Entities Labels/Cone Man"
@onready var aetherax: Sprite2D = $"Entities Labels/Aetherax"
@onready var frogman: Sprite2D = $"Entities Labels/Frogman"
@onready var mommy: Sprite2D = $"Entities Labels/Mommy"
@onready var chupacabra: Sprite2D = $"Entities Labels/Chupacabra"
@onready var abella: Sprite2D = $"Entities Labels/Abella"
@onready var vampierre: Sprite2D = $"Entities Labels/Vampierre"
@onready var sylclop: Sprite2D = $"Entities Labels/Sylclop"
@onready var the_hermit: Sprite2D = $"Entities Labels/The Hermit"
@onready var gnawing_gnome: Sprite2D = $"Entities Labels/Gnawing Gnome"
@onready var maravas: Sprite2D = $"Entities Labels/Maravas"
@onready var agarose: Sprite2D = $"Entities Labels/Agarose"
@onready var bhael: Sprite2D = $"Entities Labels/Bhael"

#TOOLS LABELS
@onready var analog: Sprite2D = $"Tools Labels/Analog"
@onready var temperature_scanner: Sprite2D = $"Tools Labels/TemperatureScanner"
@onready var plantation: Sprite2D = $"Tools Labels/Plantation"
@onready var metal_detector: Sprite2D = $"Tools Labels/MetalDetector"
@onready var execution_panel: Sprite2D = $"Tools Labels/ExecutionPanel"
@onready var switch_page: Sprite2D = $"Tools Labels/SwitchPage"


#TRAITS LABELS
@onready var in_band_interference: Sprite2D = $"Traits Labels/In-Band Interference"
@onready var blood_temperature: Sprite2D = $"Traits Labels/Blood Temperature"
@onready var plant_growth: Sprite2D = $"Traits Labels/Plant Growth"
@onready var text_4_metal_traits: Sprite2D = $"Traits Labels/Metal Traits"

#TABS BUTTONS
@onready var tools: Button = $Tabs/Tools
@onready var traits: Button = $Tabs/Traits
@onready var entities: Button = $Tabs/Entities

@onready var guidebook: Node2D = $"../guidebook"
var tween: Tween
signal close_book

func _ready() -> void:
	global_position = Vector2(668.0, 1036.0)
	guidebook.book_open.connect(open_book)
	
	
	show_entities()
	tools.position = Vector2(271.0, -140.0)
	traits.position = Vector2(281.0, 211.0)
	entities.position = Vector2(-542.0, -205.0)


func open_book():
	if tween:
			tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "global_position", Vector2(663.0, 277.0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

#HOVER
func hover(node: CanvasItem) -> void:
	node.self_modulate = Color(7.206, 7.206, 7.206, 0.671)


func unhover(node: CanvasItem) -> void:
	node.self_modulate = Color(1, 1, 1, 1)


#SWITCH PAGE SPRITE
# Only visible while the book is showing Execution Panel Page 1 or Page 2
func update_switch_page() -> void:
	switch_page.visible = display.texture == _5___EXECUTION_PANEL_PAGE_1 or display.texture == _5___EXECUTION_PANEL_PAGE_2


#TAB SWITCHING
func set_group(group: CanvasItem, on: bool) -> void:
	group.visible = on
	group.process_mode = Node.PROCESS_MODE_INHERIT if on else Node.PROCESS_MODE_DISABLED


func show_entities() -> void:
	set_group(entities_labels, true)
	set_group(entity_buttons, true)
	set_group(tools_labels, false)
	set_group(tools_buttons, false)
	set_group(traits_labels, false)
	set_group(traits_buttons, false)
	display.texture = _1___THE_CONE_MAN
	update_switch_page()


func show_tools() -> void:
	set_group(entities_labels, false)
	set_group(entity_buttons, false)
	set_group(tools_labels, true)
	set_group(tools_buttons, true)
	set_group(traits_labels, false)
	set_group(traits_buttons, false)
	display.texture = _1___ANALOG_RADIO
	update_switch_page()


func show_traits() -> void:
	set_group(entities_labels, false)
	set_group(entity_buttons, false)
	set_group(tools_labels, false)
	set_group(tools_buttons, false)
	set_group(traits_labels, true)
	set_group(traits_buttons, true)
	display.texture = _1___IN_BAND_INTERFERENCE
	update_switch_page()


#TABS
func _on_tools_pressed() -> void:
	show_tools()
	tools.position = Vector2(-540.0, -141.0)
	traits.position = Vector2(281.0, 211.0)
	entities.position = Vector2(268.0, -203.0)

func _on_traits_pressed() -> void:
	show_traits()
	tools.position = Vector2(271.0, -140.0)
	traits.position = Vector2(-536.0, 211.0)
	entities.position = Vector2(268.0, -203.0)

func _on_entities_pressed() -> void:
	show_entities()
	tools.position = Vector2(271.0, -140.0)
	traits.position = Vector2(281.0, 211.0)
	entities.position = Vector2(-542.0, -205.0)

#ENTITIES
func _on_cone_man_mouse_entered() -> void:
	hover(cone_man)


func _on_cone_man_mouse_exited() -> void:
	unhover(cone_man)


func _on_cone_man_pressed() -> void:
	display.texture = _1___THE_CONE_MAN
	update_switch_page()


func _on_aetherax_mouse_entered() -> void:
	hover(aetherax)


func _on_aetherax_mouse_exited() -> void:
	unhover(aetherax)


func _on_aetherax_pressed() -> void:
	display.texture = _2___AETHERAX
	update_switch_page()


func _on_gnawing_gnome_mouse_entered() -> void:
	hover(gnawing_gnome)


func _on_gnawing_gnome_mouse_exited() -> void:
	unhover(gnawing_gnome)


func _on_gnawing_gnome_pressed() -> void:
	display.texture = _3___GNAWING_GNOME
	update_switch_page()


func _on_frogman_mouse_entered() -> void:
	hover(frogman)


func _on_frogman_mouse_exited() -> void:
	unhover(frogman)


func _on_frogman_pressed() -> void:
	display.texture = _4___FROGMAN
	update_switch_page()


func _on_chupacabra_mouse_entered() -> void:
	hover(chupacabra)


func _on_chupacabra_mouse_exited() -> void:
	unhover(chupacabra)


func _on_chupacabra_pressed() -> void:
	display.texture = _5___CHUPPACABRA
	update_switch_page()


func _on_mommy_mouse_entered() -> void:
	hover(mommy)


func _on_mommy_mouse_exited() -> void:
	unhover(mommy)


func _on_mommy_pressed() -> void:
	display.texture = _6___MOMMY
	update_switch_page()


func _on_vampierre_mouse_entered() -> void:
	hover(vampierre)


func _on_vampierre_mouse_exited() -> void:
	unhover(vampierre)


func _on_vampierre_pressed() -> void:
	display.texture = _7___VAMPIERRE
	update_switch_page()


func _on_abella_mouse_entered() -> void:
	hover(abella)


func _on_abella_mouse_exited() -> void:
	unhover(abella)


func _on_abella_pressed() -> void:
	display.texture = _8___ABELLA
	update_switch_page()


func _on_sylclop_mouse_entered() -> void:
	hover(sylclop)


func _on_sylclop_mouse_exited() -> void:
	unhover(sylclop)


func _on_sylclop_pressed() -> void:
	display.texture = _9___SYLCLOP
	update_switch_page()


func _on_the_hermit_mouse_entered() -> void:
	hover(the_hermit)


func _on_the_hermit_mouse_exited() -> void:
	unhover(the_hermit)


func _on_the_hermit_pressed() -> void:
	display.texture = _10___THE_HERMIT
	update_switch_page()


func _on_maravas_mouse_entered() -> void:
	hover(maravas)


func _on_maravas_mouse_exited() -> void:
	unhover(maravas)


func _on_maravas_pressed() -> void:
	display.texture = _11___MARAVAS
	update_switch_page()


func _on_agarose_mouse_entered() -> void:
	hover(agarose)


func _on_agarose_mouse_exited() -> void:
	unhover(agarose)


func _on_agarose_pressed() -> void:
	display.texture = _12___AGAROSE
	update_switch_page()


func _on_bhael_mouse_entered() -> void:
	hover(bhael)


func _on_bhael_mouse_exited() -> void:
	unhover(bhael)


func _on_bhael_pressed() -> void:
	display.texture = _13___BHAEL
	update_switch_page()


#TOOLS
func _on_analog_radio_mouse_entered() -> void:
	hover(analog)


func _on_analog_radio_mouse_exited() -> void:
	unhover(analog)


func _on_analog_radio_pressed() -> void:
	display.texture = _1___ANALOG_RADIO
	update_switch_page()


func _on_temperature_scanner_mouse_entered() -> void:
	hover(temperature_scanner)


func _on_temperature_scanner_mouse_exited() -> void:
	unhover(temperature_scanner)


func _on_temperature_scanner_pressed() -> void:
	display.texture = _2___TEMPERATURE_SCANNER
	update_switch_page()


func _on_plantation_mouse_entered() -> void:
	hover(plantation)


func _on_plantation_mouse_exited() -> void:
	unhover(plantation)


func _on_plantation_pressed() -> void:
	display.texture = _3___PLANTATION
	update_switch_page()


func _on_metal_detector_mouse_entered() -> void:
	hover(metal_detector)


func _on_metal_detector_mouse_exited() -> void:
	unhover(metal_detector)


func _on_metal_detector_pressed() -> void:
	display.texture = _4___METAL_DETECTOR
	update_switch_page()


func _on_execution_panel_mouse_entered() -> void:
	hover(execution_panel)


func _on_execution_panel_mouse_exited() -> void:
	unhover(execution_panel)


func _on_execution_panel_pressed() -> void:
	display.texture = _5___EXECUTION_PANEL_PAGE_1
	update_switch_page()


#TRAITS
func _on_in_band_interference_mouse_entered() -> void:
	hover(in_band_interference)


func _on_in_band_interference_mouse_exited() -> void:
	unhover(in_band_interference)


func _on_in_band_interference_pressed() -> void:
	display.texture = _1___IN_BAND_INTERFERENCE
	update_switch_page()


func _on_blood_temperature_mouse_entered() -> void:
	hover(blood_temperature)


func _on_blood_temperature_mouse_exited() -> void:
	unhover(blood_temperature)


func _on_blood_temperature_pressed() -> void:
	display.texture = _2___BLOOD_TEMPERATURE
	update_switch_page()


func _on_plant_growth_mouse_entered() -> void:
	hover(plant_growth)


func _on_plant_growth_mouse_exited() -> void:
	unhover(plant_growth)


func _on_plant_growth_pressed() -> void:
	display.texture = _3___PLANT_GROWTH
	update_switch_page()


func _on_metal_traits_mouse_entered() -> void:
	hover(text_4_metal_traits)


func _on_metal_traits_mouse_exited() -> void:
	unhover(text_4_metal_traits)


func _on_metal_traits_pressed() -> void:
	display.texture = _4___METAL_TRAITS
	update_switch_page()



#SWITCH PAGE BUTTON (Execution Panel Page 1 <-> Page 2)
func _on_ex_3_cution_mouse_entered() -> void:
	hover(switch_page)


func _on_ex_3_cution_mouse_exited() -> void:
	unhover(switch_page)


func _on_ex_3_cution_pressed() -> void:
	if display.texture == _5___EXECUTION_PANEL_PAGE_1:
		display.texture = _5___EXECUTION_PANEL_PAGE_2
	elif display.texture == _5___EXECUTION_PANEL_PAGE_2:
		display.texture = _5___EXECUTION_PANEL_PAGE_1
	update_switch_page()



func _on_back_button_pressed() -> void:
	close_book.emit()
	if tween:
			tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "global_position", Vector2(668.0, 1036.0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
