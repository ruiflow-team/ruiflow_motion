# FP-004 Phase 2: WebGL UI 录屏执行计划

**生成时间**: 2026-06-27T07:17 (Asia/Shanghai)
**证据等级**: L3 (可执行脚本 + 验证清单)

## 前置条件 (已验证)
- ✅ webgl-preview HTTP server: localhost:8080 (HTTP 200)
- ✅ 5个动作数据文件: data/*_angles.json (20帧, 6关节 euler)
- ✅ Phase 1 完成: ruiflow_product_demo_1080p.mp4 (1920x1080, 14s)

## Phase 2 执行步骤

### 2.1 终端操作录屏 (15秒)
```bash
# 打开终端，执行以下命令并录屏
python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "亢龙有悔" --output /tmp/xianglong_motion.json

# 验证输出
cat /tmp/xianglong_motion.json | head -20
```

### 2.2 WebGL UI 操作录屏 (45秒)
1. 打开浏览器访问 http://localhost:8080
2. 点击动作选择器，依次切换:
   - 降龙十八掌 (xianglong)
   - 六脉神剑 (liumai)
   - 太极拳 (taiji)
   - 独孤九剑 (kuaijian)
   - 乾坤大挪移 (qianlong)
3. 调节速度滑块 (0.5x → 1.5x)
4. 鼠标拖拽旋转视角

### 2.3 录屏工具 (macOS)
```bash
# 方案A: 使用 QuickTime Player (GUI)
# 方案B: 使用 ffmpeg + avfoundation
ffmpeg -f avfoundation -i "0:0" -r 30 -s 1920x1080 -c:v libx264 -preset fast -crf 23 /tmp/screen_recording.mp4
```

### 2.4 视频合成 (Phase 1+2)
```bash
# 合并终端操作 + WebGL UI 录屏
ffmpeg -f concat -safe 0 -i <(echo "file '/tmp/terminal_recording.mp4'" && echo "file '/tmp/screen_recording.mp4'") -c copy ruiflow_product_demo_v3.mp4
```

## 验收标准 (L3)
- [ ] 视频分辨率: 1920x1080
- [ ] 视频时长: ≤90秒
- [ ] 内容包含: 终端操作 (CLI) + Web UI 操作
- [ ] 画外音: Phase 3 添加

## 阻塞项 → 授权请求
Phase 2 需要 GUI 录屏工具 (QuickTime/ffmpeg)，当前 cron 环境无显示器访问权限。

**红线内可执行**: 创建录屏脚本 + 验证清单 (本文件)
**红线外需授权**: 实际录屏操作 (需 GUI 环境)

## 下一步动作
1. 等待董事长授权 GUI 录屏环境 或
2. 使用现有 L3 证据推进 Phase 3 (画外音脚本)
