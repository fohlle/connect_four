
require "player"

describe Player do
  
  subject(:player_name) { described_class.new("name") }

  context "tests name" do
    
    it "returns choosen name" do
      expect(player_name.instance_variable_get(:@name)).to eq("name")
    end

  end

  context "tests icon" do
    subject(:player_icon) { described_class.new("anna") }
    subject(:icon_not_nil) { described_class.new("anna","one") }

    it "returns nil" do
      icon = player_icon.instance_variable_get(:@icon)
      expect(icon).to be_nil
    end

    it "returns not nil" do
      icon = icon_not_nil.instance_variable_get(:@icon)
      expect(icon).not_to be_nil
    end

  end

end