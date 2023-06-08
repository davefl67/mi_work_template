Config = {}
Config.debug = false

Config.jobname = { 'job1', 'pizza_this' }
Config.joblabel = 'Pizza This'

Config.wblip = {
    loc = vector3(807.014, -758.372, 26.78),
    sprite = 527,
    color = 73,
    scale = 0.8,
    name = 'Pizza This'
}

Config.jobstash_id = 'pizza_lockers'
Config.jobstash_label = 'P.T. Lockers'
Config.jobstash_slots = 20
Config.jobstash_weight = 100000
Config.jobstash = {
    loc = vector3(810.49, -758.227, 31.265),
    head = 180
}

Config.boss_ped = {
    model = 'a_m_m_golfer_01',
    loc = vector4(810.136, -750.317, 26.78, 90.241)
}

Config.vehicle_ped = {
    model = 'a_m_y_business_02',
    loc = vector4(795.854, -760.65, 26.78, 357.675)
}

Config.vehicle = {
    model1 = 'faggio',
    model2 = 'adder',
    model3 = 'buffalo',
    loc = vector3(787.003, -760.564, 25.987),
    head = 178.247
}

-- peds
Config.job1 = {
    payment = math.random(100, 200),
    [1] = {
        loc = vector4(-556.484, 274.261, 83.019, 168.13),
        model = 'mp_f_chbar_01',
    },
    [2] = {
        loc = vector4(-172.034, -1631.94, 33.476, 94.617),
        model = 'mp_m_famdd_01',
    },
    [3] = {
        loc = vector4(-658.726, -915.913, 24.061, 194.104),
        model = 'a_m_o_ktown_01',
    },
    [4] = {
        loc = vector4(-697.43, 43.77, 43.315, 204.581),
        model = 'cs_magenta',
    },
    [5] = {
        loc = vector4(-23.128, -354.129, 40.78, 306.792),
        model = 'a_f_y_indian_01',
    },
    [6] = {
        loc = vector4(-1092.146, -808.831, 19.272, 36.957),
        model = 's_f_y_cop_01',
    }
}

-- objects
Config.job2 = {
    payment = math.random(200, 400),
    [1] = {
        loc = vector4(353.42, -583.903, 28.796, 161.23),
        object = 'v_ind_cm_electricbox',
    },
    [2] = {
        loc = vector4(353.42, -583.903, 28.796, 161.23),
        object = 'v_ind_cm_electricbox',
    }
}