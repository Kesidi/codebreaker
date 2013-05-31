module Codebreaker
  class Game
    attr_accessor :code, :guess
     def initialize(output)
      @output = output
    end
    
    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
    end

    def check
      hash = Hash.new(0)
      @code.each_char {|char| hash[char] = char}
      array = hash.map {|key,value| key }
      result = ""
      4.times do |val|
         
        if  @code[val] == @guess[val]
          result += "+"
        elsif  array.include?(@guess[val])
           result += "-"
        end
       
          
      end
      result
    end
    def enter_guess(string)
      return "incorrect data" if (string.length != 4) or (string =~ /\D|[7890]/)
      @guess = string
    end
  end
end
