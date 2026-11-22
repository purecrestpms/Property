-- Migration 0003: User accounts, image uploads, admin accounts

-- Users (property submitters / public portal)
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT,
  password_hash TEXT,
  role TEXT DEFAULT 'user', -- user, agent, admin
  is_verified INTEGER DEFAULT 0,
  verification_token TEXT,
  status TEXT DEFAULT 'active', -- active, suspended, pending
  profile_photo TEXT,
  bio TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Upload tracking table (stores uploaded file metadata / base64 encoded or external URLs)
CREATE TABLE IF NOT EXISTS media_uploads (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  uploader_id INTEGER,
  uploader_type TEXT DEFAULT 'user', -- user, admin, agent
  property_submission_id INTEGER,
  property_id INTEGER,
  file_name TEXT,
  file_type TEXT, -- image, video, document
  mime_type TEXT,
  file_url TEXT NOT NULL,
  file_size INTEGER,
  width INTEGER,
  height INTEGER,
  is_public INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Extended property submissions (with user link and images)
CREATE TABLE IF NOT EXISTS property_submissions_v2 (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  submitter_name TEXT,
  submitter_phone TEXT,
  submitter_email TEXT,
  title TEXT NOT NULL,
  description TEXT,
  property_type TEXT,
  category TEXT DEFAULT 'rent',
  price REAL,
  price_period TEXT DEFAULT 'year',
  price_per_night REAL,
  bedrooms INTEGER DEFAULT 0,
  bathrooms INTEGER DEFAULT 0,
  size_sqm REAL,
  location TEXT,
  area TEXT,
  address TEXT,
  city TEXT DEFAULT 'Abuja',
  facilities TEXT, -- JSON array
  images TEXT, -- JSON array of URLs
  video_url TEXT,
  virtual_tour_url TEXT,
  amenities TEXT, -- JSON for short-let
  min_nights INTEGER DEFAULT 1,
  max_nights INTEGER DEFAULT 30,
  house_rules TEXT,
  cancellation_policy TEXT DEFAULT 'flexible',
  admin_notes TEXT,
  status TEXT DEFAULT 'pending', -- pending, approved, rejected, revision_requested
  reviewed_by TEXT,
  reviewed_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Admin accounts (for multiple admins)
CREATE TABLE IF NOT EXISTS admin_accounts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE,
  full_name TEXT,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'admin', -- super_admin, admin, moderator
  is_active INTEGER DEFAULT 1,
  last_login DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin accounts
INSERT OR IGNORE INTO admin_accounts (username, email, full_name, password, role) VALUES
  ('admin', 'admin@purecrest.ng', 'PureCrest Admin', 'purecrest2024', 'super_admin'),
  ('manager', 'manager@purecrest.ng', 'Property Manager', 'purecrest@manager', 'admin');

-- Add user_id column to property_submissions if not exists
-- (SQLite doesn't support ADD COLUMN IF NOT EXISTS, so we do it safely)
-- These may fail if column exists - that's OK
-- Indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_media_uploads_property ON media_uploads(property_submission_id);
CREATE INDEX IF NOT EXISTS idx_submissions_v2_status ON property_submissions_v2(status);
CREATE INDEX IF NOT EXISTS idx_submissions_v2_user ON property_submissions_v2(user_id);

-- Site settings table (key-value store for admin-configurable site settings)
CREATE TABLE IF NOT EXISTS site_settings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT UNIQUE NOT NULL,
  value TEXT,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Default site settings
INSERT OR IGNORE INTO site_settings (key, value) VALUES
  ('whatsapp_number', '+234 810 000 0000'),
  ('contact_email', 'info@purecrest.ng'),
  ('office_address', '3 Wuse 2 Street, Abuja, FCT'),
  ('hero_title', 'Find Your Perfect Property in Abuja'),
  ('hero_subtitle', 'Verified listings from trusted agents. Buy, Rent or Short Let with confidence.'),
  ('site_name', 'PureCrest Properties'),
  ('footer_tagline', 'Your trusted partner for verified real estate in Abuja, Nigeria.');
