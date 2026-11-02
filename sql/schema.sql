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

------------------------------------------------------------------------
-- activities (TABLE 2)
-- Stores raw business activities that generate greenhouse-gas emissions
-- Examples:
-- Electricity consumption
-- Fuel purchases
-- Vehicle mileage
-- Business travel

-- These records are the primary inputs to the carbon accounting engine.
---------------------------------------------------------------------------
CREATE TABLE activities (
    activity_id SERIAL PRIMARY KEY,
    company_id INT NOT NULL
        REFERENCES comapnies(company_id),
    activity_date DATE NOT NULL,
    activity_type VARCHAR(100) NOT NULL,
    quantity DECIMAL(12, 2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    source_reference VARCHAR(250),
    created_at TIMESTAMPZ DEFAULT CURRENT_TIMESTAMP
);