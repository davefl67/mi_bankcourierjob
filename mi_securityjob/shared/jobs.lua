Job = {}

-- if the idea of this file is confusing, just think of it like another config file
-- shit be nutty when I found out I could do that

Job.vehicle = {
    model = {
        bs1 = 'bssurge',
        bs2 = 'bsfugitive',
        bs3 = 'bsseminolef',
        bs4 = 'bspony',
    },
    loc = vector4(890.584, -2100.157, 30.324, 356.245), -- spawn location
}

Job.cooldown = 5

Job.blip = {
    sprite = 1,
    color = 68,
    route = true,
    routecolor = 68,
    scale = 0.5,
    name = 'Job site'
}

-- transfer fleeca money between banks
Job.check = {

    payment = math.random(100, 250), -- payout when task is completed

    [1] = {
        loc = vector4(734.477, -1932.427, 29.292, 354.832), -- spawn location
        model = 'a_m_y_business_02', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

}

-- deliver money from businesses to the pacific standard bank
Job.patrol = {

    time = 1,
    payment = math.random(200, 350), -- payout when task is completed

    [1] = { -- powerplant
        loc = vector4(734.477, -1932.427, 29.292, 354.832), -- spawn location
        model = 's_m_m_dockwork_01', -- ped model
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

}

-- transfer fleeca money between banks
Job.secdevice = {

    payment = math.random(400, 600), -- payout when task is completed
    mngr1 = {
        loc = vector4(746.314, -1950.932, 29.292, 353.507), -- spawn location
        model = 'u_m_m_bankman', -- object
        anim = 'WORLD_HUMAN_STAND_IMPATIENT', -- standing animation
    },

}