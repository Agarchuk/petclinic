pipeline {
    agent any
    parameters{
        choice(name: 'BUILDER',
               choices: ['Maven-3.8.7',
                         'Gradle 8.0-rc-1'],
               description: 'Select builder for project. ')

    }

//    tools {
//       when {
//           expression {
//               params.BUILDER == 'Maven-3.8.7'
//           }
//       }
//        maven 'Maven-3.8.7'
//    }
//    tools {
//        when {
//            expression {
//                params.BUILDER == 'Gradle 8.0-rc-1'
//            }
//        }
//        gradle 'Gradle 8.0-rc-1'
//    }

    stages {
        stage('Checkout with Maven') {
            when {
                expression { env.BUILDER == 'Maven-3.8.7'}
                }
            steps {
               sh 'git --version'
               git branch: 'main',
                   url: 'https://github.com/Agarchuk/petclinic.git'
               sh 'mvn clean install'
            }
        }
        stage('Checkout with Gradle') {
            when {
                expression { env.BUILDER == 'Gradle 8.0-rc-1'}
                }
            steps {
               sh 'git --version'
               git branch: 'main',
                   url: 'https://github.com/Agarchuk/petclinic.git'
                sh './gradlew build'
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
