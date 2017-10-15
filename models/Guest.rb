require_relative('../db/SQLRunner')

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

	end

end