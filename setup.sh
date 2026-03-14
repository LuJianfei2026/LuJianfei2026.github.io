#!/bin/bash
# ============================================================
# Claw 个人网站 — 一键初始化脚本
# 使用方法：bash setup.sh <你的GitHub用户名>
# ============================================================

set -e

GITHUB_USER=${1:-"your-username"}
SITE_DIR="/Users/lujianfei/WorkBuddy/my-site"

echo ""
echo "🚀 开始初始化个人网站..."
echo "   GitHub 用户名: $GITHUB_USER"
echo "   网站目录: $SITE_DIR"
echo ""

# ── Step 1: 安装 Hugo ──────────────────────────────────────
echo "📦 [1/5] 安装 Hugo..."
if ! command -v hugo &> /dev/null; then
    brew install hugo
    echo "✅ Hugo 安装完成: $(hugo version)"
else
    echo "✅ Hugo 已安装: $(hugo version)"
fi

# ── Step 2: 安装 PaperMod 主题 ────────────────────────────
echo ""
echo "🎨 [2/5] 安装 PaperMod 主题..."
cd "$SITE_DIR"

if [ ! -d "themes/PaperMod" ]; then
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    echo "✅ PaperMod 主题安装完成"
else
    echo "✅ PaperMod 主题已存在"
fi

# ── Step 3: 更新配置中的 GitHub 用户名 ───────────────────
echo ""
echo "⚙️  [3/5] 更新配置..."
sed -i '' "s|https://github.com/lujianfei|https://github.com/$GITHUB_USER|g" hugo.toml
sed -i '' "s|lujianfei/my-site|$GITHUB_USER/my-site|g" hugo.toml
sed -i '' "s|https://lujianfei.com/|https://$GITHUB_USER.github.io/|g" hugo.toml
echo "✅ 配置更新完成"

# ── Step 4: 本地预览测试 ──────────────────────────────────
echo ""
echo "🔍 [4/5] 构建测试..."
hugo --gc --minify 2>&1 | tail -3
echo "✅ 构建成功"

# ── Step 5: 初始化 Git 并推送 ────────────────────────────
echo ""
echo "📤 [5/5] 初始化 Git 仓库..."
git init 2>/dev/null || true
git add .
git commit -m "🎉 初始化个人网站" 2>/dev/null || echo "ℹ️  已是最新提交"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅  本地初始化完成！"
echo ""
echo "📋 接下来需要您手动完成："
echo ""
echo "  1. 在 GitHub 创建仓库（名为 my-site 或 $GITHUB_USER.github.io）"
echo "     👉 https://github.com/new"
echo ""
echo "  2. 推送代码："
echo "     git remote add origin https://github.com/$GITHUB_USER/my-site.git"
echo "     git branch -M main"
echo "     git push -u origin main"
echo ""
echo "  3. 在 GitHub 仓库设置 → Pages → Source 选择 GitHub Actions"
echo "     👉 https://github.com/$GITHUB_USER/my-site/settings/pages"
echo ""
echo "  4. 本地预览："
echo "     cd $SITE_DIR && hugo server -D"
echo "     打开 http://localhost:1313"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📖 完整接入 Cloudflare 说明见 DEPLOY.md"
echo ""
