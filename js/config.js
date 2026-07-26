// js/config.js
// Centralized configuration for external API integrations.
// SECURITY: Do NOT place API secrets in client-side bundles.
// Gemini API key is loaded from backend environment variable `GEMINI_API_KEY`.

export const GEMINI_API_KEY = typeof window !== 'undefined' && window.GEMINI_API_KEY ? window.GEMINI_API_KEY : '';


