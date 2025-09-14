
local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")

local graphics = "__snouz_long_electric_gun_turret__/graphics"
local ENTITYPATH = graphics .. "/entity/"

if data.raw["ammo-turret"]["gun-turret"] then

  data:extend(
  {
    {
      type = "item",
      name = "snouz_long_electric_gun_turret",
      icon = graphics .. "/icons/snouz_long_electric_gun_turret.png",
      subgroup = "turret",
      order = "b[turret]-az[gun-turret]",
      inventory_move_sound = item_sounds.turret_inventory_move,
      pick_sound = item_sounds.turret_inventory_pickup,
      drop_sound = item_sounds.turret_inventory_move,
      place_result = "snouz_long_electric_gun_turret",
      default_import_location = "fulgora",
      stack_size = 50,
      weight = 20 * kg
    },

    {
      type = "recipe",
      name = "snouz_long_electric_gun_turret",
      icon = graphics .. "/icons/snouz_long_electric_gun_turret.png",
      category = "electromagnetics",
      always_show_made_in = true,
      energy_required = 16,
      enabled = false,
      allow_productivity = false,
      ingredients =
      {
        {type = "item", name = "gun-turret", amount = 2},
        {type = "item", name = "supercapacitor", amount = 1},
        {type = "item", name = "radar", amount = 1},
        {type = "item", name = "tungsten-carbide", amount = 1},
      },
      results = {
        {type = "item", name = "snouz_long_electric_gun_turret", amount = 1},
      },
      --crafting_machine_tint =
      --{
      --  primary = {r = 0.460, g = 0.188, b = 0.649, a = 1.000}, -- #752fa5ff
      --  secondary = {r = 0.489, g = 0.484, b = 0.381, a = 1.000}, -- #7c7b61ff
      --  tertiary = {r = 0.196, g = 0.101, b = 0.101, a = 1.000}, -- #311919ff
      --  quaternary = {r = 0.518, g = 0.539, b = 0.993, a = 1.000}, -- #8489fdff
      --}
    },

    {
      type = "technology",
      name = "snouz_long_electric_gun_turret",
      icon = graphics .. "/technology/snouz_long_electric_gun_turret.png",
      icon_size = 256,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "snouz_long_electric_gun_turret"
        }
      },
      prerequisites = {"tungsten-carbide", "electromagnetic-plant"},
      unit =
      {
        count = 2000,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"military-science-pack", 1},
          {"chemical-science-pack", 1},
          --{"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1},
          {"metallurgic-science-pack", 1},
          {"electromagnetic-science-pack", 1},
          --{"agricultural-science-pack", 1},
          --{"cryogenic-science-pack", 1},
          --{"promethium-science-pack", 1}
          
        },
        time = 60
      },
    },
  })
 


  local gun_turret = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])


  gun_turret.name = "snouz_long_electric_gun_turret"
  gun_turret.icon = graphics .. "/icons/snouz_long_electric_gun_turret.png"
  gun_turret.minable = {mining_time = 0.5, result = "snouz_long_electric_gun_turret"}

  gun_turret.max_health = 500 --400
  gun_turret.attacking_speed = 0.9 --0.5

  gun_turret.turret_base_has_rotation = true
  gun_turret.collision_box = {{-0.71, -0.7}, {0.71, 0.7}}
  gun_turret.fast_replaceable_group = "snouz_long_electric_gun_turret"
  gun_turret.next_upgrade = nil
  
  gun_turret.graphics_set =
  {
    base_visualisation =
    {
      {
        --draw_when_has_energy = true,
        draw_when_no_energy = false,
        draw_when_no_ammo = false,
        render_layer = "object",
        animation =
        {
          layers =
          {
            {
              filename = ENTITYPATH .. "gun-turret/gun-turret-base-glow.png",
              priority = "high",
              width = 158,
              height = 158,
              --shift = util.by_pixel(0.5, -1),
              scale = 0.5,
              draw_as_glow = true,
              blend_mode = "additive",
            },
          }
        }
      },
      {
        --draw_when_has_energy = true,
        --draw_when_no_energy = false,
        draw_when_no_energy = false,
        draw_when_has_ammo = false,
        render_layer = "object",
        animation =
        {
          layers =
          {
            {
              filename = ENTITYPATH .. "gun-turret/gun-turret-base-glow-noammo.png",
              priority = "high",
              width = 158,
              height = 158,
              --shift = util.by_pixel(0.5, -1),
              scale = 0.5,
              draw_as_glow = true,
              blend_mode = "additive",
            },
          }
        }
      },
      {
        animation =
        {
          layers =
          {
            {
              filename = ENTITYPATH .. "gun-turret/gun-turret-base.png",
              priority = "high",
              width = 158,
              height = 158,
              --shift = util.by_pixel(0.5, -1),
              scale = 0.5
            },
            --[[{
              filename = ENTITYPATH .. "gun-turret/gun-turret-base-shadow.png",
              priority = "high",
              width = 158,
              height = 158,
              --shift = util.by_pixel(0.5, -1),
              scale = 0.5,
              draw_as_shadow = true,
            },]]
            {
              filename = ENTITYPATH .. "gun-turret/gun-turret-base-mask.png",
              flags = {"mask", "low-object"},
              --line_length = 1,
              width = 158,
              height = 158,
              --shift = util.by_pixel(0, -4.5),
              apply_runtime_tint = true,
              scale = 0.5
            }
          }
        }
      },
    }
  }

  gun_turret.attack_parameters.range = 36 --18
  gun_turret.attack_parameters.turn_range = 0.25 --1
  gun_turret.attack_parameters.cooldown = 3 --6
  gun_turret.attack_parameters.projectile_creation_distance = 1.85 --1.39375,
  gun_turret.automated_ammo_count = 15 --10,
  --gun_turretturret_base_has_direction = true
  gun_turret.attack_parameters.sound = {
    variations = sound_variations("__snouz_long_electric_gun_turret__/sound/shot", 16, 0.4, {volume_multiplier("main-menu", 0.9), volume_multiplier("space-platform", 0.5)}),
    aggregation = {max_count = 8, remove = true, count_already_playing = true, priority = "newest"}
  }

  gun_turret.connection_points = {
    {
      shadow = {
        copper = {0.7, -0.3},
        green = {0.7, -0.3},
        red = {0.7, -0.3}
      },
      wire = {
        copper = {0.5, -0.5},
        green = {0.5, -0.5},
        red = {0.5, -0.5}
      }
    }
  }

  gun_turret.circuit_wire_max_distance = 9
  gun_turret.circuit_connector_sprites = data.raw["electric-pole"]["small-electric-pole"].circuit_connector_sprites
  gun_turret.circuit_wire_connection_point = {
    shadow = {
      copper = {0.7, -0.3},
      green = {0.7, -0.3},
      red = {0.7, -0.3}
    },
    wire = {
      copper = {0.5, -0.5},
      green = {0.5, -0.5},
      red = {0.5, -0.5}
    }
  }
  gun_turret.energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    drain = "50kW",
    buffer_capacity = "800kJ"
  }
  gun_turret.energy_per_shot = "100kJ",
  data:extend({gun_turret})
end