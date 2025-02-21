String attendanceCreateTable = '''
      CREATE TABLE attendance (
        id INTEGER UNIQUE PRIMARY KEY,
        employee_id INTEGER,
        schedule_in TEXT,
        check_in TEXT,
        geo_check_in TEXT,
        geo_access_check_in INTEGER,
        geospatial_access_check_in INTEGER,
        map_url_check_in TEXT,
        ismobile_check_in INTEGER,
        check_in_image TEXT,
        schedule_out TEXT,
        check_out TEXT,
        geo_check_out TEXT,
        geo_access_check_out INTEGER,
        geospatial_access_check_out INTEGER,
        map_url_check_out TEXT,
        ismobile_check_out INTEGER,
        check_out_image TEXT,
        desc TEXT,
        worked_hours REAL
      )
    ''';