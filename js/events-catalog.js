// Campus Events Catalog & Helper Functions

const EVENTS_CATALOG = [
  {
    id: 1,
    title: "AI & Data Science National Hackathon 2026",
    category: "Hackathon",
    date: "2026-08-15",
    time: "09:00 AM - 06:00 PM",
    venue: "Main Auditorium & Computing Hub",
    description: "24-hour intense coding challenge focusing on Agentic AI, Generative Models, and Smart City automation problems with cash awards.",
    poster: "events/18155204744545189.webp",
    organizer: "Dept. of AI & Data Science",
    status: "Upcoming",
    registrationLink: "login.html"
  },
  {
    id: 2,
    title: "Robotics & Autonomous Systems Expo",
    category: "Exhibition",
    date: "2026-08-22",
    time: "10:00 AM - 04:30 PM",
    venue: "Mechatronics & Robotics Lab",
    description: "Showcasing student-built autonomous drones, line followers, bipedal robots, and industrial arm prototypes.",
    poster: "events/3307399721672585.webp",
    organizer: "Dept. of Mechanical & ICE",
    status: "Registration Open",
    registrationLink: "login.html"
  },
  {
    id: 3,
    title: "CyberSecurity Summit & CTF Challenge",
    category: "Symposium",
    date: "2026-09-05",
    time: "09:30 AM - 05:00 PM",
    venue: "CSE Seminar Hall",
    description: "Hands-on Capture The Flag (CTF) security contest, penetration testing workshops, and guest lectures from industry experts.",
    poster: "events/60517188736893900.webp",
    organizer: "Dept. of CSE & IT",
    status: "Registration Open",
    registrationLink: "login.html"
  },
  {
    id: 4,
    title: "Annual Saranathan Chess Championship",
    category: "Sports",
    date: "2026-08-10",
    time: "02:00 PM - 07:00 PM",
    venue: "Indoor Sports Complex",
    description: "Blitz and Classical FIDE-rated chess tournament open to all engineering streams. Trophies and certificate distributions.",
    poster: "events/Chess Tournament Flyer Template AI, EPS, PSD.jpg",
    organizer: "Physical Education Dept.",
    status: "Ongoing",
    registrationLink: "login.html"
  },
  {
    id: 5,
    title: "Innovation & Developers Club Recruitment",
    category: "Club Event",
    date: "2026-08-01",
    time: "04:00 PM - 06:00 PM",
    venue: "Open Amphitheatre",
    description: "Join the official Saranathan Coding & Open-Source Guild! Interactive quizzes, live demos, and club orientation.",
    poster: "events/Club poster.webp",
    organizer: "Student Activity Council",
    status: "Upcoming",
    registrationLink: "login.html"
  },
  {
    id: 6,
    title: "TechSaranathan National Technical Symposium",
    category: "Symposium",
    date: "2026-09-18",
    time: "09:00 AM - 05:00 PM",
    venue: "Campus Wide Venues",
    description: "The flagship annual national level technical symposium featuring paper presentations, CAD modeling, project displays, and gaming.",
    poster: "events/Event Poster #3.jpg",
    organizer: "Saranathan Engineering Association",
    status: "Upcoming",
    registrationLink: "login.html"
  },
  {
    id: 7,
    title: "Inter-College Cultural & Arts Festival",
    category: "Cultural",
    date: "2026-10-02",
    time: "10:00 AM - 09:00 PM",
    venue: "Main Ground Stage",
    description: "Music, dance, battle of the bands, drama, and fine arts competitions showcasing talented youth across Tamil Nadu colleges.",
    poster: "events/Event Poster for Vikrant College.jpg",
    organizer: "Fine Arts Club",
    status: "Upcoming",
    registrationLink: "login.html"
  },
  {
    id: 8,
    title: "Cloud Native & DevOps Hands-On Workshop",
    category: "Workshop",
    date: "2026-08-28",
    time: "09:30 AM - 04:00 PM",
    venue: "IT Computer Lab 3",
    description: "Learn Docker, Kubernetes, CI/CD pipelines, and AWS deployment techniques in an intensive lab session.",
    poster: "events/Modern Event Flyer and Poster Template - Download Now!.webp",
    organizer: "Dept. of Information Technology",
    status: "Registration Open",
    registrationLink: "login.html"
  },
  {
    id: 9,
    title: "Saranathan Freshers Welcome Fiesta 2026",
    category: "Social Event",
    date: "2026-08-08",
    time: "03:00 PM - 07:30 PM",
    venue: "College Auditorium",
    description: "Grand welcome ceremony for the incoming batch of 2026-2030 engineers! Live music, performances, and ice-breaking games.",
    poster: "events/🎉 Get Ready for the Ultimate FRESHERS PARTY! 🎉.jpg",
    organizer: "Senior Student Executive Board",
    status: "Ongoing",
    registrationLink: "login.html"
  }
];

if (typeof window !== 'undefined') {
  window.EVENTS_CATALOG = EVENTS_CATALOG;
}
