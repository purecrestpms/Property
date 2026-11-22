-- PureCrest Properties Database Schema

-- Agents table
CREATE TABLE IF NOT EXISTS agents (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT NOT NULL,
  whatsapp TEXT,
  bio TEXT,
  agency_name TEXT,
  profile_photo TEXT,
  license_number TEXT,
  years_experience INTEGER DEFAULT 0,
  specialization TEXT DEFAULT 'Residential',
  status TEXT DEFAULT 'pending', -- pending, active, suspended
  is_verified INTEGER DEFAULT 0,
  rating REAL DEFAULT 0,
  review_count INTEGER DEFAULT 0,
  listings_count INTEGER DEFAULT 0,
  password_hash TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Properties table
CREATE TABLE IF NOT EXISTS properties (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  listing_id TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  property_type TEXT NOT NULL, -- Apartment, Duplex, Bungalow, Penthouse, Land, Commercial
  category TEXT NOT NULL, -- buy, rent, short-let, land, commercial
  price REAL NOT NULL,
  price_period TEXT DEFAULT 'year', -- year, month, outright, sqm
  bedrooms INTEGER DEFAULT 0,
  bathrooms INTEGER DEFAULT 0,
  toilets INTEGER DEFAULT 0,
  size_sqm REAL,
  location TEXT NOT NULL,
  address TEXT,
  area TEXT NOT NULL, -- Wuse 2, Maitama, Lekki etc.
  city TEXT DEFAULT 'Abuja',
  state TEXT DEFAULT 'FCT',
  latitude REAL,
  longitude REAL,
  is_featured INTEGER DEFAULT 0,
  is_verified INTEGER DEFAULT 0,
  is_prime_location INTEGER DEFAULT 0,
  status TEXT DEFAULT 'active', -- active, pending, sold, rented, inactive
  views INTEGER DEFAULT 0,
  saves INTEGER DEFAULT 0,
  agent_id INTEGER,
  whatsapp_number TEXT DEFAULT '+2348100000000',
  facilities TEXT, -- JSON array of facilities
  images TEXT, -- JSON array of image URLs
  video_url TEXT,
  floor_plan TEXT,
  year_built INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (agent_id) REFERENCES agents(id)
);

-- Inquiries table  
CREATE TABLE IF NOT EXISTS inquiries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_id INTEGER,
  property_listing_id TEXT,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  message TEXT,
  preferred_time TEXT DEFAULT 'Anytime',
  inquiry_type TEXT DEFAULT 'callback', -- callback, whatsapp, email
  status TEXT DEFAULT 'new', -- new, contacted, assigned, closed
  assigned_agent_id INTEGER,
  notes TEXT,
  source TEXT DEFAULT 'website',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id),
  FOREIGN KEY (assigned_agent_id) REFERENCES agents(id)
);

-- Blog posts table
CREATE TABLE IF NOT EXISTS blog_posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  excerpt TEXT,
  content TEXT,
  cover_image TEXT,
  author TEXT DEFAULT 'PureCrest Team',
  category TEXT DEFAULT 'Market News',
  tags TEXT,
  status TEXT DEFAULT 'published',
  views INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Admin users table
CREATE TABLE IF NOT EXISTS admins (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT DEFAULT 'admin', -- super_admin, admin, moderator
  is_active INTEGER DEFAULT 1,
  last_login DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Saved properties table
CREATE TABLE IF NOT EXISTS saved_properties (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT,
  user_email TEXT,
  property_id INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

-- Agent applications table
CREATE TABLE IF NOT EXISTS agent_applications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  whatsapp TEXT,
  agency_name TEXT,
  years_experience INTEGER,
  specialization TEXT,
  bio TEXT,
  license_number TEXT,
  id_document TEXT,
  status TEXT DEFAULT 'pending', -- pending, approved, rejected
  admin_notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Property listings by agents (pending approval)
CREATE TABLE IF NOT EXISTS property_submissions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  agent_id INTEGER,
  submitter_name TEXT,
  submitter_phone TEXT,
  submitter_email TEXT,
  title TEXT NOT NULL,
  description TEXT,
  property_type TEXT,
  category TEXT,
  price REAL,
  price_period TEXT,
  bedrooms INTEGER,
  bathrooms INTEGER,
  location TEXT,
  area TEXT,
  facilities TEXT,
  images TEXT,
  status TEXT DEFAULT 'pending', -- pending, approved, rejected
  admin_notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (agent_id) REFERENCES agents(id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_properties_category ON properties(category);
CREATE INDEX IF NOT EXISTS idx_properties_area ON properties(area);
CREATE INDEX IF NOT EXISTS idx_properties_status ON properties(status);
CREATE INDEX IF NOT EXISTS idx_properties_is_featured ON properties(is_featured);
CREATE INDEX IF NOT EXISTS idx_inquiries_status ON inquiries(status);
CREATE INDEX IF NOT EXISTS idx_agents_status ON agents(status);
