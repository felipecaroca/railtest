require 'fancy'

class Fancifier
	include Fancy
	attr_accessor :title, :palindrome,:largest

	def initialize(title)
		@title = title
		@palindrome = "#{title}#{title.to_s.reverse}"
		@largest = largest_palindrome(title)
	end

	Color.all.each do |x|
		define_method x.name.downcase do
			return x.code
		end
	end


	def largest_palindrome(string)
		longest = ''
		i = 0
		while i < string.length
			j = 1
			while (i + j) <= string.length
				x = string.slice(i, j)

				if (x.length > longest.length) && (x == x.reverse)
					longest = x
				end
				j += 1
			end
			i += 1
		end
		if longest.length < 2
			longest = nil
		end
		longest
	end
	def method_missing(name, *args, &block)
	end

	def respond_to_missing(name, *args)
		name = name || super
	end
end