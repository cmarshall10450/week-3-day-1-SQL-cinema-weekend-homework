class Customer

	def initialize(options)
		@id = options['id'].to_i if options['id']
		@name = options['name']
		@funds = options['funds'].to_i
	end

	def save

	end

	def update

	end

	def delete

	end

end