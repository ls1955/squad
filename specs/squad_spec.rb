require_relative "../lib/squad"

RSpec.describe SQUAD do
  let(:dummy_json) { "dummy.json" }
  let(:empty_json_str) { "{\"version\":\"v2.0\",\"data\":[]}" }
  subject { described_class.new(dummy_json) }

  before(:example) do
    File.open(dummy_json, "w") do |f|
      f.write empty_json_str
    end
  end

  describe "#data_at" do
    context "when given title did not exist" do
      it "returns an empty template" do
        exp = {"title" => "not_exist", "paragraphs" => []}
        expect(subject.data_at("not_exist")).to eq exp
      end

      it "add the new data into itself" do
        subject.data_at("not_exist")
        exp = "{\"version\":\"v2.0\",\"data\":[{\"title\":\"not_exist\",\"paragraphs\":[]}]}"
        expect(subject.to_json).to eq exp
      end
    end
  end

  describe "#to_json" do
    it "returns a json parsable format" do
      expect(subject.to_json).to eq empty_json_str
    end
  end

  after(:example) do
    File.delete dummy_json
  end
end
