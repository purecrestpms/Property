-- Migration 0008: Gallery table for images and videos
CREATE TABLE IF NOT EXISTS gallery (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL DEFAULT '',
  description TEXT DEFAULT '',
  media_type TEXT NOT NULL DEFAULT 'image',
  file_url TEXT NOT NULL,
  thumb_url TEXT DEFAULT '',
  source_type TEXT DEFAULT 'upload',
  youtube_id TEXT DEFAULT '',
  category TEXT DEFAULT 'general',
  sort_order INTEGER DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  file_size INTEGER DEFAULT 0,
  mime_type TEXT DEFAULT '',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_gallery_media_type ON gallery(media_type);
CREATE INDEX IF NOT EXISTS idx_gallery_category ON gallery(category);
CREATE INDEX IF NOT EXISTS idx_gallery_active ON gallery(is_active);

INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Modern Luxury Villa', 'A stunning modern villa with panoramic views', 'image', 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&q=80', 'url', 'property', 1, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Premium Apartment Complex', 'High-rise apartment complex in Abuja', 'image', 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80', 'url', 'property', 2, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Luxury Interior Design', 'Sophisticated interior design showcase', 'image', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80', 'url', 'hospitality', 3, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Hotel Lobby', 'World-class hospitality and comfort', 'image', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&q=80', 'url', 'hospitality', 4, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Commercial Property', 'Prime commercial real estate opportunities', 'image', 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80', 'url', 'property', 5, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Beautiful Cityscape', 'Nigeria vibrant real estate landscape', 'image', 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=800&q=80', 'url', 'general', 6, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, youtube_id, category, sort_order, is_active, mime_type) VALUES ('Property Showcase', 'Virtual property tour experience', 'video', 'https://www.youtube.com/embed/jNQXAC9IVRw', 'youtube', 'jNQXAC9IVRw', 'property', 7, 1, 'video/youtube');
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Shortlet Living Room', 'Premium shortlet apartment interior', 'image', 'https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=800&q=80', 'url', 'hospitality', 8, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Land Development', 'Strategic land acquisition and development', 'image', 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=80', 'url', 'property', 9, 1);
INSERT OR IGNORE INTO gallery (title, description, media_type, file_url, source_type, category, sort_order, is_active) VALUES ('Team Excellence', 'Our dedicated team delivering excellence', 'image', 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&q=80', 'url', 'team', 10, 1);
