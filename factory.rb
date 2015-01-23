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
					raise NoMethodError unless value < args.length
					instance_variable_get("@#{args[value]}")
				else
					raise NoMethodError unless args.include? value
					instance_variable_get("@#{value}")
				end
			end

			class_eval &block if block_given?
		end
	end
end


