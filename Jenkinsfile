pipeline {
    agent any

    tools {
        // Specify the SonarQube Scanner tool
        sonarScanner 'SonarScanner'
    }

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Define the SonarQube Scanner home
                    def scannerHome = tool 'SonarScanner'
                    
                    // Run the SonarQube Scanner
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'SonarQube analysis completed successfully.'
        }
        failure {
            echo 'SonarQube analysis failed.'
        }
    }
}
