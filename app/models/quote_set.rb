require 'open-uri'

class QuoteSet < ApplicationRecord
  has_many :quotes, autosave: true
  after_create_commit do
    ActionCable.server.broadcast 'quotes', {
      type: 'quote',
      quotes: self.quotes
    }
  end

  def poll
    Hash.from_xml(open("http://rates.fxcm.com/RatesXML").read)['Rates']['Rate'].each do |h|
      quotes.build(Hash[h.map {|k,v| [k.downcase, v]}])
    end
    save!
  end

  def self.poll
    new.poll
  end

end
