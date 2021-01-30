require "connect_four"


describe ConnectFour do
  
  context "makes an array" do

    subject(:game_array) { described_class.new }

    it "sends a message " do
      expect(game_array).to receive(:make_array)
      game_array.make_array
    end

  end

  context "show board" do
    
    subject(:game_board) { described_class.new }

    it "sends a message " do
      expect(game_board).to receive(:show_board)
      game_board.show_board
    end

  end

  context "validates number " do
    
    subject(:game_validate) { described_class.new }

    it "number is between 1 and 7" do
      valid_number = 5
      validate = game_validate.validate_number(valid_number)
      expect(validate).to eq(5)
    end


    it "number is lower " do
      low_number = 0
      validate = game_validate.validate_number(low_number)
      expect(validate).to be_nil
    end

    it "number is higher " do
      high_number = 8
      validate = game_validate.validate_number(high_number)
      expect(validate).to be_nil
    end

  end

  context "validate name" do 

    subject(:game_name) { described_class.new }
    
    it "returns a name" do
      valid_name = "emma"
      expect(game_name.validate_name(valid_name)).to eq("emma")
    end

    it "works with capitale letter" do
      upcase_name = "Anna"
      valid_upcase = game_name.validate_name(upcase_name)
      expect(valid_upcase).to eq("Anna")
    end

    it "returns nil" do
      number = "1"
      invalid_name = game_name.validate_name(number)
      expect(invalid_name).to be_nil
    end

  end

end