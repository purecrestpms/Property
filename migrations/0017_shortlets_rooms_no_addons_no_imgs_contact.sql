-- Remove two duplicate Standard Studio hotel rooms from Richgate Apartments Enugu
DELETE FROM property_room_images
WHERE room_id IN (
  SELECT id FROM property_rooms
  WHERE property_id IN (
    SELECT id FROM properties
    WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01')
       OR LOWER(title) LIKE '%richgate%'
  )
    AND room_type = 'Hotel Room'
    AND room_name = 'Standard Studio'
    AND price_per_night IN (58000, 65000)
);

DELETE FROM property_rooms
WHERE property_id IN (
  SELECT id FROM properties
  WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01')
     OR LOWER(title) LIKE '%richgate%'
)
  AND room_type = 'Hotel Room'
  AND room_name = 'Standard Studio'
  AND price_per_night IN (58000, 65000);

-- Re-normalize sort_order for remaining Richgate rooms
UPDATE property_rooms SET sort_order = 1 WHERE room_name = 'Deluxe Studio with Kitchenette' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');
UPDATE property_rooms SET sort_order = 2 WHERE room_name = 'One Bedroom Suite Apartment' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');
UPDATE property_rooms SET sort_order = 3 WHERE room_name = 'Standard Studio with Kitchenette' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');
UPDATE property_rooms SET sort_order = 4 WHERE room_name = 'Deluxe Studio' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');
UPDATE property_rooms SET sort_order = 5 WHERE room_name = 'Standard Studio' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');
UPDATE property_rooms SET sort_order = 6 WHERE room_name = 'One Bedroom Suite' AND property_id IN (SELECT id FROM properties WHERE listing_id IN ('richgate-apartments-enugu', 'PC-ENUGU-01') OR LOWER(title) LIKE '%richgate%');

-- Remove stored images for Property Services and Hospitality Services
DELETE FROM site_settings
WHERE key IN (
  'service_img_hospitality',
  'service_img_property',
  'hospitality_hero_image',
  'hospitality_partner_image',
  'property_hero_image'
);
