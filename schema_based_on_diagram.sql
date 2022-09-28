CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patinet_id INT REFERENCES patients(id),
  status VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100),
  name VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE treatment_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  medical_histories_id INT,
  treatment_id INT,
  FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX patinet_id_index ON medical_histories(patinet_id);

CREATE INDEX medical_history_id_index ON invoices(medical_history_id);

CREATE INDEX invoice_id_index ON invoice_items(invoice_id);

CREATE INDEX treatment_id_index ON invoice_items(treatment_id);

CREATE INDEX medical_histories_id_index ON treatment_histories(medical_histories_id);

CREATE INDEX treatment_id_index ON treatment_histories(treatment_id);
