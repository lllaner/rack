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
    format_time =  FormatTime.new(@request)
    format_time.call
    if format_time.success?
      build_response(format_time.time, 200)
    else
      build_response(format_time.errors, 400)
    end
  end

  def build_response(body, status)
    Rack::Response.new(body, status, headers).finish
  end
end
