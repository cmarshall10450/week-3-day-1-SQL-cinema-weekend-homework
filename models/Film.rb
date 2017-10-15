require_relative('../db/SQLRunner')
require_relative('Guest')

class Film

	def initialize(options)
		@id = options['id'].to_i if options['id']
		@title = options['title']
		@price = options['price'].to_f
	end

	def save
		sql = 'INSERT INTO films (
  					title,
  					price
					)
					VALUES (
						$1, $2
					)
					RETURNING id;'

		values = [@title, @price]
		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def update
		sql = 'UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;'
		values = [@title, @price, @id]
		SQLRunner.run(sql, values)
	end

	def delete
		sql = 'DELETE FROM films WHERE id = $1'
		values = [@id]
		SQLRunner.run(sql, values)
	end

	def customers
		sql = 'SELECT customers.* from customers
					 INNER JOIN tickets
           ON customers.id = tickets.customer_id
					 WHERE film_id = $1;'

		values = [@id]
		customers = SQLRunner.run(sql, values).map{ |customer|
			Customer.new(customer)
		}

		return customers
	end

	def self.get_film_price(id)
		sql = 'SELECT price from films WHERE id = $1'
		values = [id]
		return SQLRunner.run(sql, values)[0]['price'].to_f
	end

end