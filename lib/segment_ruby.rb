require "segment_ruby/version"
require 'pathname'

# Based on "Natural Language Corpus Data"
# from the book "Beautiful Data" (Segaran and Hammerbacher, 2009)
# by Peter Novig

module SegmentRuby

  LOG_1 = Math.log2(1)

  class ProbabilityDistribution
    def initialize(total_file_name, data_file_name)
      @total_file_name = total_file_name
      @data_file_name = total_file_name

      begin
        total = File.read(total_file_name).to_i
        @log_total = Math.log2(total)
      rescue
        @log_total = Math.log2(10**1000)
      end

      @table = Hash.new { |w| -Float::INFINITY }

      File.open(data_file_name).each_line do |line|
        data = line.split(/\s/)
        freq = data[-1].to_i
        keys = data[0..-2]
        key = keys.join(' ')
        log_p = Math.log2(freq) - @log_total

        @table[key] = log_p
      end

      true
    end

    attr_reader :log_total, :table

    def files
      [@total_file_name, @data_file_name]
    end

    def log_prob(w)
      table[w]
    end

    def prob(w)
      2**table[w]
    end

    def total
      2**log_total
    end

    def has_key?(w)
      table.has_key?(w)
    end
  end

  class Analyzer
    def initialize(model='small', max_word_length=20)
      @model = model
      @max_word_length = max_word_length

      # unigram log probabilities
      @ulp = ProbabilityDistribution.new(total_file_name(''), freq_file_name(''))

      # bigram log probabilities
      btf = total_file_name('2_')
      bff = freq_file_name('2_')
      @blp = (File.exists?(btf) and File.exists?(bff) ? ProbabilityDistribution.new(btf, bff) : false)

      true
    end

    attr_reader :blp, :max_word_length, :model, :ulp

    def log_Pr(w)
      ulp.log_prob(w)
    end

    def log_CPr(w, prev)
      key = [prev, w].join(' ')

      blp and blp.has_key?(key) ? blp.log_prob(key) : ulp.log_prob(w)
    end

    def total_file_name(prefix)
      File.join(__dir__, "..", "data", "segment_ruby", model, prefix + 'total.tsv')
    end

    def freq_file_name(prefix)
      File.join(__dir__, "..", "data", "segment_ruby", model, prefix + 'frequencies.tsv')
    end

    # Returns all the splits of a string up to a given length
    def splits(text)
      (0..[max_word_length, text.size-1].min).map { |i| [text[0..i], text[i+1..text.size]] }
    end

    def combine(pFirst, first, segmented)
      pRem,rem = segmented

      [pFirst+pRem, [first]+rem]
    end

    def segment_r(text, prev, n, memo)
      return [0.0, []] if not text or (text.size == 0)
      return memo[text] if memo.has_key?(text)

      log_p_segment = splits(text).map do |first, rem|
         log_p = log_CPr(first, prev)
         combine(log_p, first, segment_r(rem, first, n+1, memo))
      end.max

      memo[text] = log_p_segment

      log_p_segment
    end

    def segment(text, prev='<S>')
      p, segmentation = segment_r(text, prev, 0, Hash.new)

      segmentation
    end
  end
end
