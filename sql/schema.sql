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
    activity_type VARCHAR(50) NOT NULL,
    quantity DECIMAL(12, 2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    source_reference VARCHAR(250),
    created_at TIMESTAMPZ DEFAULT CURRENT_TIMESTAMP
);

-----------------------------------------------------------------------------
-- emission_factors (TABLE 3)
-- Stores greenhouse-gas emission conversion factors.
-- These factors convert business activities into carbon emissions
-- Emission factors are typically sources from recognised standards such as 
--DEFRA, EPA or IPCC datasets
------------------------------------------------------------------------------
CREATE TABLE emission_factors(
    factor_id SERIAL PRIMARY KEY,
    activity_type VARCHAR(50) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    emission_factor DECIMAL(12, 2) NOT NULL,
    factor_source VARCHAR(100),
    valid_from DATE,
    created_at TIMESTAMPZ DEFAULT CURRENT_TIMESTAMP
);