String hostCreateTable = '''
      CREATE TABLE host_address (
        user_id INTEGER UNIQUE,
        host_url VARCHAR(50),
        database_name VARCHAR(50)
      )
    ''';