Job = {}

-- if the idea of this file is confusing, just think of it like another config file
-- shit be nutty when I found out I could do that

Job.vehicle = {
    model = 'g6stockade', -- vehicle model
    loc = vector4(261.339, 188.156, 104.322, 69.561), -- spawn location
}

Job.cooldown = 5

Job.blip = {
    sprite = 1,
    color = 68,
    route = true,
    routecolor = 68,
    scale = 0.5,
    name = 'Jobsite'
}

-- transfer fleeca money between banks
Job.fleeca = {

    payment = math.random(100, 250), -- payout when task is completed

    [1] = { -- alta & harwick
        loc = vector4(308.125, -280.576, 54.164, 343.588), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [2] = { -- legion square
        loc = vector4(143.645, -1042.285, 29.367, 342.0), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [3] = { -- burton
        loc = vector4(-356.964, -51.118, 49.036, 340.999), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [4] = { -- rockford hills
        loc = vector4(-1215.946, -335.997, 37.78, 25.321), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [5] = { -- great ocean highway
        loc = vector4(-2959.428, 477.568, 15.696, 82.199), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [6] = { -- route 68
        loc = vector4(1180.322, 2710.263, 38.087, 180.065), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

}

-- deliver money from businesses to the pacific standard bank
Job.pacific = {

    cooldown = 0,
    payment = math.random(200, 350), -- payout when task is completed

    [1] = { -- powerplant
        loc = vector4(2670.544, 1612.759, 24.5, 270.046), -- spawn location
        model = 's_m_m_dockwork_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [2] = { -- vineyard
        loc = vector4(-1890.918, 2042.024, 140.938, 338.929), -- spawn location
        model = 's_m_m_cntrybar_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [3] = { -- beach club
        loc = vector4(-3005.023, 79.221, 11.608, 329.022), -- spawn location
        model = 'a_m_o_beach_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [4] = { -- pearls
        loc = vector4(-1806.226, -1187.09, 13.017, 289.998), -- spawn location
        model = 'a_f_y_gencaspat_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [5] = { -- wiwang building
        loc = vector4(-828.355, -695.686, 28.058, 92.481), -- spawn location
        model = 'g_m_y_korlieut_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [6] = { -- koi
        loc = vector4(109.309, -1089.744, 29.303, 7.566), -- spawn location
        model = 'a_f_y_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [7] = { -- seoul strip
        loc = vector4(-612.157, -1054.757, 21.788, 165.189), -- spawn location
        model = 'a_f_m_ktown_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [8] = { -- east ls
        loc = vector4(932.082, -1807.779, 30.714, 263.245), -- spawn location
        model = 'a_f_m_eastsa_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [9] = { -- mirror / east ls
        loc = vector4(792.451, -754.649, 26.862, 96.221), -- spawn location
        model = '792.451, -754.649, 26.862, 96.221', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

    [10] = { -- north vinewood
        loc = vector4(-55.896, 353.494, 112.443, 139.689), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

}

-- transfer fleeca money between banks
Job.paleto = {

    cooldown = 15,
    loc = vector4(-111.587, 6459.724, 31.468, 129.148), -- spawn location
    model = 'a_f_m_business_02', -- ped model
    anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    payment = math.random(400, 900), -- payout when task is completed

}