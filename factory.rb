class Factory
	def self.new(*args, &block)
		Class.new do
			args.each { |arg| self.send(:attr_accessor, arg) }

			define_method "initialize" do |*values|
				raise ArgumentError if values.size > args.size
				values.each_with_index do |value, index|
					instance_variable_set("@#{args[index]}", value)
				end
			end
			
			define_method "[]" do |value|
				if value.is_a? Fixnum
					raise ArgumentError unless value < args.length
					instance_variable_get("@#{args[value]}")
				else
					raise NoMethodError unless args.include? value
					instance_variable_get("@#{value}")
				end
			end

			module_eval &block if block_given?
		end
	end
end


		Costumer = Factory.new(:name, :size, :cost) do
			def hello
				puts "Hello, i'm #{name}."
			end
		end

		costumer = Costumer.new("Mike", "big", "$100")

		puts costumer[0]

		costumer.hello

