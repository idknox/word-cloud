require "JSON"

class WordCloud
  def initialize(quotes)
    @quotes = quotes
  end


  def make_cloud
    quotes_hash = get_quotes_hash
    build_output(quotes_hash)
  end

  private

  def get_quotes_hash
    JSON.parse(@quotes)
  end

  def build_output(quotes_hash)
    output = {}
    quotes_hash.each do |author, quotes|
      quotes.each do |quote|
        quote.split(" ").each do |word|
          word.downcase!
          unless output[word]
            output[word] = build_word_hash(author)
          end

          unless output[word][:people].include?(author)
            output[word][:people] << author
          end
          output[word][:count] += 1
        end
      end
    end
    output
  end

  def build_word_hash(author)
    {
      :count => 0,
      :people => [author]
    }
  end

end