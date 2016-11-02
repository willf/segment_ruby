require_relative "./segment_ruby/version"
require 'pathname'

# Based on "Natural Language Corpus Data"
# from the book "Beautiful Data" (Segaran and Hammerbacher, 2009)
# by Peter Novig

module SegmentRuby

  class ProbabilityDistribution
    def initialize(total_filename, data_file_name)
      @total = File.read(total_filename).to_i rescue 10**1000
      @log_total = Math.log2(total)
      @log_probabilities_by_phrase = Hash.new { |w| -Float::INFINITY }

      File.open(data_file_name).each_line do |line|
        words_in_phrase_and_frequency = line.split(/\s/)
        frequency = words_in_phrase_and_frequency[-1].to_i
        words_in_phrase = words_in_phrase_and_frequency[0..-2]
        phrase = words_in_phrase.join(' ')
        log_probability = Math.log2(frequency) - log_total

        log_probabilities_by_phrase[phrase] = log_probability
      end
    end

    attr_reader :total
    attr_reader :log_total
    attr_reader :log_probabilities_by_phrase

    def log_probability(phrase)
      log_probabilities_by_phrase[phrase]
    end

    def probability(phrase)
      2**log_probabilities_by_phrase[phrase]
    end

    def has_phrase?(phrase)
      log_probabilities_by_phrase.has_key?(phrase)
    end
  end

  class Analyzer
    def initialize(corpus_name=:small, max_word_length=20)
      @corpus_name = corpus_name
      @max_word_length = max_word_length

      @unigram_log_probabilities =
        ProbabilityDistribution.new(total_filename, frequency_filename)

      @bigram_log_probabilities =
        if (File.exists?(total_filename('2_')) && File.exists?(frequency_filename('2_')))
          ProbabilityDistribution.new(total_filename('2_'), frequency_filename('2_'))
        else
          false
        end
    end

    attr_reader :corpus_name
    attr_reader :unigram_log_probabilities
    attr_reader :bigram_log_probabilities
    attr_reader :max_word_length

    def log_probability(word)
      unigram_log_probabilities.log_probability(word)
    end

    def conditional_log_probability(word, previous_word)
      phrase = [previous_word, word].join(' ')

      if bigram_log_probabilities && bigram_log_probabilities.has_phrase?(phrase)
        bigram_log_probabilities.log_probability(phrase)
      else
        unigram_log_probabilities.log_probability(word)
      end
    end

    def total_filename(prefix='')
      File.join(corpus_path, prefix + 'total.tsv')
    end

    def frequency_filename(prefix='')
      File.join(corpus_path, prefix + 'frequencies.tsv')
    end

    def corpus_path
      @corpus_path ||= File.join(__dir__, "..", "data", "segment_ruby", corpus_name.to_s)
    end

    # Returns all the splits of a string up to a given length. Example:
    #
    # [
    #   ["i", "amone"],
    #   ["ia", "mone"],
    #   ["iam", "one"],
    #   ["iamo", "ne"],
    #   ["iamon", "e"],
    #   ["iamone", ""]
    # ]
    #
    # Returns an Array of arrays of text splits (head and tail).
    def splits(text)
      (0..[max_word_length, text.size-1].min).
        map { |i| [text[0..i], text[i+1..text.size]] }
    end

    def combine(word_log_probability, word, segmented)
      remaining_words_log_probability, remaining_words = segmented

      [word_log_probability+remaining_words_log_probability, [word]+remaining_words]
    end

    def recursive_segment(text, previous_word, n, recursive_segment_cache)
      return [0.0, []] if (!text) || (text.size == 0)
      return recursive_segment_cache[text] if recursive_segment_cache.has_key?(text)

      segment_log_probability = splits(text).map do |head, tail|
         log_probability = conditional_log_probability(head, previous_word)
         combine(log_probability, head, recursive_segment(tail, head, n+1, recursive_segment_cache))
      end.max

      recursive_segment_cache[text] = segment_log_probability

      segment_log_probability
    end

    def segment(text, previous_word='<S>')
      _, segmentation = recursive_segment(text, previous_word, 0, Hash.new)

      segmentation
    end
  end
end
