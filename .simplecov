SimpleCov.start do
  add_filter '/spec/'
end

SimpleCov.at_exit do
  SimpleCov.result.format!
end
