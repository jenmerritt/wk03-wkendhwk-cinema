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
    return films.map{ |film| Film.new(film)}
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1;"
    values = [@id]
    pg_result_of_customers = SqlRunner.run(sql, values)
    array_of_customers = pg_result_of_customers.map {|customer| Customer.new(customer)}
    return array_of_customers
  end

# number of customers:
  def number_of_customers()
    list_of_customers = self.customers
    return list_of_customers.length
  end

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
