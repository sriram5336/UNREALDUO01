// Server-side Gemini client
// Uses Google Generative Language REST API (no SDK) to avoid extra dependencies.

async function generateGeminiResponse({ apiKey, model, message, systemInstruction }) {
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY is not set');
  }

  const modelsToTry = [
    model,
    'gemini-2.0-flash',
    'gemini-1.5-flash',
    'gemini-2.0-flash-lite',
    'gemini-flash-lite-latest',
    'gemini-flash-latest',
    'gemini-1.5-pro',
    'gemini-3.1-flash-lite',
    'gemini-3.6-flash',
    'gemini-2.5-flash-lite',
    'gemini-3-flash-preview',
    'gemini-3.1-flash-lite-preview',
    'gemini-3.5-flash-lite',
    'gemini-3.5-flash',
    'gemini-pro-latest',
    'gemma-4-26b-a4b-it',
    'gemma-4-31b-it'
  ].filter(Boolean);

  const body = {
    contents: [
      {
        role: 'user',
        parts: [
          { text: systemInstruction ? `${systemInstruction}\n\n${message}` : message }
        ]
      }
    ]
  };

  let lastError = null;

  for (const m of modelsToTry) {
    try {
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(m)}:generateContent?key=${encodeURIComponent(apiKey)}`;
      const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
      });

      if (res.ok) {
        const data = await res.json();
        const textOut =
          data?.candidates?.[0]?.content?.parts?.map(p => p?.text).filter(Boolean).join('') ||
          data?.candidates?.[0]?.content?.parts?.[0]?.text ||
          '';
        if (textOut) return { text: textOut, model: m };
      } else {
        const text = await res.text().catch(() => '');
        lastError = new Error(`Gemini model ${m} failed: ${res.status} ${res.statusText} ${text}`);
      }
    } catch (err) {
      lastError = err;
    }
  }

  throw lastError || new Error('All Gemini models failed');
}

module.exports = { generateGeminiResponse };

