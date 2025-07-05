DOMAINS
    surname = string
    phone = string
    city = string
    street = string
    house_num = integer
    flat_num = integer
    address = address(city, street, house_num, flat_num)
    
    bank = string
    account, amount = integer
    
    title, type, brand, color = string
    state_number = string
    area, price = real
    floors = integer
    
    property = 
        car(title, brand, color, price, state_number);
        building(title, price, area, floors);
        land(title, price, area);
        watercraft(title, price, brand, color).

PREDICATES
    nondeterm person(surname, phone, address)
    nondeterm depositor(surname, bank, account, amount)
    nondeterm owner(surname, property)
    
    nondeterm property_title(property, title)
    nondeterm property_title_price(property, title, price)
    nondeterm properties_title_by_surname(surname, title)
    nondeterm properties_title_price_by_surname(surname, title, price)
    
    nondeterm cost(surname, type, price)
    nondeterm total_property_price(surname, price)

CLAUSES
    person("Ivanov", "8-900-111-22-33", address("Moscow", "Lenina", 5, 12)).
    person("Ivanov", "8-900-555-66-77", address("Moscow", "Lenina", 5, 12)).
    person("Petrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Bobrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Zebrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Debrov", "8-901-222-33-44", address("Tula", "Pushkina", 10, 3)).
    person("Sidorov", "8-902-333-44-55", address("Saint-Petersburg", "Nevsky", 20, 7)).

    depositor("Ivanov", "AlphaBank", 1001, 50000).
    depositor("Ivanov", "BetaBank", 2002, 120000).
    depositor("Petrov", "GammaBank", 3003, 75000).
    depositor("Bobrov", "DeltaBank", 4004, 30000).
    depositor("Sidorov", "OmegaBank", 5005, 250000).

    owner("Ivanov", car("Car1", "Citroen", "red", 1500000, "A123BC77")).
    owner("Ivanov", car("Car2", "Lada", "black", 500000, "B456DE78")).
    owner("Zebrov", car("Car3", "BMW", "blue", 3000000, "C789FG79")).
    owner("Sidorov", car("Car4", "Citroen", "green", 2000000, "D012HI80")).
    owner("Ivanov", building("Office", 5000000.0, 150.5, 3)).
    owner("Bobrov", building ("Camp", 1000000.0, 2000.0, 4)).
    owner("Bobrov", land("Farm", 1000000.0, 2000.0)).
    owner("Zebrov", watercraft("Boat", 800000.0, "Yamaha", "white")).

    property_title(car(Title, _, _, _, _), Title).
    property_title(building(Title, _, _, _), Title).
    property_title(land(Title, _, _), Title).
    property_title(watercraft(Title, _, _, _), Title).

    property_title_price(car(Title, _, _, Price, _), Title, Price).
    property_title_price(building(Title, Price, _, _), Title, Price).
    property_title_price(land(Title, Price, _), Title, Price).
    property_title_price(watercraft(Title, Price, _, _), Title, Price).

    properties_title_by_surname(Surname, Title) :- 
        owner(Surname, Property), 
        property_title(Property, Title).

    properties_title_price_by_surname(Surname, Title, Price) :- 
        owner(Surname, Property), 
        property_title_price(Property, Title, Price).

    cost(Surname, "car", Cost) :- 
        owner(Surname, car(_, _, _, Cost, _)), !.
    cost(Surname, "building", Cost) :- 
        owner(Surname, building(_, Cost, _, _)), !.
    cost(Surname, "land", Cost) :- 
        owner(Surname, land(_, Cost, _)), !.
    cost(Surname, "watercraft", Cost) :- 
        owner(Surname, watercraft(_, Cost, _, _)), !.
    cost(_, _, 0).

    total_property_price(Surname, Price) :-
        cost(Surname, "car", CarPrice),
        cost(Surname, "building", BuildingPrice),
        cost(Surname, "land", LandPrice),
        cost(Surname, "watercraft", WaterPrice),
        Price = CarPrice + BuildingPrice + LandPrice + WaterPrice.

GOAL
    %properties_title_by_surname("Zebrov", Title).
    properties_title_price_by_surname("Bobrov", Title, Price).
    %total_property_price("Ivanov", Total).