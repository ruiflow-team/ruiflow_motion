# RuiFlow Motion Pipeline

> Real-time 3D motion generation from text prompts — bridging NLP to skeletal animation

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.9+-green.svg)
![Hugging Face](https://img.shields.io/badge/%F0%9F%A4%97-Model%20Available-orange)

## Quick Start

```bash
# Install dependencies
pip install torch transformers scipy numpy

# Generate motion from text prompt
python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "亢龙有悔"
```

## Live Demo

🎬 **[Product Demo Video](https://raw.githubusercontent.com/ruiflow-team/ruiflow-team.github.io/main/assets/ruiflow_product_demo_v1.mp4)** — 14s, 960×600, H.264

> Real-time 3D skeletal animation rendered via WebGL preview (武侠3D角色: 降龙十八掌/六脉神剑/太极拳/独孤九剑/乾坤大挪移)

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
- **Main Workspace**: https://github.com/ruiflow-team/openclaw-workspace