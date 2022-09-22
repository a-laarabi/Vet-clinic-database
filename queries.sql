/*Queries that provide answers to the questions from all projects.*/

-- Q_1 : Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- Or this querie to list just the name 
SELECT name FROM animals WHERE name LIKE '%mon';

-- Q_2 : List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Q_3 : List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- Q_4 : List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- Q_5 : List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Q_6 : Find all animals that are neutered.
SELECT name FROM animals WHERE neutered = TRUE;

-- Q_7 : Find all animals not named Gabumon.
SELECT name FROM animals WHERE name != 'Gabumon';

-- Q_8 : Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Q_1: Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;

-- Q_2: Inside a transaction:
/*
    - Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    - Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    - Commit the transaction.
    - Verify that change was made and persists after commit.
*/

BEGIN;

UPDATE animals 
  SET species = 'digimon'
  WHERE name LIKE '%mon';

UPDATE animals
  SET species = 'pokemon'
  WHERE species IS NULL;

COMMIT;

/*
Q_3: Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
*/

BEGIN;

DELETE FROM animals;

ROLLBACK;

/*
Q_4: Inside a transaction:
  Delete all animals born after Jan 1st, 2022.
  Create a savepoint for the transaction.
  Update all animals' weight to be their weight multiplied by -1.
  Rollback to the savepoint
  Update all animals' weights that are negative to be their weight multiplied by -1.
  Commit transaction
*/

BEGIN;

DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';

SAVEPOINT point1;

UPDATE animals
  SET weight_kg = weight_kg * -1;

ROLLBACK TO point1;

UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;

COMMIT;

-- How many animals are there?

SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(name) FROM animals
  WHERE escape_attempts = 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(escape_attempts)
  FROM animals
  GROUP BY neutered;


SELECT neutered, MAX(sum)  FROM (
  SELECT neutered, SUM(escape_attempts)
  FROM animals
  GROUP BY neutered
  ) As Max_escape;





-- What is the minimum and maximum weight of each type of animal?

SELECT species, MAX(weight_kg), MIN(weight_kg) 
  FROM animals
  GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth BETWEEN '1990-12-31' AND '2000-12-31'
GROUP BY species;
