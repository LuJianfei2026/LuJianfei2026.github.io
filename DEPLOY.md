# 部署指南：Hugo + GitHub Pages + Cloudflare

## 架构图

```
本地写作 (Markdown)
    ↓ git push
GitHub 仓库 (main 分支)
    ↓ GitHub Actions 自动触发
Hugo 构建 (生成静态文件)
    ↓ 部署
GitHub Pages (免费托管)
    ↓ Cloudflare 代理
全球用户 (CDN 加速 + HTTPS)
```

---

## 第一步：本地初始化

```bash
cd /Users/lujianfei/WorkBuddy/my-site

# 运行一键初始化脚本（传入你的 GitHub 用户名）
bash setup.sh 你的GitHub用户名
```

---

## 第二步：GitHub 仓库创建 & 推送

### 2.1 创建仓库

访问 https://github.com/new，创建仓库：
- **仓库名**：`my-site`（或 `你的用户名.github.io` 可直接用根域）
- **可见性**：Public（GitHub Pages 免费计划需要公开）
- **不要**勾选 Initialize with README

### 2.2 推送代码

```bash
cd /Users/lujianfei/WorkBuddy/my-site

git remote add origin https://github.com/你的用户名/my-site.git
git branch -M main
git push -u origin main
```

### 2.3 开启 GitHub Pages

1. 进入仓库 → **Settings** → **Pages**
2. **Source** 选择 `GitHub Actions`
3. 等待 Actions 跑完（约 1-2 分钟）
4. 访问 `https://你的用户名.github.io/my-site/` 即可看到网站

---

## 第三步：Cloudflare 接入（可选，推荐）

> 需要有自己的域名，如 `lujianfei.com`

### 3.1 添加域名到 Cloudflare

1. 注册/登录 https://cloudflare.com
2. 点击 **Add a Site** → 输入你的域名
3. 选择 **Free** 计划
4. 按提示将域名的 NS 记录改为 Cloudflare 提供的 NS

### 3.2 配置 DNS 解析

在 Cloudflare DNS 面板添加记录：

| 类型 | 名称 | 内容 | 代理状态 |
|------|------|------|---------|
| CNAME | `@` 或 `www` | `你的用户名.github.io` | ✅ 已代理 |

### 3.3 配置自定义域名（GitHub 端）

1. 仓库 → **Settings** → **Pages** → **Custom domain**
2. 填入你的域名，如 `lujianfei.com`
3. 勾选 **Enforce HTTPS**

### 3.4 在 Hugo 配置中更新 baseURL

编辑 `hugo.toml`：
```toml
baseURL = "https://lujianfei.com/"
```

重新推送代码，GitHub Actions 会自动重新部署。

---

## 日常写作流程

```bash
# 1. 新建文章
cd /Users/lujianfei/WorkBuddy/my-site
hugo new posts/文章名.md

# 2. 编辑文章
# 编辑 content/posts/文章名.md
# 将 draft: true 改为 draft: false

# 3. 本地预览
hugo server -D
# 打开 http://localhost:1313

# 4. 发布
git add .
git commit -m "新文章：文章标题"
git push
# GitHub Actions 自动构建部署，约 1-2 分钟后上线
```

---

## Cloudflare 推荐配置

开启以下功能提升性能和安全性：

| 功能 | 位置 | 推荐设置 |
|------|------|---------|
| SSL/TLS | SSL/TLS → Overview | Full (Strict) |
| 缓存规则 | Caching → Configuration | Standard |
| 自动压缩 | Speed → Optimization → Compression | 开启 Brotli |
| HTTP/3 | Network | 开启 |
| 隐私邮件保护 | Scrape Shield | 开启 |

---

## 常见问题

**Q：推送后 GitHub Actions 失败？**  
A：检查 Settings → Pages → Source 是否选择了 `GitHub Actions`

**Q：Cloudflare 开启代理后网站无法访问？**  
A：在 GitHub Pages 设置中关闭 Enforce HTTPS，等 DNS 生效后再开启

**Q：如何更换主题？**  
A：`git submodule add <主题URL> themes/<主题名>`，并修改 `hugo.toml` 中的 `theme`

**Q：图片放哪里？**  
A：放在 `static/images/` 目录，引用路径为 `/images/文件名.jpg`
