class FormatTime
  FORMATS = {
    'year' => '%Y-',
    'month' => '%m-',
    'day' => '%d ',
    'hour' => '%H:',
    'minute' => '%M:',
    'second' => '%S'
  }.freeze

  def initialize(request)
    @params = request.params['format'].split(',')
    @unknown_params = []
    @time = ''
  end

  def call
    parse
    if @unknown_params.empty?
      Rack::Response.new(Time.now.strftime(@time), 200, { 'Content-Type' => 'text/plain' }).finish
    else
      Rack::Response.new("Unknown time format #{@unknown_params}", 400, { 'Content-Type' => 'text/plain' }).finish
    end
  end

  private

  def parse
    @params.each do |value|
      if FORMATS[value]
        @time += FORMATS[value]
      else
        @unknown_params << value
      end
    end
  end

end
