import json
import struct

def parse_glb(file_path):
    with open(file_path, 'rb') as f:
        magic = f.read(4)
        if magic != b'glTF':
            print("Not a GLB file")
            return
        
        version = struct.unpack('<I', f.read(4))[0]
        length = struct.unpack('<I', f.read(4))[0]
        
        chunk0_length = struct.unpack('<I', f.read(4))[0]
        chunk0_type = f.read(4)
        if chunk0_type != b'JSON':
            print("Chunk 0 is not JSON")
            return
            
        json_data = f.read(chunk0_length).decode('utf-8')
        gltf = json.loads(json_data)
        
        nodes = gltf.get('nodes', [])
        for i, node in enumerate(nodes):
            name = node.get('name', '').lower()
            if 'school_bus' in name:
                # get translation if any
                translation = node.get('translation', [0, 0, 0])
                print(f"Node {i}: {name}, Position: {translation}")

parse_glb('college.glb')
