# Factory

## Usage:

```ruby
require 'factory'

Costumer = Factory.new(:name, :size, :cost) do
	def hello
		puts "Hello, i'm #{name}."
	end
end

costumer = Costumer.new("Mike", "big", "$100")

puts costumer[0]

costumer.hello
```