require('pg')
require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

# CREATE / SAVE

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES(
      $1, $2)
      RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i
  end

# READ

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    films_array = films.map{ |film| Film.new(film)}
    return films_array
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    pg_film = SqlRunner.run(sql, values)
    film = Film.new(pg_film[0])
    return film
  end

# PDA: The below function uses an inner join to search for all customers that have seen the film on which the function is being run. The sql statement does this by matching the film id and customer id's using the tickets table, which is the join table in this scenario. The function returns an array of customers matching the sql statement.

  # def customers()
  #   sql = "SELECT customers.* FROM customers
  #   INNER JOIN tickets
  #   ON tickets.customer_id = customers.id
  #   WHERE film_id = $1;"
  #   values = [@id]
  #   result = SqlRunner.run(sql, values)
  #   array_of_customers = result.map {|customer| Customer.new(customer)}
  #   return array_of_customers
  # end

# refactored with screenings table:
  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    array_of_customers = result.map {|customer| Customer.new(customer)}
    return array_of_customers
  end

  def screenings()
    sql = "SELECT * FROM screenings
    WHERE film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    array_of_screenings = result.map {|screening| Screening.new(screening)}
    return array_of_screenings
  end

# # number of customers seeing a certain film::
#   def number_of_customers()
#     list_of_customers = self.customers
#     return list_of_customers.length
#   end

# UPDATE

def update()
  sql = "UPDATE films
  SET
  (
    title,
    price
  ) =
  (
    $1, $2
  )
  WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

# DELETE

  def self.delete_all()
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)
  end


end
