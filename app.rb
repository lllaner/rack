class App

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path_info == '/time'
     build_format
    else
      [404, headers, ['Page Not found']]
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end
  def build_format
    status, body =  FormatTime.new(@request).call
    [status, headers, body]
  end
end
