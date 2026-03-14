# 快速上线步骤

GitHub 用户名：**Lujianfei2026**
网站地址：**https://Lujianfei2026.github.io/**

---

## 第一步：打开终端，安装 Hugo 并拉取主题

```bash
# 安装 Hugo
brew install hugo

# 进入项目目录
cd /Users/lujianfei/WorkBuddy/my-site

# 初始化 git 并拉取 PaperMod 主题
git init
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# 本地预览测试（可选）
hugo server -D
# 打开浏览器访问 http://localhost:1313
# 按 Ctrl+C 退出
```

---

## 第二步：在 GitHub 创建仓库

1. 打开 https://github.com/new
2. Repository name 填写：**`my-site`**
3. 选 **Public**
4. **不要**勾选任何初始化选项
5. 点击 **Create repository**

---

## 第三步：推送代码

```bash
cd /Users/lujianfei/WorkBuddy/my-site

git add .
git commit -m "🎉 初始化个人网站"
git remote add origin https://github.com/Lujianfei2026/my-site.git
git branch -M main
git push -u origin main
```

---

## 第四步：开启 GitHub Pages

1. 打开 https://github.com/Lujianfei2026/my-site/settings/pages
2. **Source** 下拉选择 **`GitHub Actions`**
3. 等待约 1~2 分钟

---

## 完成！访问网站

```
https://Lujianfei2026.github.io/my-site/
```

---

## 以后写文章

```bash
cd /Users/lujianfei/WorkBuddy/my-site

# 新建文章
hugo new posts/文章标题.md

# 编辑文章，把 draft: true 改为 false

# 发布
git add .
git commit -m "新文章：文章标题"
git push
```
