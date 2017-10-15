require('pry')
require_relative('../models/Film')
require_relative('../models/Ticket')
require_relative('../models/Guest')

customer_1 = Customer.new({
	'name' => 'Chris Marshall',
	'funds' => 1000
})
customer_1.save

customer_2 = Customer.new({
	'name' => 'Darren Kerr',
	'funds' => 500
})
customer_2.save

film_1 = Film.new({
	'title' => 'The Usual Supects',
	'price' => 25
})
film_1.save

film_2 = Film.new({
	'title' => 'The Longest Yard',
	'price' => 15
})
film_2.save

binding.pry
nil