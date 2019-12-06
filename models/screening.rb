require('pg')
require_relative('../db/sql_runner')
require_relative('film')

class Screening

  attr_reader :id
  attr_accessor :showing_time, :capacity, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @showing_time = options['showing_time']
    @capacity = options['capacity'].to_i
    @film_id = options['film_id'].to_i
  end

# CREATE / SAVE

  def save()
    sql = "INSERT INTO screenings
    (
      showing_time,
      capacity,
      film_id
    )
    VALUES(
      $1, $2, $3)
      RETURNING id;"
    values = [@showing_time, @capacity, @film_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i
  end

# READ

  def self.all()
    sql = "SELECT * FROM screenings;"
    screenings = SqlRunner.run(sql)
    return screenings.map{ |screening| Screening.new(screening)}
  end

# UPDATE

  def update()
    sql = "UPDATE screenings
    SET
    (
      showing_time,
      capacity,
      film_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@showing_time, @capacity, @film_id, @id]
    SqlRunner.run(sql, values)
  end

# DELETE

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end



end
