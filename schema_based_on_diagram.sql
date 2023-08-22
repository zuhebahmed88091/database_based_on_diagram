CREATE TABLE patients (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth Date
);

CREATE TABLE invoices (
    id SERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL(10,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT
);

CREATE TABLE invoice_items (
    id SERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL(10,2),
    quantity INT,
    total_price DECIMAL(10,2),
    invoice_id INT,
    treatment_id INT
);

CREATE TABLE medical_histories (
    id SERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255)
);
CREATE TABLE treatments (
    id SERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);
CREATE TABLE medical_treatment (
    id SERIAL NOT NULL PRIMARY KEY,
    treatment_id INT,
    medical_history_id INT
);


ALTER TABLE invoices ADD CONSTRAINT invoices_medical_history_id_fkey FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);
ALTER TABLE medical_histories ADD CONSTRAINT medical_histories_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients (id);
ALTER TABLE medical_treatment ADD CONSTRAINT medical_treatment_treatment_id_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id);
ALTER TABLE medical_treatment ADD CONSTRAINT medical_treatment_medical_history_id_fkey FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);
ALTER TABLE invoice_items ADD CONSTRAINT invoice_items_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES invoices (id);
ALTER TABLE invoice_items ADD CONSTRAINT invoice_items_treatment_id_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id);

CREATE INDEX medical_treatment_medical_history_id_index ON medical_treatment (medical_history_id);
CREATE INDEX medical_treatment_treatment_id_index ON medical_treatment (treatment_id);

CREATE INDEX medical_histories_patient_id_index ON medical_histories (patient_id);

CREATE INDEX invoices_medical_history_id_index ON invoices (medical_history_id);
CREATE INDEX invoice_items_invoice_id_index ON invoice_items (invoice_id);
CREATE INDEX invoice_items_treatment_id_index ON invoice_items (treatment_id);
