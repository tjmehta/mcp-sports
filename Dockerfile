# Use the official Python image as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install uv for faster Python package management
RUN pip install uv

# Copy the dependency files first for better caching
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv pip install --system --no-cache -r pyproject.toml

# Copy the source code
COPY src/ ./src/

# Copy other necessary files
COPY README.md LICENSE ./

# Expose the default FastAPI port
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run the application
CMD ["python", "-m", "mcp_sports_server"]