class RPNCalculator
  def initialize
    @equation_arr = []
  end


  def push(num)
    @equation_arr << num
  end

  def plus
    raise "calculator is empty" if @equation_arr.empty?
    dummy_arr = [@equation_arr.pop, @equation_arr.pop].reverse
    @value = dummy_arr.inject(:+)
    @equation_arr.push(@value)
  end

  def minus
    raise "calculator is empty" if @equation_arr.empty?
    dummy_arr = [@equation_arr.pop, @equation_arr.pop].reverse
    @value = dummy_arr.inject(:-)
    @equation_arr.push(@value)
  end

  def divide
    raise "calculator is empty" if @equation_arr.empty?
    dummy_arr = [@equation_arr.pop.to_f, @equation_arr.pop.to_f].reverse
    @value = dummy_arr.inject(:/)
    @equation_arr.push(@value)
  end

  def times
    raise "calculator is empty" if @equation_arr.empty?
    dummy_arr = [@equation_arr.pop, @equation_arr.pop].reverse
    @value = dummy_arr.inject(:*)
    @equation_arr.push(@value)
  end

  def tokens(string)
    nums = ("0".."9").to_a
    new_str = string.delete(" ").split("")
    final_arr = []
    new_str.each do |x|
      if nums.include?(x)
        final_arr << x.to_i
      else
        final_arr << x.to_sym
      end
    end
    final_arr
  end

  def evaluate(string)
    into_array = tokens(string)
    @equation_arr = into_array - [:+,:-,:*,:/]
    into_array.each{|x|
      if x.class == Symbol
        if x == :+
          plus
        elsif x == :*
          times
        elsif x == :-
          minus
        elsif x == :/
          divide
        end
      end
    }
    value
  end

  def value
    @value
  end

end
