class PersonTree # Реализация алгоритма k-d дерево.

  attr_accessor :person, :left, :right, :d

  def person_attributes
    %w(age salary height weight)
  end

  def k
    self.person_attributes.count
  end

  # @param [Array] Массив для инициализации хранилища
  # @param [Integer] текущее активное измерение
  def initialize(people=[], d=0)
    d = d % self.k
    @person = nil
    @left = nil
    @right = nil
    @d = d
    attr = person_attributes[self.d]
     # OPTIMIZE Искать медиану, и делить массив на 2 подмассива по медиане. Уменьшит высоту дерева.
    people.each { |person|
      insert(person)
    }
  end

  # @param [Person]
  def insert(person)
    if self.person.nil?
      self.person = person
    else
      attr = person_attributes[self.d]
      if person.send(attr) < self.person.send(attr)
        if left.nil?
          @left = PersonTree.new([person], self.d+1)
        else
         left.insert(person)
        end
      else
        if right.nil?
          @right = PersonTree.new([person], self.d+1)
        else
          right.insert(person)
        end
      end
    end
  end

  # @param [PersonRequest]
  def get(request)
    if self.person.nil?
      []
    else
      result = [self.person]
      person_attributes.each { |attr|
        unless request.send(attr).include? person.send(attr)
          result = []
          break
        end
      }
      attr = person_attributes[self.d]
      if not left.nil? and request.send(attr).min <= person.send(attr)
        result += left.get(request)
      end
      if not right.nil? and request.send(attr).max >= person.send(attr)
        result += right.get(request)
      end
      result
    end
  end

end