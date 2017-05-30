class Array
  def bubble_sort(&prc)
    dup=self.dup
    length=self.length
    counter=0
    if prc == nil
      prc = Proc.new { |num1, num2| num1 <=> num2}
    end
    dup.each_with_index do |val,idx|
      if dup[idx+1] == nil
        if counter > 0
          if prc.call(dup[idx - 1],dup[idx]) == 1
            return dup.bubble_sort!.reverse
          else
            return dup.bubble_sort!
          end
        else
          if prc.call(dup[idx-1],dup[idx]) == 1
            return dup.reverse
          else
            return dup
          end
        end
      end
      if dup[idx] > dup[idx+1]
        dup[idx],dup[idx+1]=dup[idx+1],dup[idx]
        counter+=1
      end
    end
  end

  def bubble_sort!
    # dup=self.dup
    length=self.length
    counter=0
    self.each_with_index do |val,idx|
      if self[idx+1] == nil
        if counter > 0
          return self.bubble_sort!
        else
          return self
        end
      end
      if self[idx] > self[idx+1]
        self[idx],self[idx+1]=self[idx+1],self[idx]
        counter+=1
      end
    end
  end



  def my_each(&block)
    length = self.length
    dup = self.dup
    i = 0
    while i < length
      block.call(dup[i])
      i += 1
    end
    self
  end

  def my_select(&block)
    new_array=[]
    self.my_each do |char|
      if block.call(char)
        new_array.push(char)
      end
    end
    new_array
  end

  def my_reject(&block)
    new_array =[]
    self.my_each do |char|
      if block.call(char)
        new_array
      else
        new_array.push(char)
      end
    end
    new_array
  end

  def my_any?(&block)
    self.my_each do |char|
      if block.call(char)
        return true
      end
    end
    false
  end

  def my_all?(&block)
    self.my_each do |char|
      unless block.call(char)
        return false
      end
    end
    true
  end

  def my_flatten
    my_array = []
    self.map do |el|
      if el.is_a?(Array)
        my_array.concat(el.my_flatten)
      else
        my_array.push(el)
      end
    end
    my_array
  end

  def my_zip(*arrays)
    fin_array=[]
    self.each_with_index do |el,idx|
      new_array=[el]
      arrays.each do |array|
        new_array.push(array[idx])
      end
      fin_array.push(new_array)
    end
    fin_array
  end

  def my_rotate(num = 1)
    self_dup = self.dup
    if num > 0
      i = 0
      while i < num
        self_dup = self_dup.push(self_dup.shift)
        i+=1
      end
    elsif num < 0
      i = 0
      while i < num.abs
        self_dup = self_dup.unshift(self_dup.pop)
        i +=1
      end
    end
    p self_dup
  end

  def my_join(arg = "")
    new_str = ""
    self.each do |char|
      new_str += char + arg
    end
    if arg == ""
      new_str
    else
      new_str[0...-arg.length]
    end
  end

  def my_reverse
    new_array = []
    num = self.length - 1
    num.downto(0) { |idx| new_array << self[idx]}
    p new_array
  end
end


def factors(num)
  new_array=[]
  (1..num).each do |value|
    if num % value == 0
      new_array.push(value)
    end
  end
  new_array
end


def substrings(string)
  new_array=[]
  i=0
  while i < string.length
    i2=i
    while i2 < string.length
      if new_array.include?(string[i..i2])
        new_array
      else
        new_array.push(string[i..i2])
      end
      i2+=1
    end
    i+=1
  end
  new_array
end


def subwords(word,dictionary)
  fin_array=[]
  new_array=substrings(word)
  new_array.each do |string|
    if dictionary.include?(string)
      fin_array.push(string)
    end
  end
  fin_array.sort
end

def doubler(array)
  array.map do |value|
    value * 2
  end
end

class Array
  def my_inject(&prc)
    acc=self[0]
    self[1..-1].each do |value|
      acc=prc.call(acc,value)
    end
    acc
  end
end

puts [5].my_inject{|sum,num| sum+num}
