/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  transpilePackages: ['@workspace/ui'],
  env: {
    NEXT_PUBLIC_API_PORT: process.env.PORT_API ?? '8000',
    NEXT_PUBLIC_API_URL: `http://localhost:${process.env.PORT_API ?? '8000'}`,
  },
};

export default nextConfig;
