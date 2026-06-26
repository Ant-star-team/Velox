# VELOX — Deploy Guide
## Supabase + GitHub + Vercel (Free Stack)

---

## STEP 1 — SUPABASE SETUP (5 minutes)

1. Go to **supabase.com** → Sign up free
2. Click **New Project** → name it `velox` → set a password → Create
3. Wait ~2 minutes for it to start
4. Go to **SQL Editor** → click **New Query**
5. Copy everything from `supabase-setup.sql` → Paste → Click **Run**
6. Go to **Settings → API**
7. Copy these two values — you need them in Step 3:
   - **Project URL** → looks like `https://abcdefgh.supabase.co`
   - **anon public** key → long string starting with `eyJ...`
8. Go to **Authentication → Providers**
   - Enable **Email** (toggle on)
   - Enable **Google** if you want Google login (needs Google OAuth setup)

---

## STEP 2 — GITHUB SETUP (3 minutes)

1. Go to **github.com** → Sign up free → New repository
2. Name it `velox` → Public → Create
3. Upload these 7 files to the repository root:
   ```
   index.html
   sw.js
   manifest.json
   vercel.json
   velox-watch.png
   icon-192.png
   icon-512.png
   ```
   (Do NOT upload supabase-setup.sql or this README publicly if you want privacy)
4. Click **Commit changes**

---

## STEP 3 — VERCEL SETUP (3 minutes)

1. Go to **vercel.com** → Sign up with GitHub
2. Click **Add New → Project**
3. Import your `velox` GitHub repository
4. **IMPORTANT — Add Environment Variables:**
   Click **Environment Variables** and add:
   ```
   Name:  SUPABASE_URL
   Value: https://your-project.supabase.co
   
   Name:  SUPABASE_KEY  
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9... (your anon key)
   ```
5. Click **Deploy**
6. Wait 1 minute → your app is live at `velox-xxx.vercel.app`

---

## STEP 4 — CONNECT SUPABASE TO VERCEL URL (2 minutes)

1. Go back to **Supabase → Authentication → URL Configuration**
2. Add your Vercel URL to **Redirect URLs**:
   ```
   https://your-velox-app.vercel.app
   ```
3. Save

---

## STEP 5 — ADD SUPABASE KEYS TO index.html

Open `index.html`, find these two lines (around line 1697):
```javascript
const SUPABASE_URL = '';  // ← Add your Supabase Project URL here
const SUPABASE_KEY = '';  // ← Add your Supabase anon key here
```

Replace with your actual values:
```javascript
const SUPABASE_URL = 'https://abcdefgh.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

Then push to GitHub → Vercel auto-deploys in 1 minute.

---

## STEP 6 — INSTALL ON PHONE

1. Open your Vercel URL in **Chrome** on Android
2. Tap **⋮ menu (3 dots)** → **Add to Home Screen**
3. Tap **Install**
4. Velox appears on your home screen like a real app
5. Works offline too!

**iPhone:** Open in Safari → tap Share button → **Add to Home Screen**

---

## HOW IT ALL WORKS TOGETHER

```
Your Phone
    ↓ opens
Vercel (hosts the app files)
    ↓ user signs in
Supabase (stores user data securely)
    ↓ data syncs
All your devices
```

- **Without login** → data saves on device via localStorage
- **With login** → data syncs across all devices via Supabase

---

## FREE TIER LIMITS (more than enough)

| Service | Free Limit |
|---------|-----------|
| Vercel | 100GB bandwidth/month |
| Supabase | 500MB database, 50k monthly active users |
| GitHub | Unlimited public repos |

**Total cost: $0/month** until you have thousands of daily users.

---

## NEED HELP?

- Supabase docs: docs.supabase.com
- Vercel docs: vercel.com/docs
- GitHub docs: docs.github.com
