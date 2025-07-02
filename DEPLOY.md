# Preview Deployment Guide

This guide explains how to set up and use preview deployments for the Turso Next.js Starter project.

## 🚀 Deployment Options

We've set up multiple deployment options for creating preview deployments:

### 1. Vercel (Recommended)

#### Automatic Preview Deployments with GitHub Actions

1. **Setup GitHub Secrets:**
   ```bash
   # Required secrets in your GitHub repository:
   VERCEL_TOKEN          # Your Vercel token
   VERCEL_ORG_ID         # Your Vercel organization ID
   VERCEL_PROJECT_ID     # Your Vercel project ID
   NEXT_TURSO_DB_URL     # Your Turso database URL
   NEXT_TURSO_DB_AUTH_TOKEN # Your Turso auth token
   ```

2. **How it works:**
   - Every pull request automatically triggers a preview deployment
   - The deployment URL is posted as a comment on the PR
   - Updates automatically when you push new commits

#### Manual Vercel Deployment

1. **Install Vercel CLI:**
   ```bash
   npm install -g vercel@latest
   ```

2. **Set environment variables:**
   ```bash
   export VERCEL_TOKEN=your_vercel_token_here
   ```

3. **Run the deployment script:**
   ```bash
   ./scripts/deploy-preview.sh
   ```

### 2. Docker Deployment

#### Production Build
```bash
# Build and run production container
docker-compose up --build

# Or manually:
docker build --build-arg NEXT_TURSO_DB_URL="your_db_url" \
             --build-arg NEXT_TURSO_DB_AUTH_TOKEN="your_token" \
             -t turso-nextjs-preview .
docker run -p 3000:3000 turso-nextjs-preview
```

#### Development Build
```bash
# Run development container with hot reload
docker-compose --profile dev up --build dev
```

## 🔧 Setup Instructions

### 1. Environment Variables

Create a `.env.local` file from the example:
```bash
cp .env.example .env.local
```

Edit `.env.local` with your Turso credentials:
```env
NEXT_TURSO_DB_URL=libsql://your-database-url
NEXT_TURSO_DB_AUTH_TOKEN=your-auth-token
```

### 2. Turso Database Setup

If you haven't set up your Turso database yet:

```bash
# Install Turso CLI
curl -sSfL https://get.tur.so/install.sh | bash

# Create database
turso db create web-frameworks

# Get database URL
turso db show web-frameworks --url

# Create auth token
turso db tokens create web-frameworks
```

### 3. Vercel Project Setup

```bash
# Link your project to Vercel
vercel link

# Set environment variables on Vercel
vercel env add NEXT_TURSO_DB_URL
vercel env add NEXT_TURSO_DB_AUTH_TOKEN
```

## 📋 Available Scripts

- `./scripts/deploy-preview.sh` - Manual preview deployment to Vercel
- `npm run build` - Build the application
- `npm run start` - Start production server
- `npm run dev` - Start development server
- `npm run lint` - Run ESLint

## 🔍 Health Check

The application includes a health check endpoint at `/api/health` that returns:

```json
{
  "status": "ok",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "uptime": 123.456,
  "environment": "production"
}
```

## 🐛 Troubleshooting

### Common Issues

1. **Missing environment variables:**
   - Ensure all required environment variables are set
   - Check that `.env.local` exists and has correct values

2. **Database connection errors:**
   - Verify your Turso database URL and token
   - Ensure the database is accessible

3. **Build failures:**
   - Run `npm run lint` to check for code issues
   - Ensure all dependencies are properly installed

4. **Docker build issues:**
   - Make sure Docker daemon is running
   - Check that all build arguments are provided

### Getting Help

- Check the [Next.js deployment documentation](https://nextjs.org/docs/deployment)
- Review [Turso's Vercel setup guide](https://docs.turso.tech/tutorials/vercel-setup-guide/)
- Visit the [Turso Community Discord](https://discord.com/invite/4B5D7hYwub)

## 🚦 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/preview-deploy.yml`) automatically:

1. ✅ Checks out the code
2. 📦 Installs dependencies
3. 🔍 Runs linting
4. 🏗️ Builds the project
5. 🚀 Deploys to Vercel
6. 💬 Comments on the PR with the preview URL

## 🔒 Security Notes

- Never commit `.env.local` or actual credentials to version control
- Use GitHub secrets for sensitive environment variables
- Regularly rotate your Turso auth tokens
- Review preview deployment access permissions

## 📈 Performance Monitoring

Monitor your preview deployments:
- Use Vercel Analytics for performance insights
- Monitor build times and deployment success rates
- Set up alerts for deployment failures