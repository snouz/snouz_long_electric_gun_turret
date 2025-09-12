if data.raw["ammo-turret"]["snouz_long_electric_gun_turret"] then
  for _, tech in pairs(data.raw["technology"]) do
    if tech.name and string.find(tech.name, "physical%-projectile%-damage") and tech.effects then
      local modifier = 0
      for _, effec in pairs(tech.effects) do
        if effec.type == "turret-attack" and effec.modifier then
          modifier = effec.modifier
        end
      end
      table.insert(tech.effects, 
      {
        type = "turret-attack",
        turret_id = "snouz_long_electric_gun_turret",
        modifier = modifier,
      })
    end
  end
end
