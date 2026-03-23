# ============================================================================
# Dockerfile for Dashboard UI Tests
# Builds a container image with Python 3.12, Firefox, and test dependencies
# ============================================================================

FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies and Firefox via Mozilla's official APT repo
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg \
       -o /etc/apt/keyrings/packages.mozilla.org.asc \
    && echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
       > /etc/apt/sources.list.d/mozilla.list \
    && printf 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' \
       > /etc/apt/preferences.d/mozilla \
    && apt-get update \
    && apt-get install -y --no-install-recommends firefox \
    && rm -rf /var/lib/apt/lists/*

# Install geckodriver from GitHub releases
RUN GECKO_VERSION=$(curl -sL https://api.github.com/repos/mozilla/geckodriver/releases/latest \
      | grep '"tag_name"' | head -1 | sed 's/.*"\(v[^"]*\)".*/\1/') \
    && curl -sL "https://github.com/mozilla/geckodriver/releases/download/${GECKO_VERSION}/geckodriver-${GECKO_VERSION}-linux64.tar.gz" \
       | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/geckodriver

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
