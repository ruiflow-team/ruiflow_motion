#!/bin/bash
# ruiflow_motion Phase 3 视频录制脚本
# 目标: 生成 ≤90秒 1080p 产品 demo 视频（含终端操作 + Web UI + 画外音）
# 论文要求: Effective Harnesses FP-004 修复

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$PROJECT_DIR/deliverables"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FINAL_VIDEO="$OUTPUT_DIR/ruiflow_product_demo_final_${TIMESTAMP}.mp4"

mkdir -p "$OUTPUT_DIR"

echo "=== ruiflow_motion Phase 3 视频录制 ==="
echo "输出目录: $OUTPUT_DIR"
echo "时间戳: $TIMESTAMP"

# 检查依赖
check_deps() {
    local missing=()
    for cmd in ffmpeg python3; do
        if ! command -v $cmd &> /dev/null; then
            missing+=($cmd)
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo "错误: 缺少依赖: ${missing[*]}"
        echo "请安装: brew install ffmpeg python3"
        exit 1
    fi
}

# 生成画外音脚本 (TTS-ready)
generate_narration() {
    cat > "$OUTPUT_DIR/narration_script_${TIMESTAMP}.txt" << 'EOF'
【ruiflow_motion 产品演示】

第1段 - 开场 (0-5秒)
"欢迎来到 ruiflow_motion，下一代武侠风格 3D 角色动作生成系统。"

第2段 - 终端操作 (5-25秒)
"首先，我们在终端启动服务。只需一行命令，系统自动加载降龙、六脉、太极、独孤九剑、乾坤大挪移五种经典武侠动作。"

第3段 - Web UI 展示 (25-60秒)
"打开浏览器，进入本地 8080 端口。这里展示五种角色的实时预览。点击播放，可以看到流畅的 3D 动画渲染。每种动作都经过精心调校，呈现正宗武侠风格。"

第4段 - 结尾 (60-90秒)
"ruiflow_motion，让武侠动作生成变得简单。开源、免费、可扩展。立即体验！"
EOF
    echo "画外音脚本已生成: $OUTPUT_DIR/narration_script_${TIMESTAMP}.txt"
}

# 生成录制配置
generate_recording_config() {
    cat > "$OUTPUT_DIR/recording_config_${TIMESTAMP}.json" << EOF
{
  "project": "ruiflow_motion",
  "phase": 3,
  "timestamp": "$TIMESTAMP",
  "target_specs": {
    "resolution": "1920x1080",
    "duration_seconds": 90,
    "fps": 30,
    "codec": "H264",
    "audio": "AAC 128kbps"
  },
  "segments": [
    {
      "type": "title_card",
      "duration": 5,
      "content": "ruiflow_motion - 武侠3D角色动作生成"
    },
    {
      "type": "terminal_recording",
      "duration": 20,
      "commands": [
        "cd ruiflow_motion",
        "python3 -m http.server 8080 &",
        "./scripts/start_webgl_demo.sh"
      ]
    },
    {
      "type": "web_ui_recording",
      "duration": 35,
      "url": "http://localhost:8080",
      "actions": ["展示5种角色", "播放动画", "切换视角"]
    },
    {
      "type": "outro",
      "duration": 30,
      "content": "开源地址: github.com/ruiflow/motion"
    }
  ],
  "narration_file": "narration_script_${TIMESTAMP}.txt",
  "output_file": "ruiflow_product_demo_final_${TIMESTAMP}.mp4"
}
EOF
    echo "录制配置已生成: $OUTPUT_DIR/recording_config_${TIMESTAMP}.json"
}

# 生成 README 嵌入代码片段
generate_readme_snippet() {
    cat > "$OUTPUT_DIR/readme_embed_${TIMESTAMP}.md" << EOF
## 产品演示视频

<video src="https://ruiflow.github.io/motion/ruiflow_product_demo_final_${TIMESTAMP}.mp4" 
       controls width="100%" poster="./assets/demo_poster.jpg">
</video>

**视频规格**: 1920×1080 | 90秒 | H264 | 含画外音

**演示内容**:
- ✅ 终端启动服务
- ✅ Web UI 实时预览
- ✅ 5种武侠角色动作展示

[下载高清版本](https://ruiflow.github.io/motion/ruiflow_product_demo_final_${TIMESTAMP}.mp4)
EOF
    echo "README 嵌入代码已生成: $OUTPUT_DIR/readme_embed_${TIMESTAMP}.md"
}

# 主流程
main() {
    check_deps
    generate_narration
    generate_recording_config
    generate_readme_snippet
    
    echo ""
    echo "=== Phase 3 录制准备完成 ==="
    echo ""
    echo "文件清单:"
    ls -la "$OUTPUT_DIR"/*_${TIMESTAMP}.* 2>/dev/null || echo "  (文件已生成)"
    echo ""
    echo "下一步操作:"
    echo "1. 启动 WebGL 服务: ./scripts/start_webgl_demo.sh"
    echo "2. 使用 OBS/QuickTime 录制屏幕 (1920x1080)"
    echo "3. 按 narration_script_${TIMESTAMP}.txt 录制画外音"
    echo "4. 使用 ffmpeg 合并音画 (命令见下方)"
    echo ""
    echo "ffmpeg 合并命令参考:"
    echo "  ffmpeg -i video_only.mp4 -i audio_only.m4a -c:v copy -c:a aac -b:a 128k $FINAL_VIDEO"
    echo ""
    echo "输出文件: $FINAL_VIDEO"
}

main "$@"
