FROM python:3.10-bullseye

# Install system dependencies including distutils
RUN apt-get update && apt-get install -y \
    python3-distutils \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Django directly (since no requirements.txt)
RUN pip install --upgrade pip
RUN pip install django==3.2

# Copy project files
COPY . /app/

# Run migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
