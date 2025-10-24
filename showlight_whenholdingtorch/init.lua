local light_source = "showlight_whenholdingtorch:player_lightsource"
core.register_node(light_source,{
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    light_source = core.LIGHT_MAX,
    groups = {not_in_creative_inventory=1}
})
local tick = 0
core.register_globalstep(function(dt)
    tick = tick + dt
    if tick < 0.1 then return end
    tick = 0
    for _,plr in ipairs(core.get_connected_players()) do
        local itemdef = (core.registered_nodes[plr:get_wielded_item():get_name()] or {paramtype=""})
        local under = vector.subtract(vector.round(plr:get_pos()),{x=0,y=-1,z=0})
        for dx=-1,1 do for dy=-1,1 do for dz=-1,1 do
            local test = vector.add(under,{x=dx,y=dy,z=dz})
            if core.get_node(test).name == light_source then
                core.set_node(test,{name="air"})
            end
        end end end
        if itemdef.paramtype == "light" then
            local n = core.get_node(under)
            if n.name == "air" then
                core.set_node(under,{name=light_source})
            end
        end
    end
end)