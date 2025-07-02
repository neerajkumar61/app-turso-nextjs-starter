import { NextResponse } from 'next/server';

export async function GET() {
  try {
    // Simple health check - you can add more sophisticated checks here
    // like database connectivity, external service availability, etc.
    
    const healthCheck = {
      status: 'ok',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      environment: process.env.NODE_ENV || 'development',
    };

    return NextResponse.json(healthCheck, { status: 200 });
  } catch (error) {
    return NextResponse.json(
      { 
        status: 'error',
        timestamp: new Date().toISOString(),
        error: 'Health check failed' 
      },
      { status: 503 }
    );
  }
}