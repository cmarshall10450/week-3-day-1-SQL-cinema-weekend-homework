require('pry')
require_relative('../models/Film')
require_relative('../models/Ticket')
require_relative('../models/Guest')

customer_1 = Customer.new({
	'name' => 'Chris Marshall',
	'funds' => 1000
})

customer_1.save

binding.pry
nil