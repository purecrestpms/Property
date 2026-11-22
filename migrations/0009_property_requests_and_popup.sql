-- Migration 0009: "Find My Next Home" property requests + popup lead source tracking

CREATE TABLE IF NOT EXISTS property_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  request_type TEXT DEFAULT 'buy', -- buy, rent, short-let, land, commercial
  property_type TEXT,              -- Apartment, Duplex, Bungalow, Penthouse, Land, Commercial, Any
  city TEXT,
  area_preference TEXT,
  bedrooms TEXT,
  budget_min REAL,
  budget_max REAL,
  move_in_timeframe TEXT,
  additional_details TEXT,
  status TEXT DEFAULT 'new', -- new, contacted, matched, closed
  admin_notes TEXT,
  source TEXT DEFAULT 'find-my-home',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_property_requests_status ON property_requests(status);
CREATE INDEX IF NOT EXISTS idx_property_requests_created ON property_requests(created_at);

-- Add a 'source' column to inquiries if it doesn't already note popup leads (column exists already, just ensure default works)
-- (inquiries.source TEXT DEFAULT 'website' already exists from migration 0001)
