-- Enhanced agent property submissions
-- Add extra columns to property_submissions if they don't exist
-- (uses ALTER TABLE so it's safe to run even if table exists)

ALTER TABLE property_submissions ADD COLUMN toilets INTEGER DEFAULT 0;
ALTER TABLE property_submissions ADD COLUMN size_sqm REAL DEFAULT 0;
ALTER TABLE property_submissions ADD COLUMN address TEXT;
ALTER TABLE property_submissions ADD COLUMN amenities TEXT DEFAULT '[]';
ALTER TABLE property_submissions ADD COLUMN house_rules TEXT DEFAULT '[]';
ALTER TABLE property_submissions ADD COLUMN price_per_night REAL DEFAULT 0;
ALTER TABLE property_submissions ADD COLUMN year_built INTEGER;
ALTER TABLE property_submissions ADD COLUMN additional_notes TEXT;
ALTER TABLE property_submissions ADD COLUMN reviewed_at DATETIME;
ALTER TABLE property_submissions ADD COLUMN reviewed_by TEXT;
