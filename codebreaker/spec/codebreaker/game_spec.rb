require 'spec_helper'
 
module Codebreaker
  describe Game do
      let(:output) { double('output').as_null_object }
      let(:game)   { Game.new(output) }
    describe "#start" do

      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start
      end
      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start
      end
    end
    
    describe "#check" do
      it "return mark of guess1" do
          game.code = "1234"
          game.enter_guess("1321")
          game.check.should == "+---"
          game.start
      end
      it "return mark of guess2" do
          game.code = "1234"
          game.enter_guess("1653")
          game.check.should == "+-"
          game.start
      end
      it "return mark of guess3" do
          game.code = "1222"
          game.enter_guess("1111")
          game.check.should == "+---"
          game.start
      end
    end

    describe "#guess" do
      it "sends warning when length of guess is incorrect" do
          game.enter_guess("12341").should == "incorrect data"
          game.start
      end
      it "sends warning when nubmers of guess are not in range(1..6)" do
          game.enter_guess("1329").should == "incorrect data"
          game.start
      end
      it "sends warning when include letter" do
          game.enter_guess("1a39").should == "incorrect data"
          game.start
      end
      it "sends warning when " do
          game.enter_guess("1 21").should == "incorrect data"
          game.start
      end
   end
  end
end