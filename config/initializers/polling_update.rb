Thread.new do
  while true
    QuoteSet.poll
    sleep 60
  end
end
