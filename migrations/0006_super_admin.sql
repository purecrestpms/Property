-- Migration 0006: Super admin setup and role column fix

-- Ensure role column exists in admin_accounts (safe no-op if exists)
-- Update existing default admin password (they can change later from Users panel)
UPDATE admin_accounts SET role = 'admin' WHERE role IS NULL;

-- Insert a fresh default admin account (if table was just created)
INSERT OR IGNORE INTO admin_accounts (username, email, full_name, password, role) VALUES
  ('admin', 'admin@purecrest.ng', 'PureCrest Admin', 'purecrest2024', 'admin');
