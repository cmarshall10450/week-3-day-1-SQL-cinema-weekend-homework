require_relative('../db/SQLRunner')
require_relative('Film')
require_relative('Ticket')

class Customer

	attr_reader :id
	attr_accessor :name, :funds

	def initialize(options)
		@id = options['id'].to_i if options['id']
		@name = options['name']
		@funds = options['funds'].to_f
	end

	def save
		sql = 'INSERT INTO customers (
  					name,
  					funds
					)
					VALUES (
						$1, $2
					)
					RETURNING id;'

		values = [@name, @funds]
		@id = SQLRunner.run(sql, values)[0]['id'].to_i
	end

	def update
		sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;'
		values = [@name, @funds, @id]
		SQLRunner.run(sql, values)
	end

	def delete
		sql = 'DELETE FROM customers WHERE id = $1'
		values = [@id]
		SQLRunner.run(sql, values)
	end

	def films
		sql = 'SELECT films.* from films
					 INNER JOIN tickets
					 ON films.id = tickets.film_id
					 WHERE customer_id = $1;'
		values = [@id]

		films = SQLRunner.run(sql, values).map{ |film|
			Film.new(film)
		}

		return films
	end

	def buy_ticket_for_film_by_id(film_id)
		price = Film.get_film_price(film_id)
		@funds -= price
		update()

		ticket = Ticket.new({
			'customer_id' => @id,
			'film_id' => film_id
		})

		ticket.save
	end

	def ticket_count
		sql = 'SELECT count(id) from tickets WHERE customer_id = $1;'
		values = [@id]

		return SQLRunner.run(sql, values)[0]['count'].to_i
	end

end