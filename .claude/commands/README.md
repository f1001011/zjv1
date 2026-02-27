# Claude Code Skills 说明文档

本项目已配置以下自定义 Skills（斜杠命令），在对话框输入 `/` 即可触发。

---

## 可用 Skills 列表

| 命令 | 说明 | 用法示例 |
|------|------|----------|
| `/vue-review` | Vue 组件代码审查 | `/vue-review src/views/Home.vue` |
| `/api-gen` | 生成 API 模块 | `/api-gen 用户订单列表接口` |
| `/i18n-add` | 添加国际化文本 | `/i18n-add 立即充值,余额不足` |
| `/commit` | 生成 git commit message | `/commit` |

---

## 详细说明

### /vue-review

对指定 Vue 组件进行全面代码审查。

**检查项：**
- 逻辑 bug 和边界条件
- 性能问题（重渲染、内存泄漏）
- 安全风险（XSS 等）
- 组合式 API 最佳实践
- 国际化覆盖情况

**用法：**
```
/vue-review src/views/Vip.vue
```

---

### /api-gen

根据需求描述自动生成 API 模块，包含 TypeScript 类型定义。

**生成内容：**
- `my_app/src/api/xxx.ts` — API 函数
- `my_app/src/types/xxx.ts` — 类型定义

**用法：**
```
/api-gen 积分记录查询，支持分页，参数有 page 和 pageSize
```

---

### /i18n-add

为中文文本生成 i18n key，并同步更新 `zh.json` 和 `en.json`。

**用法：**
```
/i18n-add 立即充值,余额不足,请先登录
```

---

### /commit

分析当前暂存区改动，生成符合 Conventional Commits 规范的提交信息。

**用法：**
```
/commit
```

---

## 如何新增 Skills

在 `.claude/commands/` 目录下创建 `.md` 文件：

```
.claude/
└── commands/
    └── my-skill.md   ← 文件名即命令名 /my-skill
```

文件内容即为发送给 Claude 的提示词，使用 `$ARGUMENTS` 接收命令参数。
