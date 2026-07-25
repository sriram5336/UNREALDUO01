// 2D Campus Vector Map & Dijkstra Pathfinding Engine

const nodes = {
  "Main Gate": { x: 400, y: 500, label: "Main Entrance Gate" },
  "Junction 1": { x: 400, y: 420, isJunction: true },
  "Admin Block": { x: 400, y: 320, label: "Admin Block (Office)" },
  "Junction 2": { x: 400, y: 220, isJunction: true },
  "ECE Block": { x: 250, y: 220, label: "ECE Block" },
  "CSE Block": { x: 550, y: 220, label: "CSE Block" },
  "Library": { x: 220, y: 340, label: "Central Library" },
  "Auditorium": { x: 580, y: 340, label: "Auditorium" },
  "Canteen": { x: 200, y: 110, label: "Campus Canteen" },
  "Hostel Block": { x: 400, y: 90, label: "Hostel Block" },
  "Placement Cell": { x: 580, y: 440, label: "Placement Cell" },
  "Playground": { x: 600, y: 110, label: "Playground" }
};

const adjList = {
  "Main Gate": { "Junction 1": 80 },
  "Junction 1": { "Main Gate": 80, "Admin Block": 100, "Placement Cell": 180, "Library": 200 },
  "Admin Block": { "Junction 1": 100, "Junction 2": 100, "Library": 180, "Auditorium": 180 },
  "Junction 2": { "Admin Block": 100, "ECE Block": 150, "CSE Block": 150, "Hostel Block": 130 },
  "ECE Block": { "Junction 2": 150, "Canteen": 110, "Hostel Block": 200 },
  "CSE Block": { "Junction 2": 150, "Playground": 110, "Hostel Block": 200 },
  "Library": { "Junction 1": 200, "Admin Block": 180 },
  "Auditorium": { "Admin Block": 180 },
  "Canteen": { "ECE Block": 110, "Hostel Block": 200 },
  "Hostel Block": { "Junction 2": 130, "ECE Block": 200, "CSE Block": 200, "Canteen": 200, "Playground": 200 },
  "Placement Cell": { "Junction 1": 180 },
  "Playground": { "CSE Block": 110, "Hostel Block": 200 }
};

let activePath = [];

document.addEventListener('DOMContentLoaded', () => {
  initMapCanvas();
});

function initMapCanvas() {
  const canvas = document.getElementById('map-canvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  
  const sourceSelect = document.getElementById('route-source');
  const destSelect = document.getElementById('route-dest');
  const mapBtn = document.getElementById('find-route-btn');
  
  function resizeCanvas() {
    // Keep internal canvas scale fixed (e.g. 800x600) for coordinates logic, but stretch styling responsive
    canvas.width = 800;
    canvas.height = 600;
    drawMap();
  }
  
  window.addEventListener('resize', resizeCanvas);
  resizeCanvas();
  
  // Dijkstra's Algorithm
  function calculateDijkstra(start, end) {
    const distances = {};
    const prev = {};
    const pq = [];
    
    Object.keys(nodes).forEach(node => {
      distances[node] = Infinity;
      prev[node] = null;
    });
    
    distances[start] = 0;
    pq.push({ node: start, dist: 0 });
    
    while (pq.length > 0) {
      pq.sort((a, b) => a.dist - b.dist);
      const { node: currNode, dist: currDist } = pq.shift();
      
      if (currNode === end) break;
      if (currDist > distances[currNode]) continue;
      
      const neighbors = adjList[currNode] || {};
      for (const neighbor in neighbors) {
        const alt = distances[currNode] + neighbors[neighbor];
        if (alt < distances[neighbor]) {
          distances[neighbor] = alt;
          prev[neighbor] = currNode;
          pq.push({ node: neighbor, dist: alt });
        }
      }
    }
    
    // Reconstruct path
    const path = [];
    let curr = end;
    while (curr) {
      path.unshift(curr);
      curr = prev[curr];
    }
    
    return {
      path: distances[end] !== Infinity ? path : [],
      distance: distances[end]
    };
  }

  function triggerNavigation() {
    const start = sourceSelect.value;
    const end = destSelect.value;
    
    if (start === end) {
      alert("Source and Destination are the same!");
      return;
    }
    
    const result = calculateDijkstra(start, end);
    activePath = result.path;
    
    // Update text outputs
    const outputBox = document.getElementById('navigation-output');
    const distText = document.getElementById('nav-dist-text');
    const timeText = document.getElementById('nav-time-text');
    const pathText = document.getElementById('nav-path-text');
    
    if (outputBox && result.path.length > 0) {
      const distance = result.distance;
      const walkTime = Math.round(distance / 80); // Avg speed 80m/min
      
      distText.textContent = `Distance: ${distance} meters`;
      timeText.textContent = `Estimated time: ${walkTime} min${walkTime > 1 ? 's' : ''} (Walk)`;
      
      // Clean up junction nodes names from output path
      const displayPath = result.path.filter(n => !n.startsWith('Junction'));
      pathText.textContent = `Route: ${displayPath.join(' ➔ ')}`;
      
      outputBox.style.display = 'block';
      
      if (typeof gsap !== 'undefined') {
        gsap.fromTo(outputBox, { opacity: 0, y: 10 }, { opacity: 1, y: 0, duration: 0.4 });
      }
    }
    
    drawMap();
  }

  // Bind clicks
  if (mapBtn) {
    mapBtn.addEventListener('click', triggerNavigation);
  }
  
  // Check URL query parameters (e.g. from 3D canvas redirect "?dest=Library")
  const urlParams = new URLSearchParams(window.location.search);
  const urlDest = urlParams.get('dest');
  if (urlDest) {
    // Find matching selector
    for (let option of destSelect.options) {
      if (option.value.toLowerCase().includes(urlDest.toLowerCase()) || urlDest.toLowerCase().includes(option.value.toLowerCase())) {
        destSelect.value = option.value;
        break;
      }
    }
    // Set default source to Gate or Admin
    sourceSelect.value = "Main Gate";
    triggerNavigation();
  }

  // Draw background diagram
  function drawMap() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    // Background Dark Grid
    ctx.strokeStyle = '#1e293b';
    ctx.lineWidth = 0.5;
    for (let i = 0; i < canvas.width; i += 30) {
      ctx.beginPath();
      ctx.moveTo(i, 0);
      ctx.lineTo(i, canvas.height);
      ctx.stroke();
    }
    for (let i = 0; i < canvas.height; i += 30) {
      ctx.beginPath();
      ctx.moveTo(0, i);
      ctx.lineTo(canvas.width, i);
      ctx.stroke();
    }
    
    // Draw all road pathways
    ctx.strokeStyle = 'rgba(255, 255, 255, 0.05)';
    ctx.lineWidth = 12;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    for (const from in adjList) {
      for (const to in adjList[from]) {
        ctx.beginPath();
        ctx.moveTo(nodes[from].x, nodes[from].y);
        ctx.lineTo(nodes[to].x, nodes[to].y);
        ctx.stroke();
      }
    }
    
    // Draw active path (glowing neon line)
    if (activePath.length > 1) {
      ctx.shadowBlur = 15;
      ctx.shadowColor = '#10b981';
      ctx.strokeStyle = '#10b981';
      ctx.lineWidth = 6;
      ctx.beginPath();
      ctx.moveTo(nodes[activePath[0]].x, nodes[activePath[0]].y);
      for (let i = 1; i < activePath.length; i++) {
        ctx.lineTo(nodes[activePath[i]].x, nodes[activePath[i]].y);
      }
      ctx.stroke();
      
      // Reset shadows
      ctx.shadowBlur = 0;
    }
    
    // Draw building blocks
    Object.keys(nodes).forEach(name => {
      const node = nodes[name];
      if (node.isJunction) return; // Don't draw junctions
      
      // Node Block styling
      const isStartEnd = name === sourceSelect.value || name === destSelect.value;
      
      ctx.fillStyle = isStartEnd ? '#10b981' : '#1e1b4b';
      ctx.strokeStyle = isStartEnd ? '#34d399' : '#3b82f6';
      ctx.lineWidth = 2;
      
      // Draw building rectangle
      const w = 90;
      const h = 45;
      ctx.beginPath();
      ctx.roundRect(node.x - w/2, node.y - h/2, w, h, 6);
      ctx.fill();
      ctx.stroke();
      
      // Building Text
      ctx.fillStyle = '#f8fafc';
      ctx.font = 'bold 10px Inter, sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      // Wrap name if long
      const text = node.label || name;
      ctx.fillText(text, node.x, node.y);
    });
  }
}
