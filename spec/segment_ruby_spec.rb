require "spec_helper"

describe SegmentRuby do
  it "has a version number" do
    expect(SegmentRuby::VERSION).not_to be nil
  end

  it "initializes defaults correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.corpus_name).to eq(:small)
    expect(a.max_word_length).to eq(20)
    path, filename = File.split(a.total_filename('2_'))
    expect(path).to end_with("small")
    expect(filename).to eq("2_total.tsv")
    path, filename = File.split(a.frequency_filename('2_'))
    expect(path).to end_with("small")
    expect(filename).to eq("2_frequencies.tsv")
  end

  it "initializes non-defaults correctly" do
    a = SegmentRuby::Analyzer.new(:twitter, 10)
    expect(a.corpus_name).to eq(:twitter)
    expect(a.max_word_length).to eq(10)
  end

  it "loads small data correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.log_probability("the")).to be > a.log_probability("The")
  end

  it "loads bigram small data correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.conditional_log_probability("dog", "the")).to be > a.conditional_log_probability("dog", "a")
  end

  it "in the presence of no bigram data, still returns conditional probabilities" do
    a = SegmentRuby::Analyzer.new(:test_unigram)
    expect(a.conditional_log_probability("the", "or")).to eq(a.log_probability("the"))
  end

  it "in the presence of no bigram data, still returns segmentations" do
    a = SegmentRuby::Analyzer.new(:test_unigram)
    expect(a.segment("ofthe")).to eq(["of", "the"])
  end

  it "splits like a boss" do
    a = SegmentRuby::Analyzer.new
    expect(a.splits("abc")).to eq([["a", "bc"], ["ab", "c"], ["abc", ""]])
  end

  it "segments like a boss" do
    a = SegmentRuby::Analyzer.new
    expect(a.segment("theboywholived")).to eq(["the", "boy", "who", "lived"])
  end

  it "segements US names like a boss" do
    a = SegmentRuby::Analyzer.new(:us_names)
    expect(a.segment("abelincoln")).to eq(["abe", "lincoln"])
    expect(a.segment("susanbanthony")).to eq(["susan", "b", "anthony"])
  end

end
