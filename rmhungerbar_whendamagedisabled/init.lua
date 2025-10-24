core.register_on_joinplayer(function(player)
    if core.settings:get_bool("enable_damage") then return end

    -- this is the exact code tooken from the hb.hide_hudbar function. Why?
    -- hb.hide_hudbar uses a local function to determine if the player exists or not.
    -- extremely annoying and i doubt that i will need it for this context
    local identifier = "hunger"
	local name = player:get_player_name()
	local hudtable = hb.get_hudtable(identifier)
	if hudtable == nil then return false end
	if hudtable.hudstate[name].hidden == true then return true end
	if hb.settings.bar_type == "progress_bar" then
		if hudtable.hudids[name].icon then
			player:hud_change(hudtable.hudids[name].icon, "scale", {x=0,y=0})
		end
		player:hud_change(hudtable.hudids[name].bg, "scale", {x=0,y=0})
		player:hud_change(hudtable.hudids[name].text, "text", "")
	end
	player:hud_change(hudtable.hudids[name].bar, "number", 0)
	player:hud_change(hudtable.hudids[name].bar, "item", 0)
	hudtable.hudstate[name].hidden = true
	
	mcl_hunger.set_active(false)
	return true
end)