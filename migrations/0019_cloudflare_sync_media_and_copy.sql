-- Migration 0019: Sync /assets/images/* static paths for Cloudflare Pages, ensure Richgate + 6 rooms in D1,
-- seed Hospitality hero image, and register all current site images directly into Dashboard Media Library.

-- 1. Rewrite any legacy /src/assets/images/ references to Vite public /assets/images/
UPDATE site_settings
SET value = REPLACE(value, '/src/assets/images/', '/assets/images/'),
    updated_at = CURRENT_TIMESTAMP
WHERE value LIKE '%/src/assets/images/%';

UPDATE properties
SET images = REPLACE(images, '/src/assets/images/', '/assets/images/'),
    updated_at = CURRENT_TIMESTAMP
WHERE images LIKE '%/src/assets/images/%';

UPDATE property_rooms
SET images = REPLACE(images, '/src/assets/images/', '/assets/images/'),
    updated_at = CURRENT_TIMESTAMP
WHERE images LIKE '%/src/assets/images/%';

UPDATE property_room_images
SET image_url = REPLACE(image_url, '/src/assets/images/', '/assets/images/')
WHERE image_url LIKE '%/src/assets/images/%';

UPDATE media_uploads
SET file_url = REPLACE(file_url, '/src/assets/images/', '/assets/images/')
WHERE file_url LIKE '%/src/assets/images/%';

UPDATE gallery
SET file_url = REPLACE(file_url, '/src/assets/images/', '/assets/images/'),
    updated_at = CURRENT_TIMESTAMP
WHERE file_url LIKE '%/src/assets/images/%';

-- 2. Ensure hero_bg_image uses the Cloudflare-served residence photo when unset/legacy
UPDATE site_settings
SET value = '/assets/images/hero_purecrest_residence_1795731930518.jpg',
    updated_at = CURRENT_TIMESTAMP
WHERE key = 'hero_bg_image'
  AND (value IS NULL OR value = '' OR value = '/static/hero-bg.jpg' OR value LIKE '%/src/assets/images/%');

INSERT OR IGNORE INTO site_settings (key, value)
VALUES ('hero_bg_image', '/assets/images/hero_purecrest_residence_1795731930518.jpg');

-- Ensure Hospitality hero has a replaceable default image
INSERT OR IGNORE INTO site_settings (key, value)
VALUES ('hospitality_hero_image', '/assets/images/hero_purecrest_residence_1795731930518.jpg');

-- Ensure service cards & pages reference valid Cloudflare /assets/aistudio paths
INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('service_img_solutions', '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png');

INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('service_img_virtual_support', '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png');

-- 3. Ensure Featured Shortlet: Richgate Apartments Enugu exists and is active/featured in D1
INSERT OR IGNORE INTO properties (
  listing_id, title, description, property_type, category,
  price, price_period, price_per_night, bedrooms, bathrooms, toilets, size_sqm, year_built,
  location, address, area, city, state,
  is_featured, is_verified, is_prime_location, status,
  facilities, amenities, images,
  min_nights, max_nights, check_in_time, check_out_time, house_rules, cancellation_policy,
  agent_id, created_at, updated_at
)
SELECT
  'richgate-apartments-enugu',
  'Richgate Apartments Enugu',
  'Signature serviced apartments and luxury boutique hotel suites at Plot C16-C, Fabian Okafor Close, Along Old Airport Road, Thinkers Corner, Enugu. Choose between self-catering studios with fitted kitchenettes, spacious one-bedroom residences, and refined hotel suites — backed by 24/7 power, high-speed WiFi, smart TV entertainment, and attentive concierge hospitality.',
  'Apartment',
  'short-let',
  55000,
  'night',
  55000,
  1,
  1,
  1,
  240,
  2025,
  'Thinkers Corner, Enugu',
  'Plot C16-C, Fabian Okafor Close, Along Old Airport Road',
  'Thinkers Corner',
  'Enugu',
  'Enugu',
  1,
  1,
  1,
  'active',
  '["24/7 Power & Solar Backup","Starlink High-Speed WiFi","24/7 Armed Security","Free Private Parking","CCTV Surveillance","Daily Housekeeping","Concierge Front Desk","Airport Pickup Available"]',
  '["King-Size Beds","Smart TV & Netflix","Fully Fitted Kitchen","Air Conditioning","Dedicated Workspace","Washer & Dryer","Balcony Lounge","Complimentary Toiletries"]',
  '["/assets/aistudio/file_000000003fc881f4b5e66b7352a17edc_c7ca46a2.png","/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png","/assets/aistudio/IMG_2050_feea3d0a.png","/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1,
  60,
  '14:00',
  '11:00',
  '["No smoking inside suites","Valid government-issued ID required at check-in","Quiet hours observed after 10:30 PM","Maximum guest limit per selected room applies"]',
  'flexible',
  (SELECT id FROM agents LIMIT 1),
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
WHERE NOT EXISTS (
  SELECT 1 FROM properties
  WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01')
     OR LOWER(title) LIKE '%richgate%'
);

UPDATE properties
SET
  listing_id = 'richgate-apartments-enugu',
  address = 'Plot C16-C, Fabian Okafor Close, Along Old Airport Road',
  area = 'Thinkers Corner',
  city = 'Enugu',
  state = 'Enugu',
  location = 'Thinkers Corner, Enugu',
  category = 'short-let',
  status = 'active',
  is_featured = 1,
  price = CASE WHEN price IS NULL OR price = 0 THEN 55000 ELSE price END,
  price_per_night = CASE WHEN price_per_night IS NULL OR price_per_night = 0 THEN 55000 ELSE price_per_night END,
  images = CASE
    WHEN images IS NULL OR images = '' OR images = '[]' OR images LIKE '%/src/assets/images/%'
      THEN '["/assets/aistudio/file_000000003fc881f4b5e66b7352a17edc_c7ca46a2.png","/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png","/assets/aistudio/IMG_2050_feea3d0a.png","/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_1943_ce327c41.webp"]'
    ELSE images
  END,
  updated_at = CURRENT_TIMESTAMP
WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01')
   OR LOWER(title) LIKE '%richgate%';

-- 4. Ensure all 6 clean Richgate room types exist (no RM- prefixes)
INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'Deluxe Studio with Kitchenette', 'Serviced Apartment',
  'Executive open-plan serviced studio featuring a plush king bed, full work desk, fitted kitchenette with gas hob, extractor hood, and microwave, plus spa-grade marble bathroom.',
  65500, 2, 1, 1,
  '["Fitted Kitchenette","Gas Hob & Range Hood","Microwave & Fridge","King Bed","Smart TV","Work Desk","High-Speed WiFi","Rain Shower"]',
  '["/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 1
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Deluxe Studio with Kitchenette');

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'One Bedroom Suite Apartment', 'Serviced Apartment',
  'Spacious one-bedroom serviced residence with separate lounge and dining bar, fitted kitchen, PlayStation console & smart TV entertainment, upholstered king bedroom, and luxury bathroom.',
  80000, 3, 1, 1,
  '["Separate Lounge & Dining","Fitted Full Kitchenette","PS5 Gaming & Smart TV","King Bedroom + Bench","High-Speed WiFi","24/7 Power","Daily Housekeeping"]',
  '["/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 2
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'One Bedroom Suite Apartment');

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'Standard Studio with Kitchenette', 'Serviced Apartment',
  'Cozy serviced studio suite with velvet loveseat lounge, breakfast bar seating, fitted kitchenette (microwave, mini-fridge & gas cooker), and contemporary marble bathroom.',
  55000, 2, 1, 1,
  '["Fitted Kitchenette","Lounge Loveseat","Bar Stool Counter","Microwave & Mini-Fridge","Air Conditioning","High-Speed WiFi","En-suite Marble Bath"]',
  '["/assets/aistudio/IMG_2050_feea3d0a.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 3
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Standard Studio with Kitchenette');

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'Deluxe Studio', 'Hotel Room',
  'Refined hotel studio featuring marble flooring, tufted king headboard with wood-slat accent lighting, comfortable reading armchair, climate control, and backlit mirror bathroom.',
  55000, 2, 1, 1,
  '["King Bed","Lounge Armchair","Marble Flooring","Split Air Conditioning","In-Room Phone & WiFi","Backlit Rain Shower"]',
  '["/assets/aistudio/IMG_2051_812531ee.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 4
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Deluxe Studio');

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'Standard Studio', 'Hotel Room',
  'Crisp minimalist studio with charcoal upholstered king headboard, timber wall paneling, floor-to-ceiling drapery, bedside desk phone, and designer en-suite bathroom.',
  55000, 2, 1, 1,
  '["King Bed","Timber Accent Wall","Blackout Curtains","High-Speed WiFi","Daily Housekeeping","Walk-In Glass Shower"]',
  '["/assets/aistudio/IMG_2191_d323fbad.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 5
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'Standard Studio');

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT p.id, 'One Bedroom Suite', 'Hotel Room',
  'Signature executive hotel suite combining an expansive cream-tufted king bedroom with ottoman, private living area with smart entertainment, and luxury marble bathroom.',
  75000, 3, 1, 1,
  '["Separate Living Area","King Bedroom & Ottoman","Smart TV","Work & Lounge Seating","High-Speed WiFi","24/7 Concierge & Power"]',
  '["/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 6
FROM properties p
WHERE p.listing_id = 'richgate-apartments-enugu'
  AND NOT EXISTS (SELECT 1 FROM property_rooms r WHERE r.property_id = p.id AND r.room_name = 'One Bedroom Suite');

-- 5. Seed ALL current site images directly into media_uploads for Dashboard Media Library & Picker
INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'hero_purecrest_residence.jpg', 'image', 'image/jpeg', '/assets/images/hero_purecrest_residence_1795731930518.jpg', 893952
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/images/hero_purecrest_residence_1795731930518.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate_enugu_exterior.jpg', 'image', 'image/jpeg', '/assets/images/richgate_enugu_exterior_1795731930600.jpg', 920576
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/images/richgate_enugu_exterior_1795731930600.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate_deluxe_studio.jpg', 'image', 'image/jpeg', '/assets/images/richgate_deluxe_studio_1795731930895.jpg', 789504
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/images/richgate_deluxe_studio_1795731930895.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate_executive_suite.jpg', 'image', 'image/jpeg', '/assets/images/richgate_executive_suite_1795731931254.jpg', 791552
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/images/richgate_executive_suite_1795731931254.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate_penthouse_suite.jpg', 'image', 'image/jpeg', '/assets/images/richgate_penthouse_suite_1795731932102.jpg', 877568
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/images/richgate_penthouse_suite_1795731932102.jpg');

-- Attached aistudio photos (Richgate Suites, Virtual Support, Pure Crest Technology)
INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'purecrest-technology-dashboard.png', 'image', 'image/png', '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'hospitality-virtual-support.png', 'image', 'image/png', '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-deluxe-kitchenette-studio.png', 'image', 'image/png', '/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-one-bedroom-lounge.jpeg', 'image', 'image/jpeg', '/assets/aistudio/IMG_1793_3e8044d1.jpeg', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_1793_3e8044d1.jpeg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-marble-bathroom.webp', 'image', 'image/webp', '/assets/aistudio/IMG_1943_ce327c41.webp', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_1943_ce327c41.webp');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-corner-studio.webp', 'image', 'image/webp', '/assets/aistudio/IMG_1946_70564288.webp', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_1946_70564288.webp');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-kitchenette-detail.png', 'image', 'image/png', '/assets/aistudio/IMG_2048_7ce0a046.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_2048_7ce0a046.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-standard-studio-kitchen.png', 'image', 'image/png', '/assets/aistudio/IMG_2050_feea3d0a.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_2050_feea3d0a.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-deluxe-hotel-studio.png', 'image', 'image/png', '/assets/aistudio/IMG_2051_812531ee.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_2051_812531ee.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-standard-hotel-studio.png', 'image', 'image/png', '/assets/aistudio/IMG_2191_d323fbad.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_2191_d323fbad.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-one-bedroom-suite.png', 'image', 'image/png', '/assets/aistudio/IMG_2192_852c7555.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/IMG_2192_852c7555.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-ambient-studio.png', 'image', 'image/png', '/assets/aistudio/file_0000000010048243a99f6cbf32d7ed60_c627ea67.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/file_0000000010048243a99f6cbf32d7ed60_c627ea67.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', (SELECT id FROM properties WHERE listing_id = 'richgate-apartments-enugu' LIMIT 1), 'richgate-cover-residence.png', 'image', 'image/png', '/assets/aistudio/file_000000003fc881f4b5e66b7352a17edc_c7ca46a2.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/assets/aistudio/file_000000003fc881f4b5e66b7352a17edc_c7ca46a2.png');

-- Core static site images
INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'static-hero-bg.jpg', 'image', 'image/jpeg', '/static/hero-bg.jpg', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/static/hero-bg.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'ota-ad-banner.png', 'image', 'image/png', '/static/ota-ad-banner.png', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/static/ota-ad-banner.png');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'service-hospitality.jpg', 'image', 'image/jpeg', '/static/service-hospitality.jpg', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/static/service-hospitality.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'service-property.jpg', 'image', 'image/jpeg', '/static/service-property.jpg', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/static/service-property.jpg');

INSERT INTO media_uploads (uploader_type, property_id, file_name, file_type, mime_type, file_url, file_size)
SELECT 'admin', NULL, 'service-solutions.jpg', 'image', 'image/jpeg', '/static/service-solutions.jpg', 0
WHERE NOT EXISTS (SELECT 1 FROM media_uploads WHERE file_url = '/static/service-solutions.jpg');
