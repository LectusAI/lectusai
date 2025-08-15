# AI News Aggregator

A comprehensive AI-powered news aggregation platform that automatically collects, processes, and summarizes the latest developments in artificial intelligence using advanced agentic AI capabilities.

## Architecture

- **Frontend**: Next.js 15 with Turbopack, TypeScript, and Tailwind CSS
- **Backend**: Python 3.12 with FastAPI and UV dependency management
- **Infrastructure**: AWS (ECS, RDS, Lambda, S3) managed with Terraform
- **CI/CD**: GitHub Actions with multi-stage deployment

## Features

- 🤖 **Agentic AI Research**: Proactive topic research and trend analysis
- 📰 **Smart Aggregation**: Automated news collection from multiple sources
- 📊 **Personalized Summaries**: Daily AI-generated summaries based on user preferences
- 💬 **Interactive Assistant**: Conversational AI for deep-dive explanations
- 🔔 **Smart Notifications**: Context-aware alerts with optimal timing
- 💳 **SaaS Model**: Subscription-based tiers with Stripe integration

## Quick Start

### Prerequisites

- Node.js 22+
- Python 3.12+
- UV (Python package manager)
- Docker
- Terraform
- AWS CLI

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ai-news-aggregator
   ```

2. **Backend Setup**
   ```bash
   cd backend
   cp .env.example .env
   # Edit .env with your configuration
   uv sync
   uv run uvicorn main:app --reload
   ```

3. **Frontend Setup**
   ```bash
   cd frontend
   cp .env.example .env.local
   # Edit .env.local with your configuration
   npm install
   npm run dev
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

### Infrastructure Deployment

1. **Configure Terraform**
   ```bash
   cd terraform
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your configuration
   ```

2. **Deploy Infrastructure**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Project Structure

```
ai-news-aggregator/
├── backend/                 # FastAPI backend
│   ├── main.py             # Application entry point
│   ├── utils/              # Utility modules
│   ├── Dockerfile          # Backend container
│   └── pyproject.toml      # Python dependencies
├── frontend/               # Next.js frontend
│   ├── src/                # Source code
│   ├── public/             # Static assets
│   ├── Dockerfile          # Frontend container
│   └── package.json        # Node.js dependencies
├── terraform/              # Infrastructure as Code
│   ├── main.tf             # Main configuration
│   ├── modules/            # Terraform modules
│   │   ├── vpc/            # VPC configuration
│   │   ├── rds/            # Database configuration
│   │   ├── ecs/            # Container orchestration
│   │   ├── lambda/         # Serverless functions
│   │   └── s3/             # Storage configuration
│   └── variables.tf        # Variable definitions
├── .github/workflows/      # CI/CD pipelines
└── .kiro/specs/           # Feature specifications
```

## Development Workflow

1. **Feature Development**: Follow the spec-driven development process in `.kiro/specs/`
2. **Testing**: Run tests locally before pushing
3. **CI/CD**: Automated testing, security scanning, and deployment via GitHub Actions
4. **Infrastructure**: Manage AWS resources with Terraform modules

## Environment Variables

### Backend (.env)
- `DATABASE_URL`: PostgreSQL connection string
- `REDIS_URL`: Redis connection string
- `OPENAI_API_KEY`: OpenAI API key for AI services
- `STRIPE_SECRET_KEY`: Stripe secret key for payments

### Frontend (.env.local)
- `NEXT_PUBLIC_API_URL`: Backend API URL
- `NEXTAUTH_SECRET`: NextAuth.js secret
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`: Stripe publishable key

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the spec-driven development process
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.