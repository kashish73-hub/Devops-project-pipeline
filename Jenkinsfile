pipeline {
    agent any
    environment {
        APP_NAME = "python-web-app"
        CONTAINER_NAME = "python-web-app-prod"
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Run Tests') {
            steps {
                bat '''
                    python -m pip install --upgrade pip
                    python -m pip install -r requirements.txt
                    pytest test_app.py
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %APP_NAME%:latest ."
            }
        }
        stage('Deploy Container') {
            steps {
                bat '''
                    docker stop %CONTAINER_NAME%  
                    docker rm %CONTAINER_NAME%  
                    docker run -d --restart unless-stopped --name %CONTAINER_NAME% -p 5000:5000 %APP_NAME%:latest
                '''
            }
        }
    }
}
