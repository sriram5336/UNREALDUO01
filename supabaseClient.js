// js/supabaseClient.js
// Shared Supabase client — import this everywhere instead of creating
// a new client per file.

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const SUPABASE_URL = 'https://jkblwihozkqorberantm.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprYmx3aWhvemtxb3JiZXJhbnRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQ1NTU5MTcsImV4cCI6MjEwMDEzMTkxN30.iDwjs2fKpcL4eRLoXiRYvr3hFG7M3uwWJMuC4vPadwk';

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

