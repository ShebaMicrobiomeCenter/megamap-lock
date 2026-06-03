# 🔐 MegaMap Lock - GitHub Action Setup Guide

## הגדרת GitHub Pages

### שלב 1: הפעל GitHub Pages
1. לך ל**Settings** של ה-Repository
2. בחר **Pages** מהתפריט הימני
3. תחת "Build and deployment":
   - בחר "Deploy from a branch"
   - בחר `master` (או `main`) ו-`/(root)`
4. לחץ **Save**

GitHub Pages יתחיל ליצור את האתר שלך. תוך מספר דקות, הוא יהיה זמין בכתובת:
```
https://[YOUR_USERNAME].github.io/megamap-lock/
```

---

## הגדרת GitHub Action לסנכרון קובץ מוצפן

### שלב 2: הגדר משתנים סביבה

GitHub Action `sync-encrypted-file.yml` צריך לדעת מאיפה להוריד את הקובץ. עליך להגדיר משתנים:

1. לך ל-**Settings** של ה-Repository שלך (megamap-lock)
2. בחר **Variables** בתפריט הימני
3. הוסף את המשתנים הבאים:

| משתנה | ערך | תיאור |
|------|-------|--------|
| `MEGAMAP_OWNER` | `ShebaMicrobiomeCenter` | בעל ה-Repository של MEGAMAP |
| `MEGAMAP_REPO` | `megamap` | שם ה-Repository של MEGAMAP |
| `MEGAMAP_FILE_PATH` | `latest-light.csv.enc` | נתיב הקובץ ב-Repository של MEGAMAP |

### שלב 3: בדוק הרשאות Token

ה-GitHub Action משתמש ב-`GITHUB_TOKEN` האוטומטי שיש לו גישה לקבצי public.
**אם ה-Repository של MEGAMAP הוא פרטי**, צריך Token בעל הרשאות נוספות:

1. לך ל-Settings של ה-Repository שלך
2. בחר **Secrets** (לא Variables)
3. בדוק אם קיים `GITHUB_TOKEN` - אם לא, לך לשלב הבא

#### אם צריך להוסיף Token פרטי:
1. לך ל-GitHub Settings האישיים שלך
2. בחר **Developer settings** → **Personal access tokens**
3. לחץ **Generate new token (classic)**
4. בחר הרשאות:
   - ✅ `repo` (גישה למלא ל-Repository)
   - ✅ `read:user`
5. כפול את ה-Token
6. חזור ל-**Repository Settings** → **Secrets**
7. הוסף Secret חדש:
   - שם: `MEGAMAP_TOKEN`
   - ערך: [הPAT שיצרת]

אז, עדכן את ה-GitHub Action כדי להשתמש בו:
```yaml
-H "Authorization: Bearer ${{ secrets.MEGAMAP_TOKEN }}"
```

---

## שימוש ב-GitHub Action

### אפשרות 1: סנכרון אוטומטי יומי
ה-Workflow עובד באופן אוטומטי כל יום בשעה 00:00 UTC.

כדי לשנות את הזמן, ערוך את `sync-encrypted-file.yml`:
```yaml
schedule:
  - cron: '0 0 * * *'  # שנה לשעה רצויה
```

[עזרה ב-Cron](https://crontab.guru/)

### אפשרות 2: הרץ ידנית
1. לך ל-**Actions** ב-Repository שלך
2. בחר **Sync Encrypted File from MEGAMAP** מהרשימה הימנית
3. לחץ **Run workflow**

### אפשרות 3: Webhook / GitHub dispatch
אם רוצים שהסנכרון יפעל מיד כשקובץ `latest-light.csv.enc` מתעדכן ב־MEGAMAP, אפשר להפעיל את ה-Workflow באמצעות `repository_dispatch`.

ב-Repository של MEGAMAP, ניתן להגדיר workflow שמריץ event ברגע שהקובץ מתעדכן, ושולח את האירוע לריפו הזה.

ה-Workflow ב־MEGAMAP יכול להשתמש ב-API של GitHub כך:

```bash
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token YOUR_PAT" \
  https://api.github.com/repos/ShebaMicrobiomeCenter/megamap-lock/dispatches \
  -d '{"event_type":"megamap-updated"}'
```

או ב-YAML של פעולה בתוך המגה־מאפ:

```yaml
on:
  push:
    paths:
      - latest-light.csv.enc

jobs:
  notify-lock:
    runs-on: ubuntu-latest
    steps:
      - name: Send repository dispatch to megamap-lock
        run: |
          curl -X POST \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: token ${{ secrets.PAT }}" \
            https://api.github.com/repos/ShebaMicrobiomeCenter/megamap-lock/dispatches \
            -d '{"event_type":"megamap-updated"}'
```

לאחר זה, `sync-encrypted-file.yml` בריפו הזה יפעיל את הסנכרון מיד.

---

## הצפנת קבצים דרך GitHub Action

### שלב 4: צור קובץ מוצפן באמצעות Workflow

אם יש לך קובץ CSV שאתה רוצה להצפין:

1. לך ל-**Actions**
2. בחר **Encrypt File** מהרשימה
3. לחץ **Run workflow**
4. מלא:
   - **CSV file URL**: קישור לקובץ CSV (יכול להיות URL לגיטהאב או כל מקום אחר)
   - **Password**: הסיסמה להצפנה
   - **Output filename**: שם הקובץ המוצפן (ללא .enc)

הקובץ המוצפן יישמר ב-Repository.

---

## הגדרה של .gitignore

וודא שקבצים מסוגים מסוימים לא יעלו גם אם הם אינם צריכים:

```gitignore
# Encrypted files
*.enc

# Temp files
*.tmp
input.csv
```

---

## דוגמה: זרימת עבודה מלאה

```
1. ערוך את המשתנים בעמוד ה-Repository
   ↓
2. GitHub Action ירוץ כל יום בחצות
   ↓
3. הוא יוריד את latest-light.csv.enc מ-MEGAMAP
   ↓
4. יעלה את הקובץ ל-master branch
   ↓
5. GitHub Pages יעדכן את index.html עם הקובץ החדש
   ↓
6. המשתמש כנס ל-megamap-lock.github.io
   ↓
7. בוחר את הקובץ ומכניס סיסמה
   ↓
8. הנתונים מפוענחים בחיית ה-browser
```

---

## חיפוש בעיות (Troubleshooting)

### ❌ "Repository not found" / "Not Found"
- בדוק שהמשתנים הוגדרו כמו שצריך
- וודא ש-Token יש גישה לה-MEGAMAP Repository
- בדוק שנתיב הקובץ כון

### ❌ "Failed to decode base64"
- בדוק שהקובץ קיים ב-MEGAMAP
- וודא שהנתיב לא יש בו spaces או תווים מיוחדים

### ❌ GitHub Pages לא מתעדכן
- לך ל-**Actions** וברר אם ה-Workflow רץ בהצלחה
- בדוק ב-**Pages** שה-deployment היה בהצלחה

---

## שיפור האבטחה

### 🔒 המלצות:

1. **שמור סיסמה חזקה** - לא משתמש בקביעה בחצי
2. **הגבל גישה** - דאג ש-Token של GitHub יש הרשאות מינימליות
3. **סקור לוגים** - בדוק את ה-GitHub Actions logs כדי לוודא כל רץ כצפוי
4. **סנכרון בתדירות בטוחה** - לא תרוץ הצפנה כל דקה (עלויות של GitHub)

---

## צרוך עזרה?

תן לי לדעת אם יש לך שאלות על ההגדרה! 🚀
