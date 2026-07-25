const fs = require('fs');

const buf = fs.readFileSync('college.glb');
const magic = buf.toString('utf8', 0, 4);
if (magic !== 'glTF') {
  console.log('Not a glb');
  process.exit(1);
}

const version = buf.readUInt32LE(4);
const length = buf.readUInt32LE(8);
const chunk0Length = buf.readUInt32LE(12);
const chunk0Type = buf.toString('utf8', 16, 20);

if (chunk0Type !== 'JSON') {
  console.log('Chunk 0 not JSON');
  process.exit(1);
}

const jsonData = buf.toString('utf8', 20, 20 + chunk0Length);
const gltf = JSON.parse(jsonData);

let count = 0;
gltf.nodes.forEach((node, i) => {
  const name = (node.name || '').toLowerCase();
  if (name.includes('school_bus')) {
    console.log(`Node ${i}: ${name}`);
    if (node.translation) console.log(`  Translation: ${node.translation}`);
    count++;
  }
});
console.log(`Total: ${count}`);
