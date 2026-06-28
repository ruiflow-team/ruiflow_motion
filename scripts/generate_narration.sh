#!/bin/bash
# FP-004 Phase 3: Narration Generation & README Embedding
# 生成时间: 2026-06-27T23:47 (Asia/Shanghai)
# 证据等级: L3 (可执行脚本 + 验证清单)

set -e

PROJECT_DIR="/Users/liuxiansheng/.openclaw/workspace/ruiflow_motion"
OUTPUT_DIR="$PROJECT_DIR/deliverables"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$OUTPUT_DIR"

echo "=== RuiFlow Motion Narration Generation ==="
echo "Timestamp: $TIMESTAMP"
echo "Output: $OUTPUT_DIR"

# Step 1: Generate narration script
echo "[1/3] Generating narration script..."
cat > "$OUTPUT_DIR/narration_script_${TIMESTAMP}.txt" << 'NARRATION'
RuiFlow Motion — Real-time 3D Motion Generation from Text

This demo shows RuiFlow Motion pipeline converting Chinese martial arts text prompts into 3D skeletal animations.

First, we input "亢龙有悔" — a legendary palm strike from Dragon Subduing Palm.
The pipeline processes this through our v2.0 real motion model, outputting 7-joint, 14-frame numerical angles.

These angles drive the WebGL 3D character you see here — no pre-baked animations, pure data-driven motion synthesis.

RuiFlow Motion: Text becomes movement.
NARRATION

echo "✅ Narration script: $OUTPUT_DIR/narration_script_${TIMESTAMP}.txt"

# Step 2: Generate TTS audio (macOS say command)
echo "[2/3] Generating TTS audio..."
if command -v say &> /dev/null; then
    say -v "Ting-Ting" -o "$OUTPUT_DIR/narration_${TIMESTAMP}.aiff" -f "$OUTPUT_DIR/narration_script_${TIMESTAMP}.txt"
    echo "✅ TTS audio generated: narration_${TIMESTAMP}.aiff"
else
    echo "⚠️  TTS not available (say command missing), creating placeholder"
    echo "TTS_PLACEHOLDER" > "$OUTPUT_DIR/narration_${TIMESTAMP}.txt"
fi

# Step 3: Generate README embed code
echo "[3/3] Generating README embed snippet..."
cat > "$OUTPUT_DIR/readme_embed_${TIMESTAMP}.md" << 'READMEEMBED'
## Demo Video with Narration

🎬 **Full Product Demo (1080p + Narration)** — Complete walkthrough with voiceover

[![Demo Video with Narration](./assets/demo_thumbnail_narrated.jpg)](./deliverables/narration_VIDEO_TIMESTAMP.mp4)

> **00:00** — Introduction to RuiFlow Motion  
> **00:03** — CLI pipeline execution  
> **00:08** — WebGL 3D character animation  
> **00:12** — Technical architecture overview

**Audio Narration**: Generated TTS with synchronized timestamps  
**Video Format**: 1920×1080, H.264, AAC audio  
**Duration**: ~14 seconds
READMEEMBED

echo "✅ README embed snippet: $OUTPUT_DIR/readme_embed_${TIMESTAMP}.md"

# Step 4: Generate metadata
cat > "$OUTPUT_DIR/narration_meta_${TIMESTAMP}.json" << EOF
{
  "timestamp": "$TIMESTAMP",
  "phase": "FP-004_Phase3",
  "evidence_level": "L3",
  "components": {
    "narration_script": "narration_script_${TIMESTAMP}.txt",
    "tts_audio": "narration_${TIMESTAMP}.aiff",
    "readme_embed": "readme_embed_${TIMESTAMP}.md"
  },
  "validation": {
    "script_generated": true,
    "tts_available": $(command -v say &> /dev/null && echo "true" || echo "false"),
    "readme_embed_created": true
  },
  "next_step": "Combine video + audio into final narrated demo"
}
EOF

echo ""
echo "=== Narration Generation Complete ==="
echo "Metadata: $OUTPUT_DIR/narration_meta_${TIMESTAMP}.json"
echo "Script: $OUTPUT_DIR/narration_script_${TIMESTAMP}.txt"
echo "Audio: $OUTPUT_DIR/narration_${TIMESTAMP}.aiff (or .txt placeholder)"
echo "README Embed: $OUTPUT_DIR/readme_embed_${TIMESTAMP}.md"
echo ""
echo "Next: Combine with existing 1080p video for final narrated demo"
EOF
