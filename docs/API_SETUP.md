# API Setup Guide

This app uses **Google Gemini 3.5 Flash** for AI-powered supply chain analysis.
You need a Gemini API key to run the app.

## Getting a Gemini API Key

1. Go to [Google AI Studio](https://aistudio.google.com/apikey)
2. Sign in with your Google account
3. Click **"Create API Key"**
4. Select or create a Google Cloud project
5. Copy the generated API key

## Setting the Key

1. In the project root (`C:\goods_scanner`), locate `.env.example`
2. Duplicate it and rename to `.env`
3. Open `.env` and paste your key:
   ```
   GEMINI_API_KEY=AIzaSy...
   ```

## Verify It Works

Run the app. If the key is missing or invalid, you'll see an error message on the analysis screen.

## API Limits (Free Tier)

| Limit | Value |
|---|---|
| Requests per minute | 15 |
| Tokens per day (3.5 Flash) | 1,000,000 |
| Tokens per minute | 4,000 |

If you exceed limits, wait a minute and retry.

## Security

- `.env` is listed in `.gitignore` — your key will **never** be committed
- Do not share your `.env` file
- If you accidentally commit a key, revoke it immediately in [Google AI Studio](https://aistudio.google.com/apikey)
