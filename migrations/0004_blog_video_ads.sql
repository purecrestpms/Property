-- Migration 0004: Blog posts, video gallery, ads, hero settings, virtual tours

-- Ads / Banners table
CREATE TABLE IF NOT EXISTS ads (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  image_url TEXT,
  link_url TEXT,
  position TEXT DEFAULT 'sidebar', -- sidebar, banner_top, banner_bottom, inline
  is_active INTEGER DEFAULT 1,
  clicks INTEGER DEFAULT 0,
  impressions INTEGER DEFAULT 0,
  start_date TEXT,
  end_date TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Virtual tour bookings
CREATE TABLE IF NOT EXISTS virtual_tours (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_id INTEGER,
  property_listing_id TEXT,
  property_title TEXT,
  guest_name TEXT NOT NULL,
  guest_phone TEXT NOT NULL,
  guest_email TEXT,
  preferred_date TEXT NOT NULL,
  preferred_time TEXT NOT NULL,
  tour_type TEXT DEFAULT 'video_call', -- video_call, whatsapp_video, zoom, google_meet
  message TEXT,
  status TEXT DEFAULT 'pending', -- pending, confirmed, completed, cancelled
  admin_notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

-- Property videos (stored separately for gallery)
CREATE TABLE IF NOT EXISTS property_videos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  property_id INTEGER,
  property_listing_id TEXT,
  video_url TEXT NOT NULL, -- base64 data URL or external URL
  thumbnail_url TEXT,
  title TEXT,
  duration INTEGER, -- seconds
  file_size INTEGER,
  mime_type TEXT DEFAULT 'video/mp4',
  is_active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(id)
);

-- Update site settings with new keys
INSERT OR IGNORE INTO site_settings (key, value) VALUES
  ('hero_bg_image', ''),
  ('hero_bg_overlay', '0.55'),
  ('logo_text', 'PureCrest'),
  ('logo_subtitle', 'Properties'),
  ('phone_number', '+234 810 000 0000'),
  ('whatsapp_number', '+2348100000000'),
  ('office_address', '12 Adetokunbo Ademola Crescent, Wuse 2, Abuja, FCT'),
  ('facebook_url', '#'),
  ('instagram_url', '#'),
  ('twitter_url', '#'),
  ('whatsapp_url', '#'),
  ('ads_enabled', '1'),
  ('blog_enabled', '1');

-- Update hero title from "Perfect" to "Premium"
UPDATE site_settings SET value = 'Find Your Premium Property in Abuja' WHERE key = 'hero_title' AND value LIKE '%Perfect%';

-- Update office address to full Nigerian address
UPDATE site_settings SET value = '12 Adetokunbo Ademola Crescent, Wuse 2, Abuja, FCT' WHERE key = 'office_address';

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_virtual_tours_property ON virtual_tours(property_listing_id);
CREATE INDEX IF NOT EXISTS idx_virtual_tours_status ON virtual_tours(status);
CREATE INDEX IF NOT EXISTS idx_property_videos_property ON property_videos(property_listing_id);
CREATE INDEX IF NOT EXISTS idx_ads_position ON ads(position);
CREATE INDEX IF NOT EXISTS idx_ads_active ON ads(is_active);
CREATE INDEX IF NOT EXISTS idx_blog_status ON blog_posts(status);
CREATE INDEX IF NOT EXISTS idx_blog_slug ON blog_posts(slug);
