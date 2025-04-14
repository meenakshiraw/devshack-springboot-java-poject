pipeline {   
    agent any
       environment {
        KUBECONFIG_CRED = credentials('kuber_id') // ID of the kubeconfig file
    }

    tools{
        jdk 'open-jdk 17'
        maven 'maven'
    }

    stages {
        stage('Git checkout') {
            steps {
               git changelog: false, poll: false, url: 'https://github.com/appneural-meenakshirawat/-springboot-java-poject.git'
            }
        }
        
        stage('Compile') {
            steps {
                sh "mvn compile"
                 }
        }
        
        stage('Package') {
            steps {
                sh "mvn clean package"
                
                 }
        }
        

        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-id', toolName: 'docker') {
                        sh "docker build -t meenakshirawat/springboot-java-poject:latest ."
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-id', toolName: 'docker') {
                        sh "docker push meenakshirawat/springboot-java-poject:latest "
                    }
                }
            }
        }
        
       stage('Deploy to Kubernetes') {
            steps {
                withEnv(["KUBECONFIG=${KUBECONFIG_CRED}"]) {
                    sh 'kubectl apply -f k8s-deploy.yml -n jenkins'
                }
            }
        }
         
    }
}
