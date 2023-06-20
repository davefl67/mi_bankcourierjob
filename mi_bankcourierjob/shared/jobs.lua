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

    [1] = { -- alta & harwick
        loc = vector4(308.125, -280.576, 54.164, 343.588), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [2] = { -- legion square
        loc = vector4(143.645, -1042.285, 29.367, 342.0), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [3] = { -- burton
        loc = vector4(-356.964, -51.118, 49.036, 340.999), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [4] = { -- rockford hills
        loc = vector4(-1215.946, -335.997, 37.78, 25.321), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [5] = { -- great ocean highway
        loc = vector4(-2959.428, 477.568, 15.696, 82.199), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(200, 300), -- payout when task is completed
    },

    [6] = { -- route 68
        loc = vector4(1180.322, 2710.263, 38.087, 180.065), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(300, 400), -- payout when task is completed
    },

}

-- deliver money from businesses to the pacific standard bank
Job.pacific = {

    [1] = { -- alta & harwick
        loc = vector4(308.125, -280.576, 54.164, 343.588), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [2] = { -- legion square
        loc = vector4(143.645, -1042.285, 29.367, 342.0), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [3] = { -- burton
        loc = vector4(-356.964, -51.118, 49.036, 340.999), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [4] = { -- rockford hills
        loc = vector4(-1215.946, -335.997, 37.78, 25.321), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(150, 300), -- payout when task is completed
    },

    [5] = { -- great ocean highway
        loc = vector4(-2959.428, 477.568, 15.696, 82.199), -- spawn location
        model = 'a_f_m_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(200, 300), -- payout when task is completed
    },

    [6] = { -- route 68
        loc = vector4(1180.322, 2710.263, 38.087, 180.065), -- spawn location
        model = 'a_f_y_business_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
        payment = math.random(300, 400), -- payout when task is completed
    },

}

-- transfer fleeca money between banks
Job.paleto = {

    cooldown = 15,
    loc = vector4(308.125, -280.576, 54.164, 343.588), -- spawn location
    model = 'a_f_m_business_02', -- ped model
    anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    payment = math.random(300, 900), -- payout when task is completed

}