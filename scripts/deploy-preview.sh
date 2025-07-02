#!/bin/bash

# Preview Deploy Script for Turso Next.js Starter
# This script creates a preview deployment to Vercel

set -e

echo "🚀 Starting preview deployment..."

# Check if required environment variables are set
if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ Error: VERCEL_TOKEN environment variable is required"
    echo "   Please set it with: export VERCEL_TOKEN=your_token_here"
    exit 1
fi

# Check if .env.local exists, if not create from example
if [ ! -f ".env.local" ]; then
    echo "📝 Creating .env.local from .env.example..."
    cp .env.example .env.local
    echo "⚠️  Please edit .env.local with your Turso database credentials"
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm ci

# Run linting
echo "🔍 Running linter..."
npm run lint

# Build the project
echo "🏗️  Building project..."
npm run build

# Install Vercel CLI if not already installed
if ! command -v vercel &> /dev/null; then
    echo "📥 Installing Vercel CLI..."
    npm install -g vercel@latest
fi

# Deploy to Vercel
echo "🚀 Deploying to Vercel..."
DEPLOYMENT_URL=$(vercel --token="$VERCEL_TOKEN" --yes)

echo ""
echo "✅ Preview deployment successful!"
echo "🌐 Preview URL: $DEPLOYMENT_URL"
echo ""
echo "📝 Next steps:"
echo "   1. Test your preview deployment"
echo "   2. Share the URL with your team for review"
echo "   3. Merge your changes when ready"