根据当前 git 暂存区的改动，生成一条规范的 commit message。

规范要求：
- 格式：`<type>(<scope>): <subject>`
- type：feat / fix / refactor / style / docs / chore
- scope：改动涉及的模块（如 auth、vip、home）
- subject：简洁描述，中文，不超过 50 字

请先运行 `git diff --cached` 查看改动，然后生成 commit message。

如果有多个独立改动，建议拆分为多条 commit 并说明原因。
