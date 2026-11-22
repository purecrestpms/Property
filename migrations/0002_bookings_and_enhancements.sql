-- Migration 0002: Bookings table and property enhancements

-- Bookings table for short-let reservations
CREATE TABLE IF NOT EXISTS bookings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  booking_ref TEXT UNIQUE NOT NULL,
  property_id INTEGER,
  property_listing_id TEXT NOT NULL,
  property_title TEXT,
  checkin_date TEXT NOT NULL,
  checkout_date TEXT NOT NULL,
  nights INTEGER DEFAULT 1,
  guests INTEGER DEFAULT 1,
  guest_name TEXT NOT NULL,
  guest_phone TEXT NOT NULL,
  guest_email TEXT,
  special_requests TEXT,
  price_per_night REAL,
  total_price REAL,
  status TEXT DEFAULT 'pending', -- pending, confirmed, cancelled, completed
  payment_status TEXT DEFAULT 'unpaid', -- unpaid, partial, paid
  admin_notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

-- Blocked dates for properties (admin can block dates)
CREATE TABLE IF NOT EXISTS blocked_dates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_listing_id TEXT NOT NULL,
  blocked_date TEXT NOT NULL,
  reason TEXT DEFAULT 'booked',
  booking_id INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Add virtual_tour_url to properties if not exists
ALTER TABLE properties ADD COLUMN virtual_tour_url TEXT;
ALTER TABLE properties ADD COLUMN media_files TEXT; -- JSON array: [{type: 'image|video|3d', url: '...', thumb: '...'}]
ALTER TABLE properties ADD COLUMN amenities TEXT; -- JSON array of amenities (for short-let)
ALTER TABLE properties ADD COLUMN price_per_night REAL;
ALTER TABLE properties ADD COLUMN min_nights INTEGER DEFAULT 1;
ALTER TABLE properties ADD COLUMN max_nights INTEGER DEFAULT 30;
ALTER TABLE properties ADD COLUMN check_in_time TEXT DEFAULT '14:00';
ALTER TABLE properties ADD COLUMN check_out_time TEXT DEFAULT '11:00';
ALTER TABLE properties ADD COLUMN house_rules TEXT;
ALTER TABLE properties ADD COLUMN cancellation_policy TEXT DEFAULT 'flexible';

-- Create indexes for bookings
CREATE INDEX IF NOT EXISTS idx_bookings_property ON bookings(property_listing_id);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_dates ON bookings(checkin_date, checkout_date);
CREATE INDEX IF NOT EXISTS idx_blocked_dates_property ON blocked_dates(property_listing_id);
