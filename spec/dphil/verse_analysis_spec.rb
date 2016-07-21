# frozen_string_literal: true
require "spec_helper"
require "support/sample_verses"
require "support/sample_verses_defective"

describe Dphil::VerseAnalysis do
  include_context "sample_verses"
  include_context "sample_verses_defective"

  it "returns syllables of a string" do
    sample_verses.each do |v|
      expect(described_class.syllables(v["verse"])).to eq(v["syllables"])
    end
  end

  it "returns correct weights of corresponding syllables" do
    sample_verses.each do |v|
      expect(described_class.syllables_weights(v["syllables"])).to eq(v["weights"].gsub(/\s+/, ""))
    end
  end

  it "combines syllable and weight function into one method" do
    sample = sample_verses.first
    expect(described_class.verse_weight(sample["verse"])).to eq(sample["weights"].gsub(/\s+/, ""))
  end

  it ".identify returns information about a verse" do
    sample = sample_verses.first
    a = described_class.identify(sample["verse"])
    expect(a).to be_kind_of(Hash)
  end

  it ".identify returns exact matches for sample set" do
    sample_verses.each do |v|
      a = described_class.identify(v["verse"])
      expect(a).to be_kind_of(Hash)
      expect(a[:status]).to eq("exact match")
      expect(a[:meter]).to eq(v["meter"])
      expect(a[:padas].join("")).to eq(v["verse"].gsub(/\s+/, " ").strip)
    end
  end

  # it ".identify returns useful information for a defective sample" do
  #   v = "kṣmābhṛtpuṃgava kośakandaramukhānnirgatya te saṃgara
  #     krīḍāsūnmadavairivāraṇaghaṭākumbhasthalīḥ pāṭayan
  #   daṃṣṭrālo navalagnamoktikamaṇistomairamṛglekhayā
  #     jihvālaḥ karavāla eṣa tanute śārdūlavikrīḍitam"


  #   a = described_class.identify(v)

  #   ap a
  #   b = described_class.find_mid(v)

  #   ap b

  #   # expect(a).to be_kind_of(Hash)
  #   # expect(a[:status]).to eq("fuzzy match")
  # end

  # it ".identify returns useful information for a defective sample" do
  #   v = "kṣetre kuru
  #      yuyutsavaḥ
  #   māmakāḥ pāṇḍavāś caiva
  #     kim akur saṃjaya"
  #   a = described_class.find_mid(v)

  #   ap a

  #   # expect(a).to be_kind_of(Hash)
  #   # expect(a[:status]).to eq("fuzzy match")
  # end
end
