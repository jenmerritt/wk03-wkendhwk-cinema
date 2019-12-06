require('pg')
require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

# CREATE / SAVE

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES(
      $1, $2)
      RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

# READ

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    return customers.map{ |customer| Customer.new(customer)}
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1;"
    values = [@id]
    pg_result_of_films = SqlRunner.run(sql, values)
    array_of_films = pg_result_of_films.map {|film| Film.new(film)}
    return array_of_films
  end

# UPDATE

  def update()
    sql = "UPDATE customers
    SET
    (
      name,
      funds
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

# DELETE

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end





end
