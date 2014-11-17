require 'time'
require './person'
require './person_request'
require './person_tree'


# Генерация случайных данных
people = (1..10**7).map do
  Person.new(rand(100), 10**6 * rand, rand(200), rand(200))
end

# Индексация
idx = PersonTree.new people

# Пример создания запроса
req = PersonRequest.new
req.age = 18..25
req.height=170..180
req.weight=75..85
req.salary=90000..300000

# Выполнение запроса
result = idx.get(req)

fail if result.count != req.test(people).count # проверяем, что результат похож на правильный