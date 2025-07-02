#!/bin/bash

# Immediate Deploy Script for Turso Next.js Starter
# This script provides multiple deployment options

set -e

echo "🚀 Turso Next.js Starter - Ready to Deploy!"
echo "=========================================="

# Check if project is built
if [ ! -d ".next" ]; then
    echo "📦 Building project first..."
    npm run build
fi

echo ""
echo "✅ Project is built and ready for deployment!"
echo ""
echo "🌐 Choose your deployment method:"
echo ""
echo "1. 📱 Vercel (Recommended)"
echo "2. 🐳 Docker Local"
echo "3. 📋 Manual Instructions"
echo ""

# Method 1: Try Vercel deployment
echo "=== Method 1: Vercel Deployment ==="
echo ""

if command -v vercel &> /dev/null; then
    echo "✅ Vercel CLI is installed"
    
    # Check if already logged in
    if vercel whoami &> /dev/null; then
        echo "✅ Already logged in to Vercel"
        echo "🚀 Deploying to Vercel..."
        DEPLOYMENT_URL=$(vercel --yes --prod)
        echo ""
        echo "🎉 Deployment successful!"
        echo "🌐 Live URL: $DEPLOYMENT_URL"
        echo ""
        exit 0
    else
        echo "⚠️  Not logged in to Vercel"
        echo "   Run: vercel login"
        echo "   Then: vercel --yes --prod"
    fi
else
    echo "⚠️  Vercel CLI not found"
    echo "   Install with: npm install -g vercel@latest"
fi

echo ""
echo "=== Method 2: Docker Local Deployment ==="
echo ""

if command -v docker &> /dev/null; then
    echo "✅ Docker is available"
    echo "🐳 Building Docker image..."
    
    docker build -t turso-nextjs-app \
        --build-arg NEXT_TURSO_DB_URL="${NEXT_TURSO_DB_URL:-}" \
        --build-arg NEXT_TURSO_DB_AUTH_TOKEN="${NEXT_TURSO_DB_AUTH_TOKEN:-}" \
        .
    
    echo "🚀 Starting container on port 3000..."
    docker run -d -p 3000:3000 --name turso-app turso-nextjs-app
    
    echo ""
    echo "🎉 Docker deployment successful!"
    echo "🌐 Local URL: http://localhost:3000"
    echo "🛑 Stop with: docker stop turso-app && docker rm turso-app"
    echo ""
    exit 0
else
    echo "⚠️  Docker not found"
fi

echo ""
echo "=== Method 3: Manual Deployment Instructions ==="
echo ""
echo "📋 Your project is ready! Here are your options:"
echo ""
echo "🔷 Vercel (Recommended):"
echo "   1. Go to https://vercel.com"
echo "   2. Import this repository"
echo "   3. Add environment variables:"
echo "      - NEXT_TURSO_DB_URL"
echo "      - NEXT_TURSO_DB_AUTH_TOKEN"
echo "   4. Deploy!"
echo ""
echo "🔷 Netlify:"
echo "   1. Go to https://netlify.com"
echo "   2. Drag and drop the .next folder"
echo "   3. Configure build settings"
echo ""
echo "🔷 Railway:"
echo "   1. Go to https://railway.app"
echo "   2. Connect GitHub repository"
echo "   3. Add environment variables"
echo ""
echo "🔷 Digital Ocean App Platform:"
echo "   1. Go to https://cloud.digitalocean.com/apps"
echo "   2. Create new app from GitHub"
echo "   3. Configure as Node.js app"
echo ""
echo "📁 Build Output Location: .next/"
echo "📦 Build Command: npm run build"
echo "🚀 Start Command: npm start"
echo ""
echo "🎯 One-Click Deploy:"
echo "   Use the deploy button in the README.md"