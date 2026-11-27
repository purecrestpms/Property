-- Remove stored office_address and update contact_office_intro to omit office visit wording
DELETE FROM site_settings WHERE key = 'office_address';

INSERT INTO site_settings (key, value)
VALUES (
  'contact_office_intro',
  'Call us, chat on WhatsApp, or send a message — we''re available to help you navigate your real estate and hospitality journey.'
)
ON CONFLICT(key) DO UPDATE SET value = excluded.value, updated_at = CURRENT_TIMESTAMP;
