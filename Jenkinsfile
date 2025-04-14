pipeline {   
    agent any 
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
         stage('Docker Image') {
            steps {
                sh 'docker build -t meenakshirawat/springboot-java-poject .'
            }
        }
        
        
         
    }
}
