Config = {}
Config.debug = true

Config.job = {
    -- make sure this matches to the job you want to connect to in your db
    name = 'bankcourier',
    grades = { 'Security Guard', 'Boss' }
}

Config.blip = {
    -- please don't just leave the blip as 'Work Place'
    loc = vector3(251.949, 223.577, 97.117),
    sprite = 582,
    color = 3,
    scale = 0.7,
    name = 'S.A. Powerplant'
}

Config.teleport = {
    active = true,
    pointa = vector4(-213.846, -1322.251, 31.3, 87.088),
    pointb = vector4(-193.655, -1332.656, 34.989, 97.988)
}

Config.salary = {
    pers = true,
    intvl = 15,
}

Config.peds = {

    -- for changing animations, use https://github.com/DioneB/gtav-scenarios for refrence
    work = {
        model = 's_m_m_security_01', -- ped model
        loc = vector4(2681.69, 1594.977, 24.494, 240.992), -- spawn location
        anim = 'WORLD_HUMAN_SMOKING_CLUBHOUSE', -- standing animation
        dist = 2 -- distance before textUI appears
    },

    spawn = {
        model = 's_m_m_security_01', -- ped model
        loc = vector4(2677.509, 1596.218, 24.5, 26.318), -- spawn location
        anim = 'WORLD_HUMAN_SMOKING_CLUBHOUSE', -- standing animation
        dist = 3 -- distance before textUI appears
    },

    unif = {
        model = 's_m_m_security_01', -- ped model
        loc = vector4(2671.272, 1605.711, 24.5, 23.855), -- spawn location
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
        dist = 3 -- distance before textUI appears
    },
}

Config.uniforms = {
    male = {
        arms = {component_id = 3, texture = 0, drawable = 4},
        torso = {component_id = 11, texture = 6, drawable = 390},
        undershirt = {component_id = 8, texture = 15, drawable = 178},
        pants = {component_id = 4, texture = 6, drawable = 10},
        shoes = {component_id = 6, texture = 0, drawable = 20},
        bag = {component_id = 5, texture = 11, drawable = 27},
        accesories = {component_id = 7, texture = 0, drawable = 38},
        kevlar = {component_id = 9, texture = 0, drawable = 0},
        badge = {component_id = 10, texture = 0, drawable = 0},
        hat = {component_id = 0, texture = 0, drawable = -1}
    },
    female = {
        arms = {component_id = 3, texture = 0, drawable = 4},
        torso = {component_id = 11, texture = 0, drawable = 111},
        undershirt = {component_id = 8, texture = 0, drawable = 44},
        pants = {component_id = 4, texture = 0, drawable = 10},
        shoes = {component_id = 6, texture = 0, drawable = 19},
        bag = {component_id = 5, texture = 6, drawable = 281},
        accesories = {component_id = 7, texture = 0, drawable = 0},
        kevlar = {component_id = 9, texture = 0, drawable = 7},
        badge = {component_id = 10, texture = 0, drawable = 0},
        hat = {component_id = 0, texture = 0, drawable = 1}
    },
}


