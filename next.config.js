/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    serverComponentsExternalPackages: ['@libsql/client']
  },
  output: 'standalone'
};

module.exports = nextConfig;
