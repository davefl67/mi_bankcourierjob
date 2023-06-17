Job = {}

-- if the idea of this file is confusing, just think of it like another config file
-- shit be nutty when I found out I could do that

Job.vehicle = {
    model = 'buffalo4', -- vehicle model
    loc = vector4(-200.664, -1326.977, 30.919, 90.081), -- spawn location
}

Job.blip = {
    sprite = 1,
    color = 68,
    route = true,
    routecolor = 68,
    scale = 0.5,
    name = 'jobsite'
}

-- tasks interacting with peds
Job.pedtask = {
    payment = math.random(100, 200), -- payout when task is completed
    [1] = {
        loc = vector4(-216.611, -1333.424, 31.301, 43.041), -- spawn location
        model = 'mp_f_chbar_01', -- ped model
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
    },
    [2] = {
        loc = vector4(-215.895, -1336.46, 31.33, 273.597), -- spawn location
        model = 'a_f_y_indian_01', -- ped model
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
    }
}

-- tasks interacting with objects
Job.objtask = {
    payment = math.random(200, 400), -- payout when task is completed
    [1] = {
        loc = vector4(-216.611, -1333.424, 31.301, 43.041), -- spawn location
        object = 'v_ind_cm_electricbox', -- object model
    },
    [2] = {
        loc = vector4(-215.895, -1336.46, 31.33, 273.597), -- spawn location
        object = 'v_ind_cm_electricbox', -- object model
    }
}