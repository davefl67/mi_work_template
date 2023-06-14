Job = {}

Job.vehicle = {
    model1 = 'faggio',
    model2 = 'speedo',
    model3 = 'buffalo',
    loc = vector3(-462.499, -51.986, 44.134),
    head = 87.365
}

-- peds
Job.job1 = {
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
Job.job2 = {
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