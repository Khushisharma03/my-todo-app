pipeline {
    agent any

    environment {
        IMAGE_NAME = "khushisharma03/todo-app"   
        CONTAINER_NAME = "todo-container"
        PORT = "3000"
        TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build --no-cache -t ${IMAGE_NAME}:${TAG} .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                docker push ${IMAGE_NAME}:${TAG}
                docker tag ${IMAGE_NAME}:${TAG} ${IMAGE_NAME}:latest
                docker push ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true

                docker pull ${IMAGE_NAME}:${TAG}

                docker run -d \
                --name ${CONTAINER_NAME} \
                -p ${PORT}:80 \
                --restart always \
                ${IMAGE_NAME}:${TAG}
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh 'sleep 5 && curl -f http://13.218.198.227:${PORT} || exit 1'
            }
        }
    }

    post {
        success {
            echo "App is live at: http://13.218.198.227:${PORT}"
        }
        failure {
            echo " Build/Deploy failed. Logs:"
            sh 'docker logs ${CONTAINER_NAME} || true'
        }
    }
}