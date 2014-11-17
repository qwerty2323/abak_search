class PersonRequest
  attr_accessor :age, :salary, :height, :weight

  def initialize
    @age = 0..100
    @salary = 0..10**6
    @height = 0..200
    @weight = 0..200
  end

  # Применить запрос к данным. Используется самый примитивный алгоритм, нужно для проверки валидности алгоритма.
  # @param [Array] people
  def test(people)
    people.select do |person|
      self.age.include? person.age and
          self.salary.include? person.salary and
          self.height.include? person.height and
          self.weight.include? person.weight
    end
  end
end