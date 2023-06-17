Config = {}
Config.debug = true

Config.job = {
    -- make sure this matches to the job you want to connect to in your db
    name = 'job1',
    grades = { 'a1', 'a2, ab' }
}

Config.blip = {
    -- please don't just leave the blip as 'Work Place'
    loc = vector3(-211.424, -1327.399, 31.3),
    sprite = 548,
    color = 73,
    scale = 0.7,
    name = 'Work Place'
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
        model = 'ig_paige', -- ped model
        loc = vector4(-206.181, -1334.369, 31.301, 64.025), -- spawn location
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
        dist = 2 -- distance before textUI appears
    },

    spawn = {
        model = 'u_m_y_smugmech_01', -- ped model
        loc = vector4(-198.347, -1324.425, 31.3, 109.679), -- spawn location
        anim = 'WORLD_HUMAN_SMOKING_CLUBHOUSE', -- standing animation
        dist = 3 -- distance before textUI appears
    },

    unif = {
        model = 'mp_m_waremech_01', -- ped model
        loc = vector4(-191.92, -1339.18, 30.801, 86.636), -- spawn location
        anim = 'WORLD_HUMAN_SEAT_WALL_TABLET', -- standing animation
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


