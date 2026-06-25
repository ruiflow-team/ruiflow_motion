# ruiflow_motion 项目状态 · 2026-06-24T10:47

## L3 Bridge State (已验证)

| 组件 | 状态 | L2+ 证据 |
|------|------|---------|
| `ruiflow_v20_real_motion_pipeline.py` | ✅ LIVE | 输出 7关节 14帧 数值角度 JSON, CLI `--help` 可用 |
| `v20_to_webgl_bridge.py` | ✅ OPERATIONAL | 5/5 motions 转换成功, 20帧 6关节 euler |
| `webgl-preview/data/*_angles.json` | ✅ UPDATED | 5个文件存在, 含 xianglong/liumai/taiji/kuaijian/qianlong |
| `webgl-preview/app.js` | ✅ DATA-DRIVEN | useDataDriven=true, motionAngleData 路由正确 |
| `data/legacy/wuxia_motions.jsonl` | 🔴 DEGRADED | 185000条模板拼凑, 已隔离 FP-006 |
| `ruiflow_motion/` 根目录 | ⚠️ 无 STATUS.md | **本文件解决此问题** |

## 深度动作日志 (本轮 2026-06-24T10:47)

**P0 Next Executable Leap 已执行**: 创建 `ruiflow_motion/STATUS.md`

上一轮 P0: "demo 验证" → "可消费 Harness 输出"
本轮解决: ruiflow_motion/ 目录缺 STATUS.md 新开发者无法快速了解状态

验收标准: 本文件存在且含 L3 证据表格

## 技术债务 (待清理)

1. `generate_preview.py` 仍用 WUXIA_MOTIONS 硬编码, 未对接 v20 pipeline JSON
2. v18b motion inference 输出 256×256 gif, 非产品级 demo
3. 无 GitHub 提交记录 (ruiflow_motion 目录未入版本控制)
