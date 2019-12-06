require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )

require('pry')

Ticket.delete_all
Screening.delete_all
Film.delete_all
Customer.delete_all

#### CUSTOMERS:

customer1 = Customer.new({
  'name' => 'Regina Phalange',
  'funds' => 50
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Ken Adams',
  'funds' => 8
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'Chanandler Bong',
  'funds' => 90
  })
customer3.save()

customer4 = Customer.new({
  'name' => 'Ross Gellar',
  'funds' => 50
  })
customer4.save()

customer5 = Customer.new({
  'name' => 'Monica Gellar',
  'funds' => 70
  })
customer5.save()

customer6 = Customer.new({
  'name' => 'Rachel Green',
  'funds' => 15
  })
customer6.save()

#### FILMS:

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

film3 = Film.new({
  'title' => 'Little Women',
  'price' => 15
  })

film3.save()


#### SCREENINGS:

screening1 = Screening.new({
  'showing_time' => "12:00",
  'capacity' => 5,
  'film_id' => film1.id
  })

screening1.save()

screening2 = Screening.new({
  'showing_time' => "14:00",
  'capacity' => 7,
  'film_id' => film2.id
  })

screening2.save()

screening3 = Screening.new({
  'showing_time' => "16:00",
  'capacity' => 10,
  'film_id' => film3.id
  })

screening3.save()

screening4 = Screening.new({
  'showing_time' => "18:00",
  'capacity' => 20,
  'film_id' => film1.id
  })

screening4.save()

screening5 = Screening.new({
  'showing_time' => "19:00",
  'capacity' => 120,
  'film_id' => film2.id
  })

screening5.save()

screening6 = Screening.new({
  'showing_time' => "20:00",
  'capacity' => 150,
  'film_id' => film3.id
  })

screening6.save()


#### TICKETS:

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  # 'film_id' => film1.id
  'screening_id' => screening1.id
  })
ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  # 'film_id' => film2.id
  'screening_id' => screening2.id
  })

ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  # 'film_id' => film2.id
  'screening_id' => screening5.id
  })

ticket3.save()

# FOR PDA:

# customer3 = Customer.new({
#   'name' => 'John Smith',
#   'funds' => 10
#   })
# customer3.save()
#
# customer4 = Customer.new({
#   'name' => 'Jane Smith',
#   'funds' => 5
#   })
# customer4.save()
#
# customer5 = Customer.new({
#   'name' => 'Jack Jones',
#   'funds' => 2
#   })
# customer5.save()
#
# p Customer.all_by_funds()

binding.pry
nil
