DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE screenings(
  id SERIAL PRIMARY KEY,
  showing_time VARCHAR(255),
  capacity INT,
  film_id INT NOT NULL REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  screening_id INT NOT NULL REFERENCES screenings(id) ON DELETE CASCADE
  -- film_id INT NOT NULL REFERENCES films(id) ON DELETE CASCADE
);
