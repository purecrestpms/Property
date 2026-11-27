-- Migration 0016: Update Richgate Apartments address to Thinkers Corner Enugu, remove PC-ENUGU-01 code,
-- replace Virtual Support & Pure Crest Technology images with attached assets, and clean up Solutions settings.

-- 1. Update Richgate Apartments Enugu location, address, description, and clean listing slug
UPDATE properties
SET
  listing_id = 'richgate-apartments-enugu',
  address = 'Plot C16-C, Fabian Okafor Close, Along Old Airport Road',
  area = 'Thinkers Corner',
  city = 'Enugu',
  state = 'Enugu',
  location = 'Thinkers Corner, Enugu',
  description = 'Signature serviced apartments and luxury boutique hotel suites at Plot C16-C, Fabian Okafor Close, Along Old Airport Road, Thinkers Corner, Enugu. Choose between self-catering studios with fitted kitchenettes, spacious one-bedroom residences, and refined hotel suites — backed by 24/7 power, high-speed WiFi, smart TV entertainment, and attentive concierge hospitality.',
  updated_at = CURRENT_TIMESTAMP
WHERE listing_id = 'PC-ENUGU-01' OR LOWER(title) LIKE '%richgate%';

-- Update any existing bookings, inquiries, videos, or media linked to PC-ENUGU-01
UPDATE bookings SET property_listing_id = 'richgate-apartments-enugu' WHERE property_listing_id = 'PC-ENUGU-01';
UPDATE inquiries SET property_listing_id = 'richgate-apartments-enugu' WHERE property_listing_id = 'PC-ENUGU-01';
UPDATE property_videos SET property_listing_id = 'richgate-apartments-enugu' WHERE property_listing_id = 'PC-ENUGU-01';
UPDATE virtual_tours SET property_listing_id = 'richgate-apartments-enugu' WHERE property_listing_id = 'PC-ENUGU-01';

-- 2. Replace Virtual Support image & Pure Crest Technology / PMS images in site_settings
INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('service_img_virtual_support', '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png');

INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('vs_hero_image', '/assets/aistudio/F1834A2C-2DF3-4AEB-8A69-8229BB53CCAC_9dec0e0c.png');

INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('service_img_solutions', '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png');

INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('technology_hero_image', '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png');

INSERT OR REPLACE INTO site_settings (key, value)
VALUES ('pms_banner_image', '/assets/aistudio/3C945DE4-8BB6-448E-8828-635AEAEE8958_d7ecfef0.png');

-- 3. Update Property Services hero heading and remove Solutions page settings
UPDATE site_settings
SET value = 'Property Sales, Leasing' || CHAR(10) || '& Advisory'
WHERE key = 'prop_hero_title' AND value LIKE '%Real Estate Solutions%';

DELETE FROM site_settings
WHERE key IN ('solutions_hero_image', 'sol_hero_title', 'sol_hero_subtitle', 'sol_cta_title', 'sol_cta_subtitle');
