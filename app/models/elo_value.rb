class EloValue
  attr_reader :value, :date

  def initialize(args)
    @date = args.fetch(:date)
    @value = args.fetch(:value)
  end
end
