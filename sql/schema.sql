-- This database contains five tables namely
-- companies
-- activities
-- emission_factors
-- emission_calculations
-- carbon_ledger

--------------------------------------------------------
-- companies (TABLE 1)
-- Stores organisations whose emissions are being tracked
---------------------------------------------------------
CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    comapny_name VARCHAR(200) NOT NULL,
    industry VARCHAR(100),
    country VARCHAR(100),
    created_at TIMESTAMPZ DEFAULT CURRENT_TIMESTAMP
);
