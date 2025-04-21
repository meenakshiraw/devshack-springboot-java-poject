pipeline {   
    agent any
       

    tools{
        jdk 'open-jdk 17'
        maven 'maven'
    }

    stages {
        stage('Git checkout'){
            steps {
                //when we use git public repo
               //git changelog: false, poll: false, url: 'https://github.com/appneural-meenakshirawat/-springboot-java-poject.git'
                //when we use git private repo
               git changelog: false, credentialsId: 'git-ssh-id', poll: false, url: 'git@github.com:appneural-meenakshirawat/devshack-springboot-java-poject.git'
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
         
        
     
       stage('k8s deployment') {
            steps {
                echo " nothing"
                  // kubernetesDeploy(configs: "k8s-deploy.yml", kubeconfigId: "kuber_id")
            }
        }
         
    }
}
