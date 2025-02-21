String employeeCreateTable = '''
  CREATE TABLE employee (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    name VARCHAR(50),
    nrp VARCHAR(10),
    job_id VARCHAR(50),
    job_title VARCHAR(50),
    work_email VARCHAR(100),
    work_phone VARCHAR(15),
    address_id VARCHAR(50),
    coach_id VARCHAR(50),
    __last_update VARCHAR(50),
    image_128 TEXT,
    image_1920 TEXT,
    tz VARCHAR(100)
  )
''';
