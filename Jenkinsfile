pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t 217511887881.dkr.ecr.us-east-1.amazonaws.com/my-ecr-repo:1.0.2 .'
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'eval $(aws ecr get-login --no-include-email --region us-east-1)'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                sh 'docker push 217511887881.dkr.ecr.us-east-1.amazonaws.com/my-ecr-repo:1.0.2'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Define SonarQube Scanner tool
                    def scannerHome = tool 'SonarQubeScanner';

                    // Run SonarQube analysis
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=marcel30-sonar \
                            -Dsonar.sources=."
                    }
                }
            }
        }

        stage('Logout from ECR') {
            steps {
                sh 'docker logout 217511887881.dkr.ecr.us-east-1.amazonaws.com'
            }
        }
    }
}

