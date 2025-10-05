pipeline{
    agent any

    triggers {
        githubPush()
    }

    environment {
        aws_region='us-east-1'
        aws_id='<your-account-id>'
        aws_ecr_repo='flaskapp'
        image_version='latest'
        ecs_cluster='honorable-bird-5ay4kd'
    }

    stages{
        stage('checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/pranayguevara/Auradevops.git'
            }
        }

        stage('Build Docker Image'){
            when {
                branch "main"
                changeset "app/**"
            }
            steps{
                script{
                    sh """
                    echo "Building Docker Image"
                    docker build -t ${aws_ecr_repo}:${image_version} .
                    """
                }
            }
        }

        stage('login to ECR'){
            when {
                branch "main"
                changeset "app/**"
            }
            steps{
                withAWS(credentials: 'jenkins-aws'){
                sh """
                aws ecr get-login-password --region ${aws_region} | \
                docker login --username AWS --password-stdin ${aws_id}.dkr.ecr.${aws_region}.amazonaws.com
                """
                }
            }
        }

        stage('Push image to ECR'){
            when {
                branch "main"
                changeset "app/**"
            }
            steps{
                script{
                    sh """
                    docker tag ${aws_ecr_repo}:${image_version} ${aws_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repo}:${image_version}
                    docker push ${aws_id}.dkr.ecr.${aws_region}.amazonaws.com/${aws_ecr_repo}:${image_version}
                    """
                }
            }
        }

        stage('Deploying to ECS'){
            when {
                branch "main"
                changeset "app/**"
            }
            steps {
                withAWS(credentials: 'jenkins-aws'){
                    sh """
                    echo "Updating ECS service..."
                    aws ecs update-service \
                        --cluster ${ecs_cluster} \
                        --service flaskapp \
                        --force-new-deployment \
                        --region ${AWS_REGION}
                    """
                }
            }
        }
    }
}