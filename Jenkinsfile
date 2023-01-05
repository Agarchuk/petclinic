pipeline {
    agent any
    tools {
        maven 'Maven-3.8.7'
    }

    stages {
        stage('Checkout') {
            echo "Check out..."
            steps {
               sh 'mvn --version'
               sh 'git --version'
               git branch: 'main',
                   url: 'https://github.com/Agarchuk/petclinic.git'
               sh 'mvn clean install'
            }
        }
        stage('Build') {
            steps {
                echo "Building..."
                script{
                    sh "docker build -t agarchuk/petclinic:${env.BUILD_ID} ."
                    sh "docker push agarchuk/petclinic:${env.BUILD_ID}"
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                kubernetesDeploy (configs: 'k8s.yaml', kubeconfigId: 'k8sconfig')
            }
        }
    }
}
