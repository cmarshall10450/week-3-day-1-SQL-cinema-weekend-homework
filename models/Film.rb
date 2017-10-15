class Film

	def initialize(options)
		@id = options['id'].to_i if options['id']
		@title = options['title']
		@price = options['price'].to_f
	end

	def save

	end

	def update

	end

	def delete

	end

	def customers

	end

end