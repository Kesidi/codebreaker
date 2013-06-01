module Codebreaker
  class Game
    attr_accessor :code, :guess, :attemps
    def initialize(output, input)
      @output = output
      @input = input
      @max_attemps = 10
    end
    
    def generate_code(length)
      length.times { @code += rand(1..6).to_s } 
    end

    def clear
      @code = ""
      @attemps = 0
      generate_code(4)
      @guess = ""
    end

    def start
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
      clear
      res = false

      loop do
        new_guess = @input.gets
        new_guess.delete!("\n")
        next if enter_guess(new_guess) == "incorrect data"
        @attemps += 1 
        if  new_guess == @code
          res = true
          break
        end
        if  @attemps == @max_attemps
          res = false
          break
        end
        @output.puts new_guess == "hint\n" ? hint : check
        # if new_guess == "hint"
        #   @output.puts hint
        # else
        #   enter_guess(new_guess)
        #   if check == "+"*@code.length
        #     result = "Codebreaker you win!"
        #     @output.puts result
        #     break
        #   else
        #     if @attemps == @max_attemps
        #       result = "Codebreaker you lose! Secret code - #{@code}"
        #       @output.puts result
        #       break
        #     else
        #       @output.puts check
        #       @attemps += 1
        #     end
        #   end
        # end
      end
      result(res)
      @output.puts "Codebreaker please enter your name"
      name = @input.gets
      save_to_file(name,res)
      @output.puts "Do you want to play again ?(y/n)"
      answer = @input.gets
      start if answer == "y\n"
    end

    def hint
      str = "*"*@code.length
      index = rand(0..@code.length-1)
      str[index] = @code[index] 
      str     
    end

    def result(bool)
      @output.puts bool ? "Codebreaker you win!" : "Codebreaker you lose! Secret code - #{@code}"
      @output.puts "You have used #{@attemps} attemps"
    end
    def check
      array = @code.each_char
      result = "" 
      @code.length.times do |i|   
        if  @code[i] == @guess[i]
          result += "+"
        elsif  array.include?(@guess[i])
          result += "-"
        end  
      end
      result
    end
    def enter_guess(guess)
      return "incorrect data" if (guess.length != 4) or (guess =~ /\D|[7890]/)
      @guess = guess
    end
    def save_to_file(name,result)
      f = File.open("test.txt", "a+")
      f.puts "#{name.chomp} victory:'#{result}' with attemps - #{@attemps}"
    end
  end
end