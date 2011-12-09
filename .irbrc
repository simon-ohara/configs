require 'irb/completion'
require 'rubygems'
require 'awesome_print'

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value,
      :multiline => false,
			:plain  => false,
			:indent => 2,
			:color => {
				:array      => :white,
				:bignum     => :blue,
				:class      => :yellow,
				:date       => :greenish,
				:falseclass => :red,
				:fixnum     => :blue,
				:float      => :blue,
				:hash       => :gray,
				:nilclass   => :red,
				:string     => :yellowish,
				:symbol     => :cyanish,
				:time       => :greenish,
				:trueclass  => :green
			}
			end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end
