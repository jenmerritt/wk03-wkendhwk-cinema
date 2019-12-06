require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )

require('pry')

Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({
  'name' => 'Regina Phalange',
  'funds' => 20
  })

customer1.save()

customer2 = Customer.new({
  'name' => 'Ken Adams',
  'funds' => 5
  })

customer2.save()

film1 = Film.new({
  'title' => 'Frozen 2',
  'price' => 8
  })

film1.save()

film2 = Film.new({
  'title' => 'Last Christmas',
  'price' => 12
  })

film2.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket2.save()

binding.pry
nil
