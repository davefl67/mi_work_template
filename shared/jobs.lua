Job = {}

-- if the idea of this file is confusing, just think of it like another config file
-- shit be nutty when I found out I could do that

Job.vehicle = {
    model = 'buffalo4', -- vehicle model
    loc = vector4(-200.664, -1326.977, 30.919, 90.081), -- spawn location
}

-- tasks interacting with peds
Job.job1 = {
    payment = math.random(100, 200), -- payout when task is completed
    [1] = {
        loc = vector4(-469.636, -45.823, 44.516, 176.483), -- spawn location
        model = 'mp_f_chbar_01', -- ped model
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
    },
    [2] = {
        loc = vector4(-472.071, -45.691, 44.516, 179.329), -- spawn location
        model = 'a_f_y_indian_01', -- ped model
        anim = 'WORLD_HUMAN_DRINKING_FACILITY', -- standing animation
    }
}

-- tasks interacting with objects
Job.job2 = {
    payment = math.random(200, 400), -- payout when task is completed
    [1] = {
        loc = vector4(-469.636, -45.823, 44.516, 176.483), -- spawn location
        object = 'v_ind_cm_electricbox', -- object model
    },
    [2] = {
        loc = vector4(-472.071, -45.691, 44.516, 179.329), -- spawn location
        object = 'v_ind_cm_electricbox', -- object model
    }
}