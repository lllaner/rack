class App

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path_info == '/time'
      FormatTime.new(@request).call
    else
      [404, headers, ['Page Not found']]
    end
  end


  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

end
