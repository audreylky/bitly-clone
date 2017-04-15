require 'csv'
require 'SecureRandom'
require 'Benchmark'

urls_arr = []


CSV.foreach("db/urls.csv") do |row|
	long_url = row[0].match(/http:\/\/.+\)/).to_s.delete(")")
	# short_url = SecureRandom.hex(3.5)
	short_url = (("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(7).join("")
	urls_arr << "('#{long_url}', '#{short_url}', 0)"
end

urls = urls_arr.join(",") + ";"

puts Benchmark.measure {
	Url.transaction do
	  Url.connection.execute "INSERT INTO urls (long_url, short_url, counter) VALUES #{urls}"
	end
}




##=========================
## This method takes 4m30s
##=========================
# @long_arr = []

# CSV.foreach("db/urls.csv") do |row|
# 	url = row[0].to_s.chomp
# 	# p url

# 	#get rid of the brackets
# 	url[0] =""
# 	url[-1] = ""
# 	# p url
# 	@long_arr << url
# end

# Url.transaction do
# 	@long_arr.each do |url|
#   	Url.connection.execute("INSERT INTO urls (long_url, short_url, counter) VALUES ('#{url}', '#{SecureRandom.hex(3)}', 0)")
#   end
# end

##=========================
## This method will take 1.5 hours
##=========================
# 1:44 secs for 20000 urls 
# Url.transaction do
# 	CSV.foreach("db/urls.csv") do |row|
# 	  url = row.to_s

# 	  #get rid of the brackets
# 	  url[0] =""
# 	  url[-1] = ""

# 	  Url.create(long_url: url)
#   end
# end