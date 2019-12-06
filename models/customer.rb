require('pg')
require_relative('../db/sql_runner')
require_relative('ticket')
require_relative('screening')

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

  # def films()
  #   sql = "SELECT films.* FROM films
  #   INNER JOIN tickets
  #   ON tickets.film_id = films.id
  #   WHERE customer_id = $1;"
  #   values = [@id]
  #   pg_result_of_films = SqlRunner.run(sql, values)
  #   array_of_films = pg_result_of_films.map {|film| Film.new(film)}
  #   return array_of_films
  # end

# refactored when screening table added:

  def films()
    sql = "SELECT films.* FROM films
   	INNER JOIN screenings
    ON screenings.film_id = films.id
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE customer_id = $1;"
    values = [@id]
    pg_result_of_films = SqlRunner.run(sql, values)
    array_of_films = pg_result_of_films.map {|film| Film.new(film)}
    return array_of_films
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE customer_id = $1;"
    values = [@id]
    pg_result_of_screenings = SqlRunner.run(sql, values)
    array_of_screenings = pg_result_of_screenings.map {|screening| Screening.new(screening)}
    return array_of_screenings
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

# EXTENSIONS

# ## Buy ticket with no check on affordance:
# # To buy ticket, need to put film to buy ticket for as parameter.
#   def buy_ticket(film)
# # Then need to create a ticket and save it:
#     new_ticket = Ticket.new({
#       'customer_id' => @id,
#       'film_id' => film.id
#       })
#     new_ticket.save
# # Then reduce the funds the customer has by the price of the film
#     @funds -= film.price
#     return "Your ticket number is #{new_ticket.id}."
#   end

## Buy ticket with check on affordance:

# To buy ticket, need to put film to buy ticket for as parameter.
  def buy_ticket(film)
  # then need to check if funds are greater than or equal to price.
    if @funds >= film.price
  # Then need to create a ticket and save it:
      new_ticket = Ticket.new({
        'customer_id' => @id,
        'film_id' => film.id
        })
      new_ticket.save
  # Then reduce the funds the customer has by the price of the film
      @funds -= film.price
      return "Your ticket number is #{new_ticket.id}."
    end
  # return message if cannot be afforded:
    return "Sorry, you do not have sufficient funds."
  end

# Check how many tickets were bought by a customer:

# return array of the tickets
  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1;"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    array_of_tickets = pg_result.map { |ticket| Ticket.new(ticket)}
    return array_of_tickets
  end

# find length of tickets array
  def number_of_tickets()
    tickets_bought = self.tickets
    return tickets_bought.length
  end

# FOR PDA: The below function searches the Customer class and takes the customers name and funds, then returns the data for when the funds are greater than 7. The matching customers are returned in an array, ordered by funds, in ascending order.

def self.all_by_funds()
  sql = "SELECT customers.name, customers.funds FROM customers WHERE funds > 7 ORDER BY funds ASC;"
  customers = SqlRunner.run(sql)
  return customers.map{ |customer| Customer.new(customer)}
end


end
