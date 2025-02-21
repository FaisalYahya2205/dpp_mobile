String sessionCreateTable = '''
      CREATE TABLE session (
        user_id INTEGER PRIMARY KEY UNIQUE,
        partner_id INTEGER UNIQUE,
        session_id VARCHAR(50),
        user_login VARCHAR(50) UNIQUE,
        user_name VARCHAR(50) UNIQUE,
        password VARCHAR(50),
        login_state INTEGER
      )
    ''';