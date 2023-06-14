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

Config.salary = {
    pers = true,
    intvl = 1,
}

Config.peds = {

    -- for changing animations, use https://github.com/DioneB/gtav-scenarios for refrence
    work = {
        model = 'mp_m_waremech_01', -- ped model
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
        model = 'ig_natalia', -- ped model
        loc = vector4(-191.92, -1339.18, 30.801, 86.636), -- spawn location
        anim = 'WORLD_HUMAN_SEAT_WALL_TABLET', -- standing animation
        dist = 3 -- distance before textUI appears
    },

    mngr = {
        model = 'ig_paige', -- ped model
        loc = vector4(-192.903, -1315.493, 30.802, 270.0), -- spawn location
        anim = 'PROP_HUMAN_SEAT_COMPUTER_LOW', -- standing animation
        dist = 2 -- distance before textUI appears
    },
}

Config.uni = {
    u1 = {
        arms = {obj = 4, txt = 0},
        torso = {obj = 111, txt = 0},
        undershirt = {obj = 44, txt = 0},
        pants = {obj = 10, txt = 0},
        shoes = {obj = 19, txt = 0},
        bag = {obj = 281, txt = 6},
        accs = {obj = 0, txt = 0},
        kevlar = {obj = 7, txt = 0},
        badge = {obj = 0, txt = 0},
        hat = {obj = 1, txt = 0},
    }
}


