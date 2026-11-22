-- Seed data for PureCrest Properties

-- Admin accounts
INSERT OR IGNORE INTO admin_accounts (username, email, full_name, password, role) VALUES
  ('admin', 'admin@purecrest.ng', 'PureCrest Admin', 'purecrest2024', 'super_admin'),
  ('manager', 'manager@purecrest.ng', 'Property Manager', 'purecrest@manager', 'admin');

-- Agents
INSERT OR IGNORE INTO agents (name, email, phone, whatsapp, agency_name, specialization, status, is_verified, rating, years_experience, bio) VALUES
  ('Amara Okafor', 'amara@purecrest.ng', '+2348012345678', '+2348012345678', 'PureCrest Realty', 'Residential', 'active', 1, 4.8, 7, 'Experienced agent specializing in Maitama and Asokoro luxury properties.'),
  ('Emeka Nwosu', 'emeka@purecrest.ng', '+2348023456789', '+2348023456789', 'PureCrest Realty', 'Short Let', 'active', 1, 4.6, 5, 'Short-let specialist with portfolio across Wuse 2 and Garki.'),
  ('Fatima Bello', 'fatima@purecrest.ng', '+2348034567890', '+2348034567890', 'PureCrest Realty', 'Commercial', 'active', 1, 4.9, 10, 'Commercial and residential expert for Jabi and Utako areas.');

-- Properties - For Sale
INSERT OR IGNORE INTO properties (listing_id, title, description, property_type, category, price, price_period, bedrooms, bathrooms, toilets, size_sqm, location, address, area, city, state, is_featured, is_verified, status, facilities, images, agent_id) VALUES
('PC-001', '5 Bedroom Duplex in Maitama', 'Luxury 5 bedroom duplex with BQ, swimming pool, and excellent finishing in the heart of Maitama. Perfect for families seeking premium living in Abuja''s most prestigious neighbourhood.', 'Duplex', 'buy', 185000000, 'outright', 5, 5, 6, 420, 'Maitama, Abuja', '14 Udi Hills Street, Maitama', 'Maitama', 'Abuja', 'FCT', 1, 1, 'active', '["Swimming Pool","Boys Quarter","Generator","CCTV","Fitted Kitchen","Air Conditioning","Security","Parking Space","Water Treatment"]', '["https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800","https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800","https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800","https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800"]', 1),

('PC-002', '4 Bedroom Detached House in Asokoro', 'Beautifully designed 4 bedroom detached house with modern fittings, double garage and spacious compound. Located in the serene diplomatic zone of Asokoro.', 'Detached House', 'buy', 120000000, 'outright', 4, 4, 5, 350, 'Asokoro, Abuja', '7 Paraguay Street, Asokoro', 'Asokoro', 'Abuja', 'FCT', 1, 1, 'active', '["Generator","Security","CCTV","Fitted Kitchen","Air Conditioning","Parking Space","Borehole","Tiled Floors"]', '["https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800","https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800","https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800","https://images.unsplash.com/photo-1600607687644-c7171b46ba42?w=800"]', 1),

('PC-003', '3 Bedroom Apartment in Wuse 2', 'Modern 3 bedroom apartment on 5th floor with panoramic city views. Premium location in Wuse 2 business district with 24/7 security and backup power.', 'Apartment', 'buy', 75000000, 'outright', 3, 3, 3, 210, 'Wuse 2, Abuja', 'Plot 1462 Aminu Kano Crescent, Wuse 2', 'Wuse 2', 'Abuja', 'FCT', 0, 1, 'active', '["Generator","24/7 Security","CCTV","Fitted Kitchen","Air Conditioning","Parking Space","Elevator","Gym"]', '["https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800","https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800","https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800","https://images.unsplash.com/photo-1560185893-a55cbc8c57e8?w=800"]', 2),

-- Properties - For Rent
('PC-004', '3 Bedroom Apartment in Jabi', 'Well maintained 3 bedroom apartment in a serene estate in Jabi. Close to Jabi Lake and amenities. Available for immediate occupation.', 'Apartment', 'rent', 3500000, 'year', 3, 3, 3, 185, 'Jabi, Abuja', 'Jabi Lake View Estate, Jabi', 'Jabi', 'Abuja', 'FCT', 0, 1, 'active', '["Generator","Security","CCTV","Air Conditioning","Parking Space","Borehole","Tiled Floors"]', '["https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800","https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800","https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800","https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800"]', 2),

('PC-005', '2 Bedroom Flat in Garki', 'Clean 2 bedroom flat in a well-managed block in Garki Area 11. Suitable for couples or small families. Easy access to city center.', 'Flat', 'rent', 1800000, 'year', 2, 2, 2, 120, 'Garki, Abuja', 'Area 11 Street, Garki', 'Garki', 'Abuja', 'FCT', 0, 1, 'active', '["Generator","Security","Parking Space","Borehole"]', '["https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800","https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800","https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?w=800","https://images.unsplash.com/photo-1583845112239-97ef1341b271?w=800"]', 3),

('PC-006', '4 Bedroom Terrace in Utako', 'Spacious 4 bedroom terrace duplex in a serene street in Utako. Features a BQ, parking for 3 cars and is POP finished.', 'Terrace', 'rent', 4500000, 'year', 4, 3, 4, 280, 'Utako, Abuja', 'Utako District, Abuja', 'Utako', 'Abuja', 'FCT', 1, 1, 'active', '["Boys Quarter","Generator","Security","CCTV","Air Conditioning","Parking Space","Borehole","Tiled Floors"]', '["https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800","https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?w=800","https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800","https://images.unsplash.com/photo-1565183997392-2f6f122e5912?w=800"]', 1),

-- Short Let Properties
('PC-007', 'Luxury 2-Bed Apartment - Wuse 2', 'Fully furnished luxury 2 bedroom apartment in Wuse 2. Perfect for business travellers and tourists. Comes with Netflix, WiFi, fully equipped kitchen and daily cleaning.', 'Apartment', 'short-let', 45000, 'night', 2, 2, 2, 130, 'Wuse 2, Abuja', 'Aminu Kano Crescent, Wuse 2', 'Wuse 2', 'Abuja', 'FCT', 1, 1, 'active', '["WiFi","Smart TV","Netflix","Air Conditioning","Fully Equipped Kitchen","Washing Machine","Daily Cleaning","24/7 Security","Parking","Power Backup"]', '["https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800","https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800","https://images.unsplash.com/photo-1560185007-cde436f6a4d0?w=800","https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800"]', 2),

('PC-008', 'Modern Studio in Maitama', 'Chic fully furnished studio apartment in Maitama. Perfect for solo travellers. Walking distance to shops and restaurants. Minimum 2 nights stay.', 'Studio', 'short-let', 28000, 'night', 1, 1, 1, 60, 'Maitama, Abuja', 'Maitama District, Abuja', 'Maitama', 'Abuja', 'FCT', 0, 1, 'active', '["WiFi","Smart TV","Air Conditioning","Kitchenette","24/7 Security","Parking"]', '["https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=800","https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800","https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800","https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800"]', 2),

('PC-009', '3 Bedroom Shortlet in Garki', 'Beautiful 3 bedroom apartment perfect for families or groups. Located in Garki with easy access to CBD. Features full amenities and professional management.', 'Apartment', 'short-let', 65000, 'night', 3, 3, 3, 200, 'Garki, Abuja', 'Garki Area 11, Abuja', 'Garki', 'Abuja', 'FCT', 1, 1, 'active', '["WiFi","Smart TV","Netflix","Air Conditioning","Fully Equipped Kitchen","Washing Machine","Daily Cleaning","24/7 Security","Parking","Power Backup","BBQ Area"]', '["https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800","https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800","https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800","https://images.unsplash.com/photo-1560185007-cde436f6a4d0?w=800"]', 3),

-- Land
('PC-010', '1000 SQM Land in Guzape', 'Prime 1000 SQM residential land in Guzape District. C of O available. Excellent investment opportunity in a fast developing area.', 'Land', 'land', 45000000, 'outright', 0, 0, 0, 1000, 'Guzape, Abuja', 'Guzape District, Abuja', 'Guzape', 'Abuja', 'FCT', 0, 1, 'active', '["C of O","Survey Plan","Perimeter Fencing","Road Network","Electricity"]', '["https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800","https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800","https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=800","https://images.unsplash.com/photo-1416331108676-a22ccb276e35?w=800"]', 1),

-- More short-lets for Maitama
('PC-011', '1 Bedroom Executive Suite - Maitama', 'Upscale executive 1 bedroom suite in Maitama with rooftop access. Ideal for executives visiting Abuja on business. Ultra-modern interiors.', 'Apartment', 'short-let', 38000, 'night', 1, 1, 1, 75, 'Maitama, Abuja', 'Maitama District, Abuja', 'Maitama', 'Abuja', 'FCT', 0, 1, 'active', '["WiFi","Smart TV","Netflix","Air Conditioning","Fully Equipped Kitchen","24/7 Security","Parking","Rooftop Access","Workspace"]', '["https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800","https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800","https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=800","https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800"]', 2),

('PC-012', '5 Bedroom Villa in Asokoro', 'Grand 5 bedroom villa with private swimming pool and garden in Asokoro. Ideal for high-profile guests and extended family stays. Staff quarters included.', 'Villa', 'short-let', 150000, 'night', 5, 5, 6, 500, 'Asokoro, Abuja', 'Asokoro District, Abuja', 'Asokoro', 'Abuja', 'FCT', 1, 1, 'active', '["Swimming Pool","Private Garden","WiFi","Smart TV","Netflix","Air Conditioning","Fully Equipped Kitchen","Washing Machine","Daily Cleaning","24/7 Security","Parking","Staff Quarters","BBQ Area","Gym"]', '["https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800","https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800","https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800","https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800"]', 1);

-- Update short-let specific fields
UPDATE properties SET price_per_night = price, min_nights = 1, max_nights = 30, 
  check_in_time = '14:00', check_out_time = '11:00',
  house_rules = '["No smoking inside","No loud music after 10pm","No unauthorized guests","Keep property clean"]',
  amenities = facilities,
  cancellation_policy = 'flexible'
WHERE category = 'short-let';

-- Sample inquiries
INSERT OR IGNORE INTO inquiries (property_id, property_listing_id, full_name, phone, email, message, inquiry_type, status) VALUES
  (1, 'PC-001', 'Chukwudi Obi', '+2348055667788', 'chukwudi@email.com', 'I am interested in this property. Please arrange a viewing.', 'callback', 'new'),
  (7, 'PC-007', 'Ngozi Adeyemi', '+2348066778899', 'ngozi@email.com', 'I need this for 5 nights from December 20th. Is it available?', 'whatsapp', 'new'),
  (4, 'PC-004', 'Musa Ibrahim', '+2348077889900', '', 'How soon can I move in? I need a 3 bedroom urgently.', 'callback', 'new');

-- Site settings
INSERT OR IGNORE INTO site_settings (key, value) VALUES
  ('whatsapp_number', '+234 810 000 0000'),
  ('contact_email', 'info@purecrest.ng'),
  ('office_address', '3 Wuse 2 Street, Abuja, FCT'),
  ('hero_title', 'Find Your Perfect Property in Abuja'),
  ('hero_subtitle', 'Verified listings from trusted agents. Buy, Rent or Short Let with confidence.'),
  ('site_name', 'PureCrest Properties'),
  ('footer_tagline', 'Your trusted partner for verified real estate in Abuja, Nigeria.');
