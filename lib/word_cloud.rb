require "JSON"

class WordCloud
  def initialize(quotes)
    @quotes = quotes
  end


  def make_cloud
    output = {}
    quotes_hash = get_quotes_hash

    quotes_hash.each do |author, quotes|
      quotes.each do |quote|
        quote.split(" ").each do |word|
          word.downcase!
          if output[word] && !output[word][:people].include?(author)
            output[word][:people] << author
            output[word][:count] += 1
          elsif output[word]
            output[word][:count] += 1
          else
            output[word] = {
              :count => 1,
              :people => [author]
            }
          end
        end
      end
    end
    output
  end

  private

  def get_quotes_hash
    JSON.parse(@quotes)
  end
end