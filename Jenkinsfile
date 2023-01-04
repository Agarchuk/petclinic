pipeline {
    agent any
    tools {
        maven 'Maven-3.8.7'
    }

    stages {
        stage('Source') {
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
                echo "${env.BUILD_ID}"
                script{
                    sh "docker build -t agarchuk/petclinic:${env.BUILD_ID} ."
                    sh "docker push agarchuk/petclinic:${env.BUILD_ID}"
                    //sh "docker build -t agarchuk/petclinic:latest ."
                    //sh "docker push agarchuk/petclinic:latest"
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
