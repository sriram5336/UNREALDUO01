// Server-side Gemini client
// Uses Google Generative Language REST API (no SDK) to avoid extra dependencies.

async function generateGeminiResponse({ apiKey, model = 'gemini-1.5-flash', message, systemInstruction }) {
  if (!apiKey) {
    throw new Error('GEMINI_API_KEY is not set');
  }

  // Node 18+ has global fetch; for older Node versions you'd need node-fetch.


  const url = `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent?key=${encodeURIComponent(apiKey)}`;

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

  const res = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });

  if (!res.ok) {
    const text = await res.text().catch(() => '');
    throw new Error(`Gemini request failed: ${res.status} ${res.statusText} ${text}`.trim());
  }

  const data = await res.json();

  const textOut =
    data?.candidates?.[0]?.content?.parts?.map(p => p?.text).filter(Boolean).join('') ||
    data?.candidates?.[0]?.content?.parts?.[0]?.text ||
    '';

  return textOut;
}

module.exports = { generateGeminiResponse };

