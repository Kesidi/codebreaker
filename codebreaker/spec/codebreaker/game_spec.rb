require 'spec_helper'
 
module Codebreaker
  describe Game do
      let(:output) { double('output').as_null_object }
      let(:input) { double('input').as_null_object }
      let(:game)   { Game.new(output, input) }
    describe "#start" do
      it "sends a welcome message" do
        game.code = "1234"
        game.guess = "1234"
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        input.should_receive(:gets).and_return("1234")
        game.stub(:enter_guess).and_return("1234")
        game.start
      end
      it "prompts for the first guess" do
        game.code = "1234"
        game.guess = "1234"
        output.should_receive(:puts).with('Enter guess:')
        game.stub(:enter_guess).and_return("1234")
        input.should_receive(:gets).and_return("1234") 
        game.start
      end
    end
    describe "#result" do
      it "prompts victory" do
        output.should_receive(:puts).with("Codebreaker you win!")
        game.result(true)
      end
      it "prompts defeat" do
        game.code = "1234"
        output.should_receive(:puts).with("Codebreaker you lose! Secret code - #{game.code}")
        game.result(false)
      end
      it "prompts count attemps" do
        game.attemps = 5
        output.should_receive(:puts).with("You have used #{game.attemps} attemps")
        game.result(true)
      end
    end
    describe "$hint" do
      it "check position and value number of hint" do
        game.code = "1234"
        res = game.hint
        num = (res =~ /\d/)
        game.code[num].should eq(res[num])
      end
    end
    describe "#check" do
      it "return mark of guess1" do
        game.code = "1234"
        game.enter_guess("1321")
        game.check.should == "+---"
      end
      it "return mark of guess2" do
        game.code = "1234"
        game.enter_guess("1653")
        game.check.should == "+-"
      end
      it "return mark of guess3" do
        game.code = "1222"
        game.enter_guess("1111")
        game.check.should == "+---"
      end

    end

    describe "#guess" do
      it "sends warning when length of guess is incorrect" do
        game.enter_guess("12341").should == "incorrect data"
      end
      it "sends warning when nubmers of guess are not in range(1..6)" do
        game.enter_guess("1329").should == "incorrect data"
      end
      it "sends warning when include letter" do
        game.enter_guess("1a39").should == "incorrect data"
      end
      it "sends warning when " do
        game.enter_guess("1 21").should == "incorrect data"
      end

   end
  end
end