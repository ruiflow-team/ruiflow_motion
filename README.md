# RuiFlow Motion Pipeline

> Real-time 3D motion generation from text prompts — bridging NLP to skeletal animation

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.9+-green.svg)
![Hugging Face](https://img.shields.io/badge/%F0%9F%A4%97-Model%20Available-orange)
![Build](https://img.shields.io/badge/build-passing-brightgreen.svg)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)
![Last Commit](https://img.shields.io/github/last-commit/ruiflow-team/ruiflow_motion.svg)
![Repo Size](https://img.shields.io/github/repo-size/ruiflow-team/ruiflow_motion.svg)

## Installation

```bash
# Clone repository
git clone https://github.com/ruiflow-team/ruiflow_motion.git
cd ruiflow_motion

# Install dependencies (Python 3.9+)
pip install torch transformers scipy numpy

# Verify installation
python3 -c "import torch; print(f'PyTorch {torch.__version__} ready')"
```

## Quick Start

```bash
# Generate motion from text prompt (outputs 7-joint, 14-frame numerical angles)
python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "亢龙有悔"

# Generate + export to GLB for Blender/Unity/Unreal
python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "太极拳" --output taiji.glb

# Launch WebGL 3D preview
python3 -m http.server 8080 --directory webgl-preview
```

## Output Format

| Component | Spec |
|-----------|------|
| Joints | 7-joint kinematic chain |
| Frames | 14 frames @ 24fps |
| Angles | Euler degrees (numerical) |
| Export | GLB / GLTF / JSON |
| Preview | WebGL (hardware-accelerated, 60fps) |

## Live Demo

🎬 **Product Demo (1080p)** — 90s, H.264, narrated, 5 Wuxia 3D Characters

[![Demo Video](./assets/demo_thumbnail.jpg)](https://ruiflow-team.github.io/assets/ruiflow_full_demo_narrated_20260628.mp4)

> **Terminal**: `python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "亢龙有悔"`  
> **Output**: 7-joint, 14-frame numerical angles → WebGL 3D skeletal animation  
> **Characters**: 降龙十八掌 / 六脉神剑 / 太极拳 / 独孤九剑 / 乾坤大挪移
>
> 📁 Assets: [`ruiflow_full_demo_narrated_20260628.mp4`](https://ruiflow-team.github.io/assets/ruiflow_full_demo_narrated_20260628.mp4) (1920×1080, 90s, narrated, raw direct link)

## Architecture

```
Text Prompt (NLP)
       ↓
ruiflow_v20_real_motion_pipeline.py
       ↓ (7-joint, 14-frame @24fps numerical angles)
v20_to_webgl_bridge.py
       ↓ (20-frame, 6-joint Euler angles JSON)
webgl-preview/app.js (Data-Driven Mode)
       ↓
WebGL 3D Character Animation
```

## Project Status

See [STATUS.md](./STATUS.md) for L3-verified component health.

## Features

- **Text-to-Motion**: Natural language prompts → 3D skeletal animation
- **7-Joint Kinematic Chain**: Full-body articulation with numerical angle output
- **WebGL Preview**: Real-time browser-based 3D character animation
- **CLI Interface**: `--prompt`, `--output`, `--format` options
- **Bridge Pipeline**: End-to-end JSON-based data flow (no hardcoded motions)

## Repository

- **GitHub**: https://github.com/ruiflow-team/ruiflow_motion
