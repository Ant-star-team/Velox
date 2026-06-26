-- ═══════════════════════════════════════════════════════════
--  VELOX — SUPABASE DATABASE SETUP
--  Run this in: Supabase Dashboard → SQL Editor → New Query
-- ═══════════════════════════════════════════════════════════

-- 1. Create the user data table
CREATE TABLE IF NOT EXISTS velox_user_data (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id       UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  cities        JSONB DEFAULT '[]'::jsonb,
  friends       JSONB DEFAULT '[]'::jsonb,
  reminders     JSONB DEFAULT '[]'::jsonb,
  countdowns    JSONB DEFAULT '[]'::jsonb,
  settings      JSONB DEFAULT '{}'::jsonb,
  format24      BOOLEAN DEFAULT true,
  watch_tz      TEXT DEFAULT '',
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (VERY IMPORTANT — without this anyone can read your data)
ALTER TABLE velox_user_data ENABLE ROW LEVEL SECURITY;

-- 3. Policy: Users can only see and edit their OWN data
CREATE POLICY "Users can view own data"
  ON velox_user_data FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own data"
  ON velox_user_data FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own data"
  ON velox_user_data FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own data"
  ON velox_user_data FOR DELETE
  USING (auth.uid() = user_id);

-- 4. Auto-update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER velox_updated_at
  BEFORE UPDATE ON velox_user_data
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ═══════════════════════════════════════════════════════════
--  DONE! Your database is ready.
--  Next steps:
--  1. Go to Authentication → Providers → Enable Email
--  2. Go to Authentication → Providers → Enable Google
--     (needs Google OAuth credentials from console.cloud.google.com)
--  3. Go to Authentication → URL Configuration
--     Add your Vercel URL to "Redirect URLs":
--     https://your-velox-app.vercel.app
-- ═══════════════════════════════════════════════════════════
