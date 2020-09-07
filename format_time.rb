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
      [200, [Time.now.strftime(@time)]]
    else
      [400, ["Unknown time format:#{@unknown_params}"]]
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
