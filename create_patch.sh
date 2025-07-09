#!/bin/bash
echo "📦 Creating patch from your changes..."

if [ ! -d ".git" ]; then
  git init
  git add .
  git commit -m "Base snapshot"
fi

git add .
git commit -m "My changes"

git format-patch -1 HEAD

echo "✅ Patch file created: $(ls 0001-*.patch)"
echo "📧 Send this patch file back to the original author."
