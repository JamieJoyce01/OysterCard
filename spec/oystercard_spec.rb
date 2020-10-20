require "oystercard"

describe OysterCard do
  describe "#balance" do
    it "responds" do
      expect(subject).to respond_to(:balance)
    end

    it "expects starting balance to be 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "responds" do
      expect(subject).to respond_to(:top_up).with(1).arguments
    end

    it "returns new value" do
      expect(subject.top_up(10)).to eq 10
    end

    it "returns a changed balance" do
      expect { subject.top_up(20) }.to change { subject.balance }.by(20)
    end

    it "errors if balance will be greater than £90" do
      amount = 91
      expect {subject.top_up(91)}.to raise_error "Error: adding #{amount} will exceed the maximum value of #{subject.MAX_AMOUNT}"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).arguments }

    it "checks the new balance after the deduction" do
      subject.top_up(10)
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end
end
