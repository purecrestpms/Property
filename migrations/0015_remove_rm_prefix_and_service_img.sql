-- Migration 0015: Remove RM- number prefixes from Richgate Apartments room types & seed Card 4 virtual support image

UPDATE property_rooms
SET room_name = CASE
  WHEN room_name LIKE 'RM-1 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-2 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-3 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-4 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-5 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-6 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-7 %' THEN SUBSTR(room_name, 6)
  WHEN room_name LIKE 'RM-8 %' THEN SUBSTR(room_name, 6)
  ELSE room_name
END
WHERE room_name LIKE 'RM-%';

INSERT OR IGNORE INTO site_settings (key, value)
VALUES ('service_img_virtual_support', '/assets/aistudio/IMG_1793_3e8044d1.jpeg');
