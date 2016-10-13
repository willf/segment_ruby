require "spec_helper"

describe SegmentRuby do
  it "has a version number" do
    expect(SegmentRuby::VERSION).not_to be nil
  end

  it "initializes defaults correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.model).to eq('small')
    expect(a.max_word_length).to eq(20)
    path, filename = File.split(a.total_file_name('2_'))
    expect(path).to end_with("small")
    expect(filename).to eq("2_total.tsv")
    path, filename = File.split(a.freq_file_name('2_'))
    expect(path).to end_with("small")
    expect(filename).to eq("2_frequencies.tsv")
  end

  it "initializes non-defaults correctly" do
    a = SegmentRuby::Analyzer.new(model='twitter',max_word_length=10)
    expect(a.model).to eq('twitter')
    expect(a.max_word_length).to eq(10)
  end

  it "loads small data correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.log_Pr("the")).to be > a.log_Pr("The")
  end

  it "loads bigram small data correctly" do
    a = SegmentRuby::Analyzer.new
    expect(a.log_CPr("dog", "the")).to be > a.log_CPr("dog", "a")
  end

  it "splits like a boss" do
    a = SegmentRuby::Analyzer.new
    expect(a.splits("abc")).to eq([["a", "bc"], ["ab", "c"], ["abc", ""]])
  end

  it "segments like a boss" do
    a = SegmentRuby::Analyzer.new
    expect(a.segment("theboywholived")).to eq(["the", "boy", "who", "lived"])
  end

end
