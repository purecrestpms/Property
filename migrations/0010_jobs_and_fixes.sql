-- Migration 0010: Job listings table + data fixes

-- Job listings table (for careers page)
CREATE TABLE IF NOT EXISTS job_listings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  department TEXT DEFAULT '',
  location TEXT DEFAULT 'Abuja, Nigeria',
  job_type TEXT DEFAULT 'Full-time',
  description TEXT DEFAULT '',
  requirements TEXT DEFAULT '',
  salary_range TEXT DEFAULT '',
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_job_listings_active ON job_listings(is_active);

-- Note: toilets column already added in migration 0001

-- Ensure site_settings table exists (created in migration 0007 but some installs skip)
CREATE TABLE IF NOT EXISTS site_settings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT UNIQUE NOT NULL,
  value TEXT,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_site_settings_key ON site_settings(key);

-- Insert default site settings if they don't exist
INSERT OR IGNORE INTO site_settings (key, value) VALUES ('phone_number', '+234 913 040 3970');
INSERT OR IGNORE INTO site_settings (key, value) VALUES ('whatsapp_number', '+2349130403970');
INSERT OR IGNORE INTO site_settings (key, value) VALUES ('contact_email', 'hello@purecrest.ng');
INSERT OR IGNORE INTO site_settings (key, value) VALUES ('footer_tagline', 'Purecrest is a diversified company delivering world-class hospitality and real estate solutions across Nigeria.');
