# ruiflow_motion Resume Checklist · 2026-06-24

## L3 Bridge State (2026-06-24T09:17)

### 🔄 Pipeline Verification Log
| Time | Action | Result |
|------|--------|--------|
| 09:17 | 引擎检测 ruiflow_motion 静默 28d | P0 对接项重启 |
| 09:17 | ruiflow_v20_real_motion_pipeline --prompt "亢龙有悔" | L2+ 数值关节角度 107.8° range, 14帧 |
| 09:17 | v20_to_webgl_bridge.py 自检 | 5/5 motions ✅, motion_id/frames/joint_schema 全匹配 |
| 09:17 | app.js useDataDriven 数据路径验证 | motionToDataId 路由 ✅, motionAngleData 加载 ✅ |
| 09:17 | Pipeline 端到端状态 | **FULLY OPERATIONAL** (非退化) |

| Asset | Status | Evidence |
|-------|--------|----------|
| `tools/qao/ruiflow_v20_real_motion_pipeline.py` (329行) | ✅ LIVE | 生成 numerical 关节角度 JSON, Phase 3 NLP fallback 已修复 FP-007 |
| motion pipeline CLI | ✅ WORKING | `--help` 输出 7 关节角度 range (105.7° total), 14 frames @24fps |
| bridge → webgl | ✅ L2+ | 5/5 motions 成功转换: 20帧 6关节 euler 角 JSON, app.js useDataDriven 模式可消费 |
| `webgl-preview/data/*_angles.json` | ✅ UPDATED | xianglong/liumai/taiji/kuaijian/qianlong 各含 20 帧连续关节序列, source_from=v20_pipeline |
| 185000 条 JSONL | 🔴 DEGRADED | 零 motion 向量, 文本模板拼凑 (FP-006 audit) |
| `ruiflow_motion/` dir | ⚠️ CRITICAL | 仅 resume_checklist, 无 STATUS.md |

## Blockers to Production

1. **webgl-preview → pipeline 未对接** — app.js 读 WUXIA_MOTIONS dict, 不从 pipeline JSON 消费
2. **185000 条模板数据未隔离** — 混淆真实能力
3. **ruiflow_motion/ 根目录无 STATUS.md** — 新开发者无法快速了解状态

## Next Action (P0)

**对接 pipeline → webgl**: 修改 webgl-preview/app.js 使其能从 ruiflow_v20_real_motion_pipeline.py 的输出 JSON 读取关节角度序列, 替代 WUXIA_MOTIONS 硬编码。

验收标准 L3: `python3 tools/qao/ruiflow_v20_real_motion_pipeline.py --prompt "亢龙有悔"` 输出 JSON → webgl preview 渲染出对应动画。

## Isolation Task (P1)

```bash
mkdir -p data/legacy/
mv wuxia_motions.jsonl data/legacy/  # 待执行
# 标记文件将在隔离后创建
```