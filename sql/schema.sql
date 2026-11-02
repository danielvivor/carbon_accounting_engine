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

-------------------------------------------------------------------------------------------------------
-- emissions_calculations (TABLE 4)
-- Stores calculated greenhouse-gas emissions derived from activity records and emission factors.
--
-- Formula:
-- activity quantity  x emission factor

-- Every calculation remains auditable because both the source activity and emission factor are stored.
--------------------------------------------------------------------------------------------------------
CREATE TABLE emission_calculations (
    calculation_id SERIAL PRIMARY KEY,
    activity_id INT NOT NULL,
        REFERENCES activities(activity_id),
    factor_id INT NOT NULL,
        REFERENCES emission_factors(factor_id),
    emissions_kgco2e DECIMAL(18, 2) NOT NULL,
    calculation_timestamp TIMESTAMPZ DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------------------------------------------------------
-- carbon_ledger (TABLE 5)
-- Stores the official greenhouse-gas emission records used for reporting and disclosure purposes.
--
-- The ledger classifies emissions into Scope 1, Scope 2, and Scope 3 categories 
-- and provides a complete audit trail back to the underlying calculation.
---------------------------------------------------------------------------------------------------
CREATE TABLE carbon_ledger (
    ledger_id SERIAL PRIMARY KEY,
    company_id INT NOT NULL
        REFERENCES comapnies(company_id),
    calculation_id INT NOT NULL
        REFERENCES emission_calculations(calculation_id),
    reporting_period DATE NOT NULL,
    scope VARCHAR(20) NOT NULL,
    emissions_kgco2e DECIMAL(18, 6) NOT NULL,
    recorded_at TIMESTAMPZ
        DEFAULT CURRENT_TIMESTAMP
);