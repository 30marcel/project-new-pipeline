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
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv('sonar-server') {
                        sh "${scannerHome}/bin/sonar-scanner"
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

