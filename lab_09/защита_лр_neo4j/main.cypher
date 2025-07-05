MATCH (n) DETACH DELETE n;

CREATE 
  (leonid:Person {name: 'leonid'}),
  (boris:Person {name: 'boris'}),
  (egor:Person {name: 'egor'}),
  (maxim:Person {name: 'maxim'}),
  (anatoly:Person {name: 'anatoly'}),
  (irina:Person {name: 'irina'}),
  (konstantin:Person {name: 'konstantin'}),
  (vadim:Person {name: 'vadim'}),
  (maria:Person {name: 'maria'}),
  (dmitry:Person {name: 'dmitry'}),
  (svetlana:Person {name: 'svetlana'}),
  (yelena:Person {name: 'yelena'}),
  (lyubov:Person {name: 'lyubov'}),
  (natalia:Person {name: 'natalia'}),
  (olga:Person {name: 'olga'}),
  (anna:Person {name: 'anna'});

MATCH (p:Person), (c:Person)
WHERE 
  (c.name = 'leonid' AND p.name = 'boris') OR
  (c.name = 'egor' AND p.name = 'maxim') OR
  (c.name = 'maxim' AND p.name = 'anatoly') OR
  (c.name = 'irina' AND p.name = 'konstantin') OR
  (c.name = 'boris' AND p.name = 'vadim') OR
  (c.name = 'maria' AND p.name = 'dmitry') OR
  (c.name = 'anna' AND p.name = 'maxim')
CREATE (p)-[:FATHER_OF]->(c);

MATCH (p:Person), (c:Person)
WHERE 
  (c.name = 'leonid' AND p.name = 'maria') OR
  (c.name = 'egor' AND p.name = 'irina') OR
  (c.name = 'boris' AND p.name = 'svetlana') OR
  (c.name = 'irina' AND p.name = 'yelena') OR
  (c.name = 'maxim' AND p.name = 'lyubov') OR
  (c.name = 'maria' AND p.name = 'natalia') OR
  (c.name = 'anna' AND p.name = 'olga')
CREATE (p)-[:MOTHER_OF]->(c);

////
MATCH (x:Person)-[:FATHER_OF]->(child:Person)<-[:MOTHER_OF]-(y:Person)
CREATE (x)-[:SPOUSE]->(y), (y)-[:SPOUSE]->(x);

MATCH (husband:Person)-[:SPOUSE]-(wife:Person {name: 'svetlana'}),
      (husband)<-[:MOTHER_OF]-(motherInLaw:Person)
RETURN motherInLaw.name AS mother_in_law;

MATCH (son:Person)-[:FATHER_OF|MOTHER_OF]->(parent:Person {name: 'maria'}),
      (son)-[:SPOUSE]-(daughterInLaw:Person)
RETURN daughterInLaw.name AS daughter_in_law;

MATCH (spouse:Person)-[:SPOUSE]-(parent:Person {name: 'lyubov'}),
      (spouse)-[:FATHER_OF|MOTHER_OF]->(stepdaughter:Person)
WHERE NOT (parent)-[:FATHER_OF|MOTHER_OF]->(stepdaughter)
RETURN stepdaughter.name AS stepdaughter;
////


MATCH (x:Person), (y:Person)
WHERE 
  (x.name = 'natalia' AND y.name = 'dmitry') OR 
  (x.name = 'svetlana' AND y.name = 'vadim') OR 
  (x.name = 'maria' AND y.name = 'boris') OR 
  (x.name = 'yelena' AND y.name = 'konstantin') OR 
  (x.name = 'lyubov' AND y.name = 'anatoly') OR
  (x.name = 'irina' AND y.name = 'maxim') OR
  (x.name = 'olga' AND y.name = 'maxim')
CREATE (x)-[:SPOUSE]->(y), (y)-[:SPOUSE]->(x);


MATCH (x:Person {name: 'maria'})-[:SPOUSE]->(husband:Person),
      (mother:Person)-[:MOTHER_OF]->(husband)
RETURN mother.name AS свекровь;

MATCH (father:Person {name: 'vadim'})-[:FATHER_OF]->(son:Person),
      (son)-[:SPOUSE]->(daughterInLaw:Person)
RETURN daughterInLaw.name AS сноха;


MATCH (irina:Person {name: 'irina'})-[:SPOUSE]->(maxim:Person),
      (maxim)-[:FATHER_OF]->(child:Person),
      (child)<-[:MOTHER_OF]-(otherMother:Person)
WHERE otherMother <> irina
RETURN child.name AS падчерица;

////
CREATE 
  (olga:Person {name: 'olga'}),
  (anna:Person {name: 'anna'});

MATCH (maxim:Person {name: 'maxim'}), (olga:Person {name: 'olga'}), (anna:Person {name: 'anna'})
CREATE 
  (maxim)-[:FATHER_OF]->(anna),
  (olga)-[:MOTHER_OF]->(anna),
  (maxim)-[:SPOUSE]->(olga),
  (olga)-[:SPOUSE]->(maxim);
////