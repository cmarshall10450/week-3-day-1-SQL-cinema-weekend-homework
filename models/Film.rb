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

	end

end