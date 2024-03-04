# Use an official Python runtime as a parent image
FROM python:3.12-slim

# python環境変数の設定
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements file to the container
COPY poetry.lock pyproject.toml /app/

# Install Poetry and project dependencies
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# Copy the rest of the application code to the container
COPY . /app

# Expose the port the app runs on
EXPOSE 8080

# Run app.py when the container launches
CMD ["streamlit", "run", "--server.port", "8080", "app.py"]