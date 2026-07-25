// Three.js 3D Campus Viewer & Interaction Engine

let scene, camera, renderer, controls;
let mixer;
const clock = new THREE.Clock();
let buildings = [];
let raycaster, mouse;
let hoveredObject = null;

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('three-canvas')) {
    initThreeScene();
  }
});

function initThreeScene() {
  const canvas = document.getElementById('three-canvas');
  const container = canvas.parentElement;

  // Guard against a zero-size container at init time. If the canvas's
  // parent hasn't been laid out yet (e.g. hidden tab, flex container not
  // yet measured), clientWidth/clientHeight can be 0, which produces a
  // NaN camera aspect ratio and an entirely black canvas that never
  // recovers. Fall back to the window size in that case.
  const initW = container.clientWidth || window.innerWidth;
  const initH = container.clientHeight || window.innerHeight;

  // Scene Setup
  scene = new THREE.Scene();
  scene.background = new THREE.Color(0x14141f); // lightened from 0x05050a
  scene.fog = new THREE.FogExp2(0x14141f, 0.004); // lightened + reduced density

  // Camera Setup
  camera = new THREE.PerspectiveCamera(60, initW / initH, 0.1, 1000);
  camera.position.set(25, 20, 25);

  // Renderer Setup
  renderer = new THREE.WebGLRenderer({ canvas: canvas, antialias: true });
  renderer.setSize(initW, initH);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.toneMapping = THREE.ACESFilmicToneMapping;
  renderer.toneMappingExposure = 1.6; // increased from 1.0 for overall brightness

  // Controls Setup (via OrbitControls CDN)
  if (typeof THREE.OrbitControls !== 'undefined') {
    controls = new THREE.OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.05;
    controls.maxPolarAngle = Math.PI / 2.1; // Limit under ground level
    controls.minDistance = 10;
    controls.maxDistance = 250;
    controls.target.set(0, 2, 0);
  }

  // Clean, balanced lighting rig (replaces the old scattered multi-light setup)
  addSceneLights();

  // Make the model slightly more contrasty/bright for visibility
  // (especially helpful if your GLB materials are dark.)
  scene.fogIntensity = 0.04;

  // Ground Grid Floor
  const gridHelper = new THREE.GridHelper(100, 50, 0x3b82f6, 0x1f2937);
  gridHelper.position.y = -0.01;
  scene.add(gridHelper);

  // Simple ground plane so the model has something to sit on / cast shadows onto
  const groundGeom = new THREE.PlaneGeometry(200, 200);
  const groundMat = new THREE.ShadowMaterial({ opacity: 0.35 });
  const ground = new THREE.Mesh(groundGeom, groundMat);
  ground.rotation.x = -Math.PI / 2;
  ground.position.y = -0.02;
  ground.receiveShadow = true;
  scene.add(ground);

  // GLTF Loader
  const loader = new THREE.GLTFLoader();

  loader.load(
    './college.glb',
    (gltf) => {
      const model = gltf.scene;
      scene.add(model);

      // Initialize and play any animations (such as bus animation) inside the GLTF model
      if (gltf.animations && gltf.animations.length > 0) {
        console.log(`Found ${gltf.animations.length} animations in college.glb. Starting playback...`);
        mixer = new THREE.AnimationMixer(model);
        gltf.animations.forEach((clip) => {
          mixer.clipAction(clip).play();
        });
      }

      // --- Auto-center & auto-place the model at a sensible default position ---
      // 1) Compute bounding box of the raw model
      let box = new THREE.Box3().setFromObject(model);
      const size = new THREE.Vector3();
      const center = new THREE.Vector3();
      box.getSize(size);
      box.getCenter(center);

      const boxIsValid =
        !box.isEmpty() &&
        Number.isFinite(size.x) && Number.isFinite(size.y) && Number.isFinite(size.z) &&
        Number.isFinite(center.x) && Number.isFinite(center.y) && Number.isFinite(center.z);

      if (!boxIsValid) {
        // Bad/empty bounding box (e.g. GLB has no real mesh geometry, or its
        // matrices weren't ready yet). Skip transforms rather than risk
        // writing NaN into the model/camera, which would blank the whole scene.
        console.warn('college.glb produced an invalid bounding box — skipping auto-center/scale, using default transform.');
        model.position.set(0, 0, 0);
        model.scale.setScalar(1);
      } else {
        // 2) Scale the model to a consistent target footprint (in scene units)
        const targetSize = 40; // desired largest dimension on screen
        const maxDim = Math.max(size.x, size.y, size.z) || 1;
        const scaleFactor = Number.isFinite(maxDim) && maxDim > 0 ? targetSize / maxDim : 1;
        model.scale.setScalar(scaleFactor);

        // 3) Recompute the box after scaling, then re-center the model at the
        //    origin on the X/Z plane and drop it so its base sits on y = 0
        box = new THREE.Box3().setFromObject(model);
        box.getSize(size);
        box.getCenter(center);

        if (!box.isEmpty() && Number.isFinite(center.x) && Number.isFinite(box.min.y)) {
          model.position.x -= center.x;
          model.position.z -= center.z;
          model.position.y -= box.min.y; // sit flush on the ground grid
        }
      }

      // 4) Point the orbit controls / camera at the model's new center
      //    (only if we end up with a finite, sane box — never write NaN
      //    into controls.target, since that would break camera updates
      //    for the entire scene, not just the model)
      const finalBox = new THREE.Box3().setFromObject(model);
      const finalCenter = new THREE.Vector3();
      finalBox.getCenter(finalCenter);
      const finalCenterIsValid =
        !finalBox.isEmpty() &&
        Number.isFinite(finalCenter.x) && Number.isFinite(finalCenter.y) && Number.isFinite(finalCenter.z);

      if (finalCenterIsValid) {
        if (controls) {
          controls.target.copy(finalCenter);
          controls.target.y = Math.max(finalCenter.y, 2);
          controls.update();
        }
        camera.lookAt(finalCenter);
      } else if (controls) {
        controls.target.set(0, 2, 0);
        controls.update();
      }

      model.traverse((child) => {
        if (child.isMesh) {
          child.castShadow = true;
          child.receiveShadow = true;

          // Skip registering school bus parts as interactive buildings
          if (child.name && child.name.toLowerCase().includes('school_bus')) {
            return;
          }

          // Remember this mesh's own scale BEFORE we ever touch it for hover,
          // so hover can scale relative to it instead of assuming (1,1,1).
          child.userData.baseScale = child.scale.clone();
          buildings.push(child);
          bindBuildingData(child);
        }
      });

      // Dismiss preloader once model is loaded and active in the scene
      const preloader = document.querySelector('.preloader');
      if (preloader) {
        const textEl = preloader.querySelector('.loader-text');
        if (textEl) textEl.textContent = 'CAMPUS READY!';
        const fillEl = document.getElementById('progress-bar-fill');
        if (fillEl) fillEl.style.width = '100%';
        
        setTimeout(() => {
          preloader.style.opacity = '0';
          setTimeout(() => {
            preloader.style.display = 'none';
          }, 500);
        }, 800);
      }
    },
    (xhr) => {
      const textEl = document.querySelector('.preloader .loader-text');
      const fillEl = document.getElementById('progress-bar-fill');
      let percent = 0;
      if (xhr.total) {
        percent = Math.round((xhr.loaded / xhr.total) * 100);
      } else {
        // Fallback for missing Content-Length: estimate size of college.glb (86264960 bytes)
        percent = Math.min(Math.round((xhr.loaded / 86264960) * 100), 99);
      }
      if (textEl) textEl.textContent = `LOADING 3D CAMPUS... ${percent}%`;
      if (fillEl) fillEl.style.width = `${percent}%`;
    },
    (error) => {
      console.error(error);
      console.warn('Campus GLB model missing or failed to load. Generating procedural holographic campus...');
      buildProceduralCampus();
      
      // Dismiss preloader on procedural fallback
      const preloader = document.querySelector('.preloader');
      if (preloader) {
        preloader.style.opacity = '0';
        setTimeout(() => {
          preloader.style.display = 'none';
        }, 500);
      }
    }
  );

  // Raycaster & Mouse handlers
  raycaster = new THREE.Raycaster();
  mouse = new THREE.Vector2();

  window.addEventListener('resize', onWindowResize);
  canvas.addEventListener('mousemove', onMouseMove);
  canvas.addEventListener('mouseleave', onMouseLeave);
  canvas.addEventListener('click', onMouseClick);

  // In case the container was measured as 0x0 above, re-sync sizing once
  // the browser has actually finished layout (fixes a black canvas that
  // never recovers on its own).
  requestAnimationFrame(onWindowResize);

  animate();
}

// A clean three-point-style lighting rig: ambient fill + sun (key, shadow-casting)
// + soft hemisphere sky light + a gentle rim light for edge definition.
function addSceneLights() {
  // Soft base fill so nothing goes pure black
  const ambient = new THREE.AmbientLight(0xffffff, 0.9); // increased from 0.5
  scene.add(ambient);

  // Sky/ground hemisphere light for natural outdoor feel
  const hemi = new THREE.HemisphereLight(0xbfd9ff, 0x2b2b33, 1.0); // increased from 0.6
  scene.add(hemi);

  // Key light (the "sun") — casts the shadows
  const sun = new THREE.DirectionalLight(0xffffff, 2.2); // increased from 1.6
  sun.position.set(35, 50, 25);
  sun.castShadow = true;
  sun.shadow.mapSize.set(2048, 2048);
  sun.shadow.camera.near = 1;
  sun.shadow.camera.far = 200;
  sun.shadow.camera.left = -60;
  sun.shadow.camera.right = 60;
  sun.shadow.camera.top = 60;
  sun.shadow.camera.bottom = -60;
  sun.shadow.bias = -0.0005;
  scene.add(sun);

  // Gentle rim/fill light from the opposite side to soften shadows
  const fill = new THREE.DirectionalLight(0x9fc3ff, 0.6); // increased from 0.4
  fill.position.set(-30, 20, -20);
  scene.add(fill);
}

// Generate dynamic 3D Blocks with futuristic neon outlines
function buildProceduralCampus() {
  const buildingSpecs = [
    { name: 'Admin Block', pos: [0, 2, 0], size: [6, 4, 6], color: 0xeab308, data: { floor: 3, details: 'Principal, Registrar, Finance Dept', open: '9 AM - 5 PM' } },
    { name: 'Library', pos: [-15, 3, -12], size: [8, 6, 6], color: 0x3b82f6, data: { floor: 4, details: '12,540 Books, 140 Seats', open: '8 AM - 8 PM' } },
    { name: 'CSE Block', pos: [15, 4, 12], size: [6, 8, 8], color: 0x10b981, data: { floor: 4, details: 'DBMS Lab, AI Lab, HOD CSE Cabin', open: '8.30 AM - 5 PM' } },
    { name: 'ECE Block', pos: [-15, 4, 12], size: [6, 8, 8], color: 0x06b6d4, data: { floor: 4, details: 'Microprocessor Lab, HOD ECE Cabin', open: '8.30 AM - 5 PM' } },
    { name: 'Auditorium', pos: [18, 2.5, -12], size: [7, 5, 7], shape: 'cylinder', color: 0x8b5cf6, data: { floor: 1, details: 'Capacity: 1200 Seats', open: 'Events Only' } },
    { name: 'Hostel Block', pos: [0, 5, -25], size: [12, 10, 8], color: 0xf97316, data: { floor: 6, details: 'Kaveri Boys & Girls Dormitories', open: 'Curfew: 7:30 PM' } },
    { name: 'Canteen', pos: [-25, 1.5, 0], size: [6, 3, 5], color: 0xef4444, data: { floor: 1, details: 'South Indian Food, Juices', open: '8 AM - 6 PM' } },
    { name: 'Playground', pos: [25, 0.1, 0], size: [12, 0.2, 18], color: 0x22c55e, data: { floor: 0, details: 'Football, Cricket Nets', open: '6 AM - 6 PM' } },
    { name: 'Placement Cell', pos: [0, 2.5, 18], size: [5, 5, 5], color: 0xec4899, data: { floor: 2, details: 'Wipro, Zoho, TCS recruitment cell', open: '9 AM - 5 PM' } }
  ];

  buildingSpecs.forEach(spec => {
    let geom;
    if (spec.shape === 'cylinder') {
      geom = new THREE.CylinderGeometry(spec.size[0] / 2, spec.size[0] / 2, spec.size[1], 16);
    } else {
      geom = new THREE.BoxGeometry(spec.size[0], spec.size[1], spec.size[2]);
    }

    // Transparent glassmorphic look
    const mat = new THREE.MeshPhongMaterial({
      color: spec.color,
      transparent: true,
      opacity: 0.6,
      shininess: 100,
      specular: 0xffffff
    });

    const mesh = new THREE.Mesh(geom, mat);
    mesh.position.set(spec.pos[0], spec.pos[1], spec.pos[2]);
    mesh.castShadow = true;
    mesh.receiveShadow = true;

    // Add wireframe neon glow outline
    const wireframeGeom = new THREE.EdgesGeometry(geom);
    const wireframeMat = new THREE.LineBasicMaterial({ color: spec.color, linewidth: 2 });
    const wireframe = new THREE.LineSegments(wireframeGeom, wireframeMat);
    mesh.add(wireframe);

    mesh.userData = {
      name: spec.name,
      color: spec.color,
      floor: spec.data.floor,
      details: spec.data.details,
      open: spec.data.open,
      baseScale: mesh.scale.clone()
    };

    scene.add(mesh);
    buildings.push(mesh);
  });
}

function getBuildingRealDetails(meshName) {
  if (!meshName) return { name: 'Academic Block', floor: 3, details: 'College Classroom Block', open: '8:30 AM - 5:00 PM' };
  
  const name = meshName.toLowerCase().trim();
  
  // Specific real college block mappings
  if (name.includes('bina001') || name === 'bina001' || name === 'bina1') {
    return {
      name: 'RV Block (AI & ML Department)',
      floor: 3,
      details: 'Department of Artificial Intelligence & Machine Learning. Features high-performance computing labs, advanced AI research centers, and smart lecture rooms.',
      open: '8:30 AM - 5:00 PM'
    };
  }
  if (name.includes('bina002') || name === 'bina002' || name === 'bina2') {
    return {
      name: 'JV Block (Admin & Principal Office)',
      floor: 4,
      details: 'Administrative Headquarters. Houses the Principal\'s Office, Registrar, Admissions Wing, Accounts Section, and the main college boardroom.',
      open: '8:30 AM - 5:30 PM'
    };
  }
  if (name.includes('bina003') || name === 'bina003' || name === 'bina3' || name.includes('canteen') || name.includes('cafeteria')) {
    return {
      name: 'Campus Cafeteria (Canteen)',
      floor: 1,
      details: 'College Food Court and Student Canteen. Serves fresh snacks, multi-cuisine meals, fresh juices, and features outdoor and indoor glassmorphic seating areas.',
      open: '7:30 AM - 6:30 PM'
    };
  }
  if (name.includes('bina004') || name === 'bina004' || name === 'bina4' || name.includes('library')) {
    return {
      name: 'Central Library & Information Center',
      floor: 3,
      details: 'Central Library Block. Holds over 80,000 volumes of scientific journals, digital resource centers, silent study spaces, and textbook borrowing lanes.',
      open: '8:00 AM - 8:00 PM'
    };
  }
  if (name.includes('bina005') || name === 'bina005' || name === 'bina5' || name.includes('cse')) {
    return {
      name: 'CSE & IT Block (Newton Block)',
      floor: 4,
      details: 'Department of Computer Science and Engineering. Houses the DBMS Lab, operating systems research labs, networking centers, and project presentation halls.',
      open: '8:30 AM - 5:00 PM'
    };
  }
  if (name.includes('bina006') || name === 'bina006' || name === 'bina6' || name.includes('ece')) {
    return {
      name: 'ECE & EEE Block (Tesla Block)',
      floor: 3,
      details: 'Department of Electronics & Communication Engineering and Electrical Engineering. Contains DSP labs, VLSI circuits labs, and micro-controller project rooms.',
      open: '8:30 AM - 5:00 PM'
    };
  }
  if (name.includes('bina007') || name === 'bina007' || name === 'bina7' || name.includes('auditorium')) {
    return {
      name: 'Sir CV Raman Auditorium',
      floor: 2,
      details: 'State-of-the-art air-conditioned auditorium. Host for national symposiums, cultural activities, guest lectures, and placement orientation drives. Capacity: 1500 seats.',
      open: '8:30 AM - 6:00 PM'
    };
  }
  if (name.includes('bina008') || name === 'bina008' || name === 'bina8' || name.includes('hostel')) {
    return {
      name: 'Men\'s & Women\'s Hostel Block',
      floor: 5,
      details: 'Residential Block. Clean and secure student hostel rooms. Includes common recreation areas, reading rooms, gym facilities, and 24/7 warden support.',
      open: '24 Hours (Residents)'
    };
  }

  // Dynamic distribution fallback
  let labelName = 'Academic Block';
  let detailsText = 'College Classroom Block';
  let floorCount = 3;

  if (name.startsWith('bina')) {
    const numStr = name.replace('bina', '').trim();
    const cleanNum = parseInt(numStr) || 1;
    if (cleanNum % 4 === 1) {
      labelName = `Newton Block (Lab Wing ${cleanNum})`;
      detailsText = 'Classroom Block and programming lab facilities.';
      floorCount = 3;
    } else if (cleanNum % 4 === 2) {
      labelName = `Ramanujan Block (Science Faculty)`;
      detailsText = 'Mathematics, Physics, and Chemistry classroom facilities.';
      floorCount = 4;
    } else if (cleanNum % 4 === 3) {
      labelName = `Visvesvaraya Engineering Wing`;
      detailsText = 'Mechanical, Civil, and structural labs block.';
      floorCount = 2;
    } else {
      labelName = `Bose Block (Research Wing)`;
      detailsText = 'Advanced research labs and seminar classrooms.';
      floorCount = 3;
    }
  } else {
    labelName = meshName.toUpperCase().replace(/[-_]/g, ' ');
  }

  return {
    name: labelName,
    floor: floorCount,
    details: detailsText,
    open: '8:30 AM - 5:00 PM'
  };
}

function bindBuildingData(mesh) {
  const baseScale = mesh.userData.baseScale;
  const details = getBuildingRealDetails(mesh.name);
  mesh.userData = {
    name: details.name,
    floor: details.floor,
    details: details.details,
    open: details.open,
    color: 0x3b82f6,
    baseScale: baseScale
  };
}

function onWindowResize() {
  const canvas = document.getElementById('three-canvas');
  const container = canvas.parentElement;
  const w = container.clientWidth || window.innerWidth;
  const h = container.clientHeight || window.innerHeight;
  camera.aspect = w / h;
  camera.updateProjectionMatrix();
  renderer.setSize(w, h);
}

// Scale a mesh relative to its own original (base) scale, not an absolute value.
// This keeps hover consistent whether the mesh started at scale 1 (procedural
// boxes) or some other scale inherited from the imported GLB.
function setHoverScale(mesh, multiplier) {
  const base = (mesh.userData && mesh.userData.baseScale) || { x: 1, y: 1, z: 1 };
  mesh.scale.set(base.x * multiplier, base.y * multiplier, base.z * multiplier);
}

function clearHover(canvas) {
  if (hoveredObject) {
    if (hoveredObject.material) hoveredObject.material.opacity = 0.6;
    setHoverScale(hoveredObject, 1);
    hoveredObject = null;
  }
  if (canvas) canvas.style.cursor = 'default';
}

function onMouseMove(e) {
  const canvas = document.getElementById('three-canvas');
  const rect = canvas.getBoundingClientRect();
  mouse.x = ((e.clientX - rect.left) / canvas.clientWidth) * 2 - 1;
  mouse.y = -((e.clientY - rect.top) / canvas.clientHeight) * 2 + 1;

  raycaster.setFromCamera(mouse, camera);
  const intersects = raycaster.intersectObjects(buildings);

  if (intersects.length > 0) {
    const object = intersects[0].object;

    if (hoveredObject !== object) {
      // Reset whatever was previously hovered before switching to the new one
      clearHover(canvas);

      hoveredObject = object;
      // Highlight: make opaque and pop slightly (relative to its own base scale)
      if (hoveredObject.material) hoveredObject.material.opacity = 0.95;
      setHoverScale(hoveredObject, 1.05);
      canvas.style.cursor = 'pointer';
    }
  } else {
    clearHover(canvas);
  }
}

// Reset hover state whenever the cursor leaves the canvas entirely — otherwise
// an object can get stuck "enlarged" if the mouse exits before a final
// mousemove event fires with nothing under the cursor.
function onMouseLeave() {
  const canvas = document.getElementById('three-canvas');
  clearHover(canvas);
}

function onMouseClick(e) {
  raycaster.setFromCamera(mouse, camera);
  const intersects = raycaster.intersectObjects(buildings);

  if (intersects.length > 0) {
    const data = intersects[0].object.userData;
    showBuildingPopup(data);
  }
}

function showBuildingPopup(data) {
  const popup = document.getElementById('building-info-card');
  const title = document.getElementById('info-title');
  const details = document.getElementById('info-details');
  const navBtn = document.getElementById('info-navigate-btn');

  if (!popup || !title) return;

  title.textContent = data.name;
  details.innerHTML = `
    <p><strong>Floors:</strong> ${data.floor}</p>
    <p><strong>Status/Info:</strong> ${data.details}</p>
    <p><strong>Timings:</strong> ${data.open}</p>
  `;

  if (navBtn) {
    navBtn.onclick = () => {
      // Pass destination to Campus Map
      window.location.href = `map.html?dest=${encodeURIComponent(data.name)}`;
    };
  }

  popup.style.display = 'block';
  // Fade in animation using standard CSS or GSAP
  if (typeof gsap !== 'undefined') {
    gsap.fromTo(popup, { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.4 });
  } else {
    popup.style.opacity = '1';
  }
}

function animate() {
  requestAnimationFrame(animate);

  const delta = clock.getDelta();
  if (mixer) {
    mixer.update(delta);
  }

  if (controls) {
    controls.update();
  }

  renderer.render(scene, camera);
}
