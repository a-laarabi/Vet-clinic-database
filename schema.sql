CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);

ALTER TABLE animals
    DROP COLUMN species;

-- ADD forign key to animals

ALTER TABLE animals
    ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
    ADD owner_id INT REFERENCES owners(id);


-- IV Vet clinic database: add "join table" for visits

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

ALTER TABLE vets
    ADD PRIMARY KEY (id);

CREATE TABLE specializations (
    id_species INT REFERENCES species(id),
    id_vets INT REFERENCES vets(id)
);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    id_animals INT REFERENCES animals(id),
    id_vets INT REFERENCES vets(id),
    date_of_visit DATE,
    PRIMARY KEY (id)
);