# Saranathan College of Engineering Interactive AI Portal

Welcome to the AI-Powered Portal for Saranathan College of Engineering. This system is a fully functional web portal featuring dynamic database interactions, a 3D procedural campus model (Three.js), pathfinding directions navigation, and a Gemini-powered chatbot system.

---

## Technical Features

1. **Futuristic Glassmorphic Theme**: Dark/Light mode switcher with custom particle mouse cursor, blur backdrops, and neon indicators.
2. **Peel Welcome Sticker Poster**: Canvas-based unpeeling overlay with synthesized congratulatory welcome sounds (Web Audio API) and confetti celebrate explosions.
3. **3D Interactive Campus**: Dynamic PerspectiveCamera grid displaying CSE, ECE, Library, Admin, Hostel and Playground blocks with custom highlight outlines and click raycasting details.
4. **Pedestrian Map Pathfinder**: Dijkstra pathfinding algorithm mapping walking path routes between buildings on campus with duration meters estimation.
5. **Dynamic SSO Auth Ledger**:
   - Tab-based logins with credentials checks.
   - Student registrations go into the **Staff approval queue** before activation.
   - Dynamic **Forgot Password** default credentials resets.
6. **Gemini AI Chatbot**: Conversational rules matching library stacks indexes (floor, rack, shelf) and powered by server-side Google Gemini API.

7. **Personalized Dashboards**:
   - Student: GPA tracking, subject attendance progress rings, assignments download, urgent pending fee statements with pay buttons.
   - Staff: Marks/Grades ledger uploads, roster directory, new registrations approval board.
   - Admin: Analytics dashboard powered by Chart.js graphs mapping system statistics.

---

## Mock Sign-in Credentials

The database is pre-seeded with these credentials:

* **Student Account**:
  - Roll Number: `STU001`
  - Password: `student`
* **Staff Account**:
  - Email: `kumar@saranathan.ac.in`
  - Password: `teacher`
* **Admin Account**:
  - Username: `admin`
  - Password: `admin`

---

## Launch Instructions

To install dependencies and start the portal locally:

1. Open a terminal in this directory.
2. Run `npm install` to download server modules.
3. Copy `backend/.env.example` to `backend/.env` and set `GEMINI_API_KEY`.
4. Run `npm start` to run the Express backend server.
5. Navigate your browser to: **`http://localhost:3000`**

