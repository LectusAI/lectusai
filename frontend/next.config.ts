import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: 'standalone',
  experimental: {
    turbo: {
      // Enable Turbopack for development
    }
  }
};

export default nextConfig;
