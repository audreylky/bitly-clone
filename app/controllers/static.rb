# the top will load first!

get '/' do
	puts "[LOG] Getting /"
  puts "[LOG] Params: #{params.inspect}"
  erb :"static/index"
end


####### after submitting the long url

post '/urls' do
	# puts params
	@url = Url.create(long_url: params[:long_url], short_url: params[:short_url], counter: 0)
	# p url
	if @url.valid?
		# redirect "/urls/#{url.short_url}" # string interpolation only work with " " not ' '
		return @url.to_json
		# want to display the success links

	else
		# @err = url.errors.full_messages
		# erb :'static/index'
		status 400
		return @url.errors.full_messages.join('. ')
	end
end

# # url profile to check stuff 
# get '/urls/:short_url' do
# 	short_url = params[:short_url]
# 	@url = Url.find_by(short_url: short_url)
# 	erb :'urls/profile'	# view file
# end

# redirect to the LONG url when people search
# if you put www.next.com/1as23d => {"short_url" => "1as23d"}. If not, it'll end up as {["splat" = ["1as23d"]]}
get '/:short_url' do	
	short_url = params[:short_url]
	@url = Url.find_by(short_url: short_url) # if exist, return; else nil
	if @url.nil?
		redirect '/'	# can change to "THE LINK DOESN'T EXIST!"
	else
		@url.update_counter
		p @url.counter
		redirect @url.long_url # redirect 'www.google.com' #=> localhost:9393/www.google.com
	end
end

####################################

### ANOTHER METHOD - REFRESH ENTIRE TABLE

# post '/url' do
#   @all_url = Url.all.order("created_at DESC")
#   @url = Url.new(params[:url])
#   if @url.save
#     # return @url.to_json
#     erb :"static/table", layout: false
#   else
#     status 400
#     return @url.errors.full_messages.join('. ')
#   end
# end

