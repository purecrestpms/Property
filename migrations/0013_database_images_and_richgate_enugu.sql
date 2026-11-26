-- Migration 0013: Database BLOB image storage, room image relations, advanced booking columns, and Richgate Apartments Enugu

-- 1. Link media_uploads to room_id and store binary image_blob in SQLite
ALTER TABLE media_uploads ADD COLUMN room_id INTEGER;
ALTER TABLE media_uploads ADD COLUMN image_blob BLOB;

CREATE INDEX IF NOT EXISTS idx_media_uploads_room ON media_uploads(room_id);
CREATE INDEX IF NOT EXISTS idx_media_uploads_prop ON media_uploads(property_id);

-- 2. Dedicated relational room images table
CREATE TABLE IF NOT EXISTS property_room_images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_id INTEGER NOT NULL,
  room_id INTEGER NOT NULL,
  media_id INTEGER,
  image_url TEXT NOT NULL,
  caption TEXT,
  is_cover INTEGER DEFAULT 0,
  sort_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id),
  FOREIGN KEY (room_id) REFERENCES property_rooms(id)
);

CREATE INDEX IF NOT EXISTS idx_room_images_room ON property_room_images(room_id);
CREATE INDEX IF NOT EXISTS idx_room_images_prop ON property_room_images(property_id);

-- 3. Advanced booking columns
ALTER TABLE bookings ADD COLUMN adults INTEGER DEFAULT 1;
ALTER TABLE bookings ADD COLUMN children INTEGER DEFAULT 0;
ALTER TABLE bookings ADD COLUMN arrival_time TEXT DEFAULT '14:00 - 17:00';
ALTER TABLE bookings ADD COLUMN stay_purpose TEXT DEFAULT 'Leisure / Holiday';
ALTER TABLE bookings ADD COLUMN addons TEXT;
ALTER TABLE bookings ADD COLUMN addons_total REAL DEFAULT 0;
ALTER TABLE bookings ADD COLUMN promo_code TEXT;
ALTER TABLE bookings ADD COLUMN discount_amount REAL DEFAULT 0;
ALTER TABLE bookings ADD COLUMN payment_method TEXT DEFAULT 'transfer';

-- 4. Update homepage hero background to generated luxury residence visual
UPDATE site_settings
SET value = '/src/assets/images/hero_purecrest_residence_1795731930518.jpg',
    updated_at = CURRENT_TIMESTAMP
WHERE key = 'hero_bg_image' AND (value = '/static/hero-bg.jpg' OR value IS NULL OR value = '');

-- 5. Seed Featured Shortlet: Richgate Apartments Enugu
INSERT OR IGNORE INTO properties (
  listing_id, title, description, property_type, category,
  price, price_period, price_per_night, bedrooms, bathrooms, toilets, size_sqm, year_built,
  location, address, area, city, state,
  is_featured, is_verified, is_prime_location, status,
  facilities, amenities, images,
  min_nights, max_nights, check_in_time, check_out_time, house_rules, cancellation_policy,
  agent_id, created_at, updated_at
) VALUES (
  'PC-ENUGU-01',
  'Richgate Apartments Enugu',
  'Signature serviced residence in Independence Layout, Enugu — offering curated studios, executive 1-bedroom suites, 2-bedroom residences, and a private penthouse with 24/7 power, high-speed fibre internet, concierge support, and hotel-grade housekeeping.',
  'Apartment',
  'short-let',
  45000,
  'night',
  45000,
  3,
  3,
  4,
  240,
  2025,
  'Independence Layout, Enugu',
  '18 Richgate Close, Independence Layout',
  'Independence Layout',
  'Enugu',
  'Enugu',
  1,
  1,
  1,
  'active',
  '["24/7 Power & Solar Backup","Starlink High-Speed WiFi","24/7 Armed Security","Free Private Parking","CCTV Surveillance","Daily Housekeeping","Concierge Front Desk","Airport Pickup Available"]',
  '["King-Size Beds","Smart TV & Netflix","Fully Fitted Kitchen","Air Conditioning","Dedicated Workspace","Washer & Dryer","Balcony Lounge","Complimentary Toiletries"]',
  '["/src/assets/images/richgate_enugu_exterior_1795731930600.jpg","/src/assets/images/richgate_penthouse_suite_1795731932102.jpg","/src/assets/images/richgate_executive_suite_1795731931254.jpg","/src/assets/images/richgate_deluxe_studio_1795731930895.jpg"]',
  1,
  60,
  '14:00',
  '11:00',
  '["No smoking inside suites","Valid government-issued ID required at check-in","Quiet hours observed after 10:30 PM","Maximum guest limit per selected room applies"]',
  'flexible',
  1,
  '2026-11-26 12:00:00',
  '2026-11-26 12:00:00'
);

-- Ensure Richgate Apartments Enugu is featured & active if it already existed
UPDATE properties
SET is_featured = 1, status = 'active', city = 'Enugu', state = 'Enugu', category = 'short-let'
WHERE listing_id = 'PC-ENUGU-01';

-- 6. Seed 4 Room Types for Richgate Apartments Enugu
INSERT INTO property_rooms (
  property_id, room_name, room_type, description,
  price_per_night, max_guests, bedrooms, bathrooms,
  amenities, images, is_available, sort_order
)
SELECT
  p.id,
  'Deluxe King Studio',
  'Studio',
  'Warm walnut-paneled studio suite featuring a plush king bed, dedicated ergonomic desk, smart TV, kitchenette, and rain shower.',
  45000,
  2,
  1,
  1,
  '["King Bed","Workstation Desk","Smart TV & Netflix","Kitchenette","High-Speed WiFi","En-suite Rain Shower"]',
  '["/src/assets/images/richgate_deluxe_studio_1795731930895.jpg","/src/assets/images/richgate_enugu_exterior_1795731930600.jpg"]',
  1,
  1
FROM properties p
WHERE p.listing_id = 'PC-ENUGU-01'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Deluxe King Studio');

INSERT INTO property_rooms (
  property_id, room_name, room_type, description,
  price_per_night, max_guests, bedrooms, bathrooms,
  amenities, images, is_available, sort_order
)
SELECT
  p.id,
  'Executive 1-Bedroom Suite',
  '1-Bedroom Suite',
  'Spacious 1-bedroom apartment with a separate sunlit living lounge, dining nook, fully fitted kitchen, and private bedroom sanctuary.',
  65000,
  2,
  1,
  1,
  '["Separate Living Room","Fitted Kitchen","King Bedroom","Smart TV","Balcony Access","Daily Housekeeping"]',
  '["/src/assets/images/richgate_executive_suite_1795731931254.jpg","/src/assets/images/richgate_deluxe_studio_1795731930895.jpg","/src/assets/images/richgate_enugu_exterior_1795731930600.jpg"]',
  1,
  2
FROM properties p
WHERE p.listing_id = 'PC-ENUGU-01'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Executive 1-Bedroom Suite');

INSERT INTO property_rooms (
  property_id, room_name, room_type, description,
  price_per_night, max_guests, bedrooms, bathrooms,
  amenities, images, is_available, sort_order
)
SELECT
  p.id,
  'Signature 2-Bedroom Residence',
  '2-Bedroom Apartment',
  'Designed for families and executive teams — two en-suite bedrooms, expansive open-plan lounge, chef kitchen, and scenic terrace.',
  95000,
  4,
  2,
  2,
  '["2 En-suite Bedrooms","Open-Plan Dining & Lounge","Full Chef Kitchen","Washer & Dryer","Private Terrace","2 Parking Bays"]',
  '["/src/assets/images/richgate_penthouse_suite_1795731932102.jpg","/src/assets/images/richgate_executive_suite_1795731931254.jpg","/src/assets/images/richgate_deluxe_studio_1795731930895.jpg"]',
  1,
  3
FROM properties p
WHERE p.listing_id = 'PC-ENUGU-01'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Signature 2-Bedroom Residence');

INSERT INTO property_rooms (
  property_id, room_name, room_type, description,
  price_per_night, max_guests, bedrooms, bathrooms,
  amenities, images, is_available, sort_order
)
SELECT
  p.id,
  'Richgate Presidential Penthouse',
  'Penthouse Suite',
  'Top-floor panoramic residence overlooking Independence Layout hills with 3 bedrooms, entertainer kitchen island, private wrap-around terrace, and VIP concierge.',
  145000,
  6,
  3,
  3,
  '["3 En-suite Bedrooms","Panoramic Wrap-Around Terrace","Chef Kitchen Island","Private Lounge & Dining","VIP Concierge","Complimentary Airport Transfer"]',
  '["/src/assets/images/richgate_penthouse_suite_1795731932102.jpg","/src/assets/images/richgate_enugu_exterior_1795731930600.jpg","/src/assets/images/richgate_executive_suite_1795731931254.jpg","/src/assets/images/richgate_deluxe_studio_1795731930895.jpg"]',
  1,
  4
FROM properties p
WHERE p.listing_id = 'PC-ENUGU-01'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Richgate Presidential Penthouse');
