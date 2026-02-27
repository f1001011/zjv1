为以下文本添加国际化支持，同时更新 `en.json` 和 `zh.json`。

操作步骤：
1. 读取 `my_app/src/locales/zh.json` 和 `my_app/src/locales/en.json`
2. 为新文本生成合适的 key（使用点分隔的命名空间，如 `vip.title`）
3. 将 key-value 添加到两个文件中
4. 在组件中将硬编码文本替换为 `$t('key')`

需要添加的文本（中文）：$ARGUMENTS

请输出：
- 新增的 JSON 条目
- 组件中对应的替换代码
