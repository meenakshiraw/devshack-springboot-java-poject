pipeline {   
    agent any
    environment{
        GIT_COMMIT_SHORT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        IMAGE_TAG = "${GIT_COMMIT_SHORT}"
    }
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
                       // sh "docker build -t  meenakshirawat/devshack-springboot-java-pojec:${IMAGE_TAG} ."
                         dockerImage = docker.build("meenakshirawat/devshack-springboot-java-poject:${IMAGE_TAG}")
                        

                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-id', toolName: 'docker') {
                       // sh "docker push meenakshirawat/devshack-springboot-java-poject "
                          dockerImage.push()
                    }
                }
            }
        }
        stage('Tag as Latest (Optional)') {
            steps {
                script {
                    dockerImage.push('latest')
                }
            }
            when {
                branch 'master'
            }
        }
    
        
     
       stage('k8s deployment') {
            steps {
                echo " nothing"
                  // kubernetesDeploy(configs: "k8s-deploy.yml", kubeconfigId: "kuber_id")
            }
        }
         
    }
   post {
        success {
            echo "Docker image pushed with tag: ${IMAGE_TAG}"
        }
        failure {
            echo "Build or push failed."
        }
    }
}
