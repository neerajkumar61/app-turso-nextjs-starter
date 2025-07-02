#!/bin/bash

# Static Build Script for Static Hosting Deployment
# Creates a static export that can be deployed to any static hosting service

set -e

echo "📦 Building static export for deployment..."
echo "============================================"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📥 Installing dependencies..."
    npm install
fi

# Create static export configuration
echo "⚙️  Configuring static export..."

# Temporarily modify next.config.js for static export
cp next.config.js next.config.js.backup

cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    serverComponentsExternalPackages: ['@libsql/client']
  },
  output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true
  }
};

module.exports = nextConfig;
EOF

# Build the static export
echo "🏗️  Building static export..."
npm run build

# Restore original config
mv next.config.js.backup next.config.js

echo ""
echo "✅ Static build complete!"
echo ""
echo "📁 Output directory: ./out/"
echo ""
echo "🚀 Deployment options:"
echo ""
echo "🔷 Netlify:"
echo "   - Drag and drop the 'out' folder to netlify.com"
echo "   - Or use Netlify CLI: netlify deploy --dir=out --prod"
echo ""
echo "🔷 Vercel:"
echo "   - vercel --prod out/"
echo ""
echo "🔷 GitHub Pages:"
echo "   - Copy contents of 'out' folder to your gh-pages branch"
echo ""
echo "🔷 Firebase Hosting:"
echo "   - firebase deploy --only hosting"
echo ""
echo "🔷 Surge.sh:"
echo "   - surge out/"
echo ""
echo "🔷 Any static hosting:"
echo "   - Upload contents of 'out' folder to your hosting provider"
echo ""
echo "⚠️  Note: This static build may have limited functionality"
echo "   For full features, use server-side deployment options"