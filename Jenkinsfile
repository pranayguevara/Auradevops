pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"             // Your AWS region (Mumbai)
        AWS_ACCOUNT_ID = "034362045354"       // Replace with your AWS account ID
        ECR_REPO = "project/flaskapp"             // Your ECR repo name
        IMAGE_TAG = "latest"                  // Or use BUILD_NUMBER for unique tags
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/pranayguevara/Auradevops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    echo "Building Docker Image..."
                    docker build -t $ECR_REPO:$IMAGE_TAG .
                    """
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    sh """
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                    """
                }
            }
        }

        stage('Tag & Push Docker Image to ECR') {
            steps {
                script {
                    sh """
                    docker tag $ECR_REPO:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG
                    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG
                    """
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                script {
                    sh """
                    echo "Updating ECS service..."
                    aws ecs update-service \
                        --cluster my-ecs-cluster \
                        --service my-ecs-service \
                        --force-new-deployment \
                        --region $AWS_REGION
                    """
                }
            }
        }
    }
}
