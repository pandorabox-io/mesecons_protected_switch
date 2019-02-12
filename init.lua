-- mesecons_switch
local has_protector_mod = minetest.get_modpath("protector")

mesecon.register_node("mesecons_protected_switch:mesecon_switch", {
	paramtype2="facedir",
	description="Switch",
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function (pos, node, clicker)
		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end

		if(mesecon.flipstate(pos, node) == "on") then
			mesecon.receptor_on(pos)
		else
			mesecon.receptor_off(pos)
		end
		minetest.sound_play("mesecons_switch", {pos=pos})
	end
},{
	groups = {dig_immediate=2},
	tiles = {	"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_side.png^protector_logo.png",
				"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_side.png^protector_logo.png",
				"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_off.png"},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_side.png^protector_logo.png",
				"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_side.png^protector_logo.png",
				"mesecons_switch_side.png^protector_logo.png", "mesecons_switch_on.png"},
	mesecons = {receptor = { state = mesecon.state.on }}
})

minetest.register_craft({
	output = "mesecons_protected_switch:mesecon_switch",
	recipe = {
		{"mesecons_switch:mesecon_switch_off", "default:steel_ingot"}
	}
})
