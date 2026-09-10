FROM manimcommunity/manim:stable

USER root

# Install required system packages (ffmpeg, sox, git)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    sox \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set app directory
WORKDIR /app

# Install Python requirements into existing virtual environment
COPY requirements.txt /app/
RUN /opt/venv/bin/pip install --no-cache-dir "setuptools<81" -r requirements.txt

# Copy full application code
COPY . /app/

# Ensure outputs and media directories exist with write permissions
RUN mkdir -p outputs media && chmod -R 777 outputs media

# Build/verify RAG index during container build
RUN /opt/venv/bin/python rag/download_docs.py || true

# Default environment settings
ENV PORT=10000 \
    PYTHONUNBUFFERED=1 \
    RENDER=true

EXPOSE 10000

# Launch Streamlit server bound to Render's allocated PORT
CMD ["sh", "-c", "/opt/venv/bin/streamlit run app.py --server.port=${PORT:-10000} --server.address=0.0.0.0 --server.enableCORS=false --server.enableXsrfProtection=false"]