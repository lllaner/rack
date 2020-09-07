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

  def parse
    @params.each do |value|
      if FORMATS[value]
        @time += FORMATS[value]
      else
        @unknown_params << value
      end
    end
  end

  def success?
    @unknown_params.empty?
  end

  def time
    Time.now.strftime(@time)
  end

  def errors
    "Unknown params: #{@unknown_params}"
  end

end
