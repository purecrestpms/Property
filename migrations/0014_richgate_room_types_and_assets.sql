-- Migration 0014: Update hero copy/buttons & update Richgate Apartments Enugu (PC-ENUGU-01) with attached photos and 8 Serviced Apartment + Hotel Room types

UPDATE site_settings SET value = 'Hospitality & Property
Management' WHERE key = 'hero_title';

UPDATE site_settings SET value = 'Purecrest delivers premier hotel & short-let management, property sales, leasing, and real estate advisory across Nigeria — helping property owners maximize returns and guests enjoy exceptional stays.' WHERE key = 'hero_subtitle';

UPDATE site_settings SET value = 'Our Services' WHERE key = 'hero_cta_1_text';
UPDATE site_settings SET value = '/services' WHERE key = 'hero_cta_1_url';
UPDATE site_settings SET value = 'Contact Us' WHERE key = 'hero_cta_2_text';
UPDATE site_settings SET value = '/contact' WHERE key = 'hero_cta_2_url';

-- Update Richgate Apartments Enugu images & starting nightly rate (₦55,000)
UPDATE properties
SET
  price = 55000,
  price_per_night = 55000,
  is_featured = 1,
  status = 'active',
  description = 'Signature serviced apartments and luxury boutique hotel suites in Independence Layout, Enugu. Choose between self-catering studios with fitted kitchenettes, spacious one-bedroom residences, and refined hotel suites — backed by 24/7 power, high-speed WiFi, smart TV entertainment, and attentive concierge hospitality.',
  images = '["/assets/aistudio/file_000000003fc881f4b5e66b7352a17edc_c7ca46a2.png","/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png","/assets/aistudio/IMG_2050_feea3d0a.png","/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_1943_ce327c41.webp"]'
WHERE listing_id = 'PC-ENUGU-01';

-- Replace Richgate rooms with the exact 8 Serviced Apartment & Hotel Room categories
DELETE FROM property_room_images
WHERE property_id = (SELECT id FROM properties WHERE listing_id = 'PC-ENUGU-01');

DELETE FROM property_rooms
WHERE property_id = (SELECT id FROM properties WHERE listing_id = 'PC-ENUGU-01');

-- SERVICED APARTMENT SECTION (RM-1 to RM-3)
INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-1 Deluxe Studio with Kitchenette',
  'Serviced Apartment',
  'Executive open-plan serviced studio featuring a plush king bed, full work desk, fitted kitchenette with gas hob, extractor hood, and microwave, plus spa-grade marble bathroom.',
  65500, 2, 1, 1,
  '["Fitted Kitchenette","Gas Hob & Range Hood","Microwave & Fridge","King Bed","Smart TV","Work Desk","High-Speed WiFi","Rain Shower"]',
  '["/assets/aistudio/C9775D2D-5C32-4EDC-9072-A3320F21BA93_0df87c78.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 1
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-2 One Bedroom Suite Apartment',
  'Serviced Apartment',
  'Spacious one-bedroom serviced residence with separate lounge and dining bar, fitted kitchen, PlayStation console & smart TV entertainment, upholstered king bedroom, and luxury bathroom.',
  80000, 3, 1, 1,
  '["Separate Lounge & Dining","Fitted Full Kitchenette","PS5 Gaming & Smart TV","King Bedroom + Bench","High-Speed WiFi","24/7 Power","Daily Housekeeping"]',
  '["/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 2
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-3 Standard Studio with Kitchenette',
  'Serviced Apartment',
  'Cozy serviced studio suite with velvet loveseat lounge, breakfast bar seating, fitted kitchenette (microwave, mini-fridge & gas cooker), and contemporary marble bathroom.',
  55000, 2, 1, 1,
  '["Fitted Kitchenette","Lounge Loveseat","Bar Stool Counter","Microwave & Mini-Fridge","Air Conditioning","High-Speed WiFi","En-suite Marble Bath"]',
  '["/assets/aistudio/IMG_2050_feea3d0a.png","/assets/aistudio/IMG_2048_7ce0a046.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 3
FROM properties WHERE listing_id = 'PC-ENUGU-01';

-- HOTEL ROOMS SECTION (RM-4 to RM-8)
INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-4 Deluxe Studio',
  'Hotel Room',
  'Refined hotel studio featuring marble flooring, tufted king headboard with wood-slat accent lighting, comfortable reading armchair, climate control, and backlit mirror bathroom.',
  55000, 2, 1, 1,
  '["King Bed","Lounge Armchair","Marble Flooring","Split Air Conditioning","In-Room Phone & WiFi","Backlit Rain Shower"]',
  '["/assets/aistudio/IMG_2051_812531ee.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 4
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-5 Standard Studio',
  'Hotel Room',
  'Warm contemporary hotel studio appointed with vertical walnut slat paneling, amber pendant lighting, tufted king bed with storage ottoman, armchair, and walk-in marble shower.',
  58000, 2, 1, 1,
  '["King Bed & Ottoman","Warm Ambient Lighting","Lounge Chair & Table","Air Conditioning","High-Speed WiFi","Rain Shower Bath"]',
  '["/assets/aistudio/file_0000000010048243a99f6cbf32d7ed60_c627ea67.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 5
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-6 Standard Studio',
  'Hotel Room',
  'Crisp minimalist studio with charcoal upholstered king headboard, timber wall paneling, floor-to-ceiling drapery, bedside desk phone, and designer en-suite bathroom.',
  55000, 2, 1, 1,
  '["King Bed","Timber Accent Wall","Blackout Curtains","High-Speed WiFi","Daily Housekeeping","Walk-In Glass Shower"]',
  '["/assets/aistudio/IMG_2191_d323fbad.png","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 6
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-7 Standard Studio',
  'Hotel Room',
  'Bright corner hotel studio with built-in full-height wardrobe, cushioned king bed, vertical wood-slat sconce lighting, and marble rain-shower bathroom.',
  65000, 2, 1, 1,
  '["King Bed","Walk-In Wardrobe","Sconce Mood Lighting","Air Conditioning","High-Speed WiFi","En-suite Marble Bath"]',
  '["/assets/aistudio/IMG_1946_70564288.webp","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 7
FROM properties WHERE listing_id = 'PC-ENUGU-01';

INSERT INTO property_rooms (property_id, room_name, room_type, description, price_per_night, max_guests, bedrooms, bathrooms, amenities, images, is_available, sort_order)
SELECT id,
  'RM-8 One Bedroom Suite',
  'Hotel Room',
  'Signature executive hotel suite combining an expansive cream-tufted king bedroom with ottoman, private living area with smart entertainment, and luxury marble bathroom.',
  75000, 3, 1, 1,
  '["Separate Living Area","King Bedroom & Ottoman","Smart TV","Work & Lounge Seating","High-Speed WiFi","24/7 Concierge & Power"]',
  '["/assets/aistudio/IMG_2192_852c7555.png","/assets/aistudio/IMG_1793_3e8044d1.jpeg","/assets/aistudio/IMG_1943_ce327c41.webp"]',
  1, 8
FROM properties WHERE listing_id = 'PC-ENUGU-01';
