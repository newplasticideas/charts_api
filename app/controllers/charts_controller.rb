class ChartsController < ApplicationController
  before_action :setup!, only: [:get]

  # example URL: localhost:3000/get?from_date=20-Nov-18&to_date=20-Dec-18&num=6
  def get
    render json: {
      values: @values,
      total_participants: @total_participants,
      total_employees: @total_employees
    }
  end

  private

  def setup!
    set_totals
    set_dates  # sets @from and @to based on dates in params
    set_x_num  # sets @number_of based on params
    set_values # runs a block @number_of times to create @values array
  end

  def set_dates
    @from = Time.parse(params[:from_date])
    @to = Time.parse(params[:to_date])
  end

  def set_x_num
    @number_of = params[:num].to_i
  end

  def set_values
    values = []
    @number_of.times do
      values << build_hash
    end
    @values = sort_values(values) # sort by date, then reverse! we can tack it onto the front of the client side array easily that way.
  end

  def build_hash
    build_data # sets @top, @bottom and @avg
    {
      date: random_date,
      top: @top,
      bottom: @bottom,
      average: @avg
    }
  end

  def build_data
    @top = data_options.sample
    @bottom = data_options.select {|n| n <= @top}.sample
    @avg = (@top + @bottom) / 2
  end

  def data_options
    [0, 25, 50, 75, 100]
  end

  def random_date
    Time.at(@from + rand * (@to.to_f - @from.to_f))
  end

  def sort_values(arr)
    arr.sort {|a,b| b[:date].to_time.to_i <=> a[:date].to_time.to_i}.reverse!
  end

  def set_totals
    @total_employees = rand(400)
    @total_participants = rand(@total_employees)
  end

end
