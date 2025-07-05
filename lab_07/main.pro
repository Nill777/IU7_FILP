DOMAINS
    surname = string
    phone = string
    city = string
    street = string
    house_num = integer
    flat_num = integer
    address = address(city, street, house_num, flat_num)
    
    brand = string
    color = string
    cost = integer
    car_number = string

PREDICATES
    nondeterm person(surname, phone, address)
    nondeterm car(surname, brand, color, cost, car_number)
    nondeterm search_owner(brand, color, surname, city, phone)

CLAUSES
    person("Ivanov", "8-900-111-22-33", address("Moscow", "Lenina", 5, 12)).
    person("Ivanov", "8-900-555-66-77", address("Moscow", "Lenina", 5, 12)).
    person("Petrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Bobrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Zebrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Debrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Sidorov", "8-902-333-44-55", address("Saint-Petersburg", "Nevsky", 20, 7)).

    car("Ivanov", "Toyota", "red", 1500000, "A123BC77").
    car("Ivanov", "Lada", "black", 500000, "B456DE78").
    car("Petrov", "BMW", "blue", 3000000, "C789FG79").
    car("Sidorov", "Toyota", "red", 2000000, "D012HI80").

    search_owner(Brand, Color, Surname, City, Phone) :-
        car(Surname, Brand, Color, _, _),
        person(Surname, Phone, address(City, _, _, _)).

GOAL
    %person("Petrov", _, address("Tula", _, _, _)).
    %person("Petrov", _, address(_, _, _, _)).
    %car("Petrov", "BMW", _, _, _).
    %person("Ivanov", Phone, address(_, _, _, _)).
    %person(Surname, "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    search_owner("Toyota", "red", Surname, City, Phone).