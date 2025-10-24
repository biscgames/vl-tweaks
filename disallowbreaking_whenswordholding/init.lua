core.register_on_mods_loaded(function()
	local normal_node_dig = core.node_dig
	function core.node_dig(pos,node,plr)
		if not plr:is_player() then return false end
		if core.get_item_group(plr:get_wielded_item():get_name(),"sword") == 1 and core.is_creative_enabled(plr:get_player_name()) then
			return false
		end
		return normal_node_dig(pos,node,plr)
	end
end)