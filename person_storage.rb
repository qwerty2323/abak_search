class Array
  # Добавление элемента в отсортированный массив.
  def push_sorted(el)
    self.push(el)
    i = self.count-1
    while i > 0 and yield(self[i], self[i-1]) < 0
      self[i], self[i-1] = self[i-1], self[i]
      i -= 1
    end
  end
end

class PersonStorage
  attr_accessor :storage

  # @param [Array] Массив для инициализации хранилища
  def initialize(people=[])
    @storage = (0..100).map {
      (0..200).map {
        (0..200).map { [] }
      }
    } # создать и инициализировать. Array,new , судя по всему, не инициализирует, 
    people.each { |person|
      insert(person)
    }
  end

  # @param [Person]
  def insert(person)
    # OPTIMIZE вставлять элементы без сортировки, потом овать массив, когда нужно сделать к нему запрос.
    #  Ускорит построение индекса.
    self.storage[person.age][person.height][person.weight].push_sorted(person) {|a, b|
      a.salary <=> b.salary
    }
  end

  # @param [PersonRequest]
  def get(request)
    result = []
    storage[request.age].each { |a|
      a[request.height].each { |b|
        b[request.weight].each { |c|
          if c.count > 0
            l = 0
            r = c.count
            m = (l+r)/2
            until (m-1 < 0 or c[m-1].salary < request.salary.min) and (m >= c.count or c[m].salary >= request.salary.min)
              if c[m].salary < request.salary.min
                l = m
              else
                r = m
              end
              if r-l <= 1
                m = l
                break
              else
                m = (l+r)/2
              end
            end
            left = m

            l = 0
            r = c.count
            m = (l+r)/2
            until (m+1 > c.count-1 or c[m+1].salary > request.salary.max) and (m < 0 or c[m].salary <= request.salary.max)
              if c[m].salary > request.salary.max
                r = m
              else
                l = m
              end
              if r-l <= 1
                m = r
                break
              else
                m = (l+r)/2
              end
            end
            right = m
            while left < c.count and c[left].salary < request.salary.min
              left +=1
            end
            while right >= 0 and c[right].salary > request.salary.max
              right -=1
            end
            if right >= 0
              result+=c[left..right]
            end
          end
        }
      }
    }
    result
  end

end