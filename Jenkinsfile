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
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                    pytest test_app.py
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${APP_NAME}:latest ."
            }
        }
        stage('Deploy Container') {
            steps {
                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d --restart unless-stopped --name ${CONTAINER_NAME} -p 5000:5000 ${APP_NAME}:latest
                '''
            }
        }
    }
}
