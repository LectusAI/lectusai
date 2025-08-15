from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from utils.config import settings

app = FastAPI(
    title="AI News Aggregator API",
    description="Backend API for AI News Aggregator",
    version="0.1.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "https://*.amazonaws.com"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "AI News Aggregator API", "version": "0.1.0"}


@app.get("/health")
async def health_check():
    return {"status": "healthy", "environment": settings.environment}