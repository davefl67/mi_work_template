Config = {}
Config.debug = true

Config.jobname = { 'job1' }
Config.joblabel = 'Work Place'

Config.wblip = {
    loc = vector3(-1072.506, -250.134, 44.021),
    sprite = 548,
    color = 73,
    scale = 0.7,
    name = 'Work Place'
}

Config.jobstash_id = 'work_lockers'
Config.jobstash_label = 'Work Lockers'
Config.jobstash_slots = 20
Config.jobstash_weight = 100000
Config.jobstash = {
    loc = vector3(-1062.531, -250.712, 44.021),
    head = 207
}

Config.boss_ped = {
    model = 'a_f_y_hipster_01',
    anim = 'WORLD_HUMAN_DRINKING_FACILITY',
    loc = vector4(-1063.27, -241.057, 44.021, 206.88)
}

Config.vehicle_ped = {
    model = 'a_m_y_hipster_01',
    anim = 'PROP_HUMAN_SEAT_CHAIR_DRINK',
    loc = vector4(-1086.593, -259.95, 37.25, 25)
}

Config.vehicle = {
    model1 = 'faggio',
    model2 = 'speedo',
    model3 = 'buffalo',
    loc = vector3(-1098.6, -257.255, 37.25),
    head = 139.333
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