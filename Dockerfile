# ============================================================================
# Dockerfile for Dashboard UI Tests
# Builds a container image with Python 3.12, Firefox, and test dependencies
# ============================================================================

FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox-esr \
    firefox-geckodriver \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create output directories
RUN mkdir -p reports screenshots

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV ROBOT_FRAMEWORK=true

# Default command: run all tests
CMD ["robot", "--variable", "ENV:STAGING", "--outputdir", "reports", "."]
