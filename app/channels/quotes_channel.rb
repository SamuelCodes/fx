class QuotesChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'quotes'
  end

  def receive(data)
    ActionCable.server.broadcast('message', data)
  end

  def request_for_quote(data)
    ActionCable.server.broadcast('quotes', {
      type: 'quote',
      quotes: QuoteSet.last.quotes
    })
  end

end
