-- Migration 0011: Property Rooms (multi-room shortlets) + city data fix

-- Rooms / units belonging to a short-let property (apartment with multiple rooms,
-- single rooms, suites, etc). Each room has its own price, amenities and photos.
CREATE TABLE IF NOT EXISTS property_rooms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_id INTEGER NOT NULL,
  room_name TEXT NOT NULL,
  room_type TEXT DEFAULT 'Room', -- Apartment, Single Room, Double Room, Suite, Studio, etc.
  description TEXT,
  price_per_night REAL DEFAULT 0,
  max_guests INTEGER DEFAULT 1,
  bedrooms INTEGER DEFAULT 1,
  bathrooms INTEGER DEFAULT 1,
  amenities TEXT, -- JSON array
  images TEXT,    -- JSON array of image URLs
  is_available INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

CREATE INDEX IF NOT EXISTS idx_property_rooms_property ON property_rooms(property_id);

-- Track which room (if any) a booking is for
ALTER TABLE bookings ADD COLUMN room_id INTEGER;
ALTER TABLE bookings ADD COLUMN room_name TEXT;

-- ===== Data fix: "city" column silently defaulted to 'Abuja' for every property =====
-- because the admin property form never collected/saved a city value.
-- Best-effort backfill: infer city from matching area name against known
-- Lagos / Abuja neighbourhood lists. Leave as-is (existing city value) if it
-- doesn't match either list (keeps any already-correct manual values).
UPDATE properties SET city = 'Lagos'
WHERE area IN (
  'Victoria Island','Lekki','Ikoyi','Ajah','Yaba','Surulere','Ikeja',
  'Lagos Island','Apapa','Maryland','Gbagada','Magodo','Lekki Phase 1','Sangotedo'
);

UPDATE properties SET city = 'Abuja'
WHERE area IN (
  'Maitama','Wuse 2','Asokoro','Jabi','Garki','Utako','Guzape','Kubwa','Kado',
  'Apo','Gwarinpa','Katampe','Lugbe','Kuje','Wuse','Central Business District',
  'Durumi','Gudu','Lokogoma'
);
