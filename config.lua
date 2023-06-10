Config = {}
Config.debug = true

Config.jobname = { 'job1' }
Config.joblabel = 'Work Place'

Config.wblip = {
    loc = vector3(-467.96, -58.141, 44.513),
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
    loc = vector3(-469.151, -63.008, 44.513),
    head = 200
}

Config.boss_ped = {
    model = 'a_f_y_hipster_01',
    anim = 'WORLD_HUMAN_DRINKING_FACILITY',
    loc = vector4(-464.31, -64.054, 44.513, 39.67)
}

Config.vehicle_ped = {
    model = 'a_m_y_hipster_01',
    anim = 'WORLD_HUMAN_DRINKING_FACILITY',
    loc = vector4(-461.796, -62.158, 44.513, 39.888)
}

Config.vehicle = {
    model1 = 'faggio',
    model2 = 'speedo',
    model3 = 'buffalo',
    loc = vector3(-462.499, -51.986, 44.134),
    head = 87.365
}

-- peds
Config.job1 = {
    payment = math.random(100, 200),
    [1] = {
        loc = vector4(-469.636, -45.823, 44.516, 176.483),
        model = 'mp_f_chbar_01',
    },
    [2] = {
        loc = vector4(-472.071, -45.691, 44.516, 179.329),
        model = 'a_f_y_indian_01',
    }
}

-- objects
Config.job2 = {
    payment = math.random(200, 400),
    [1] = {
        loc = vector4(-469.636, -45.823, 44.516, 176.483),
        object = 'v_ind_cm_electricbox',
    },
    [2] = {
        loc = vector4(-472.071, -45.691, 44.516, 179.329),
        object = 'v_ind_cm_electricbox',
    }
}