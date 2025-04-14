pipeline {   
    agent any 
    tools{
        jdk 'open-jdk 17'
        maven 'maven'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'master', changelog: false, poll: false, url 'https://github.com/appneural-meenakshirawat/-springboot-java-poject.git'
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
        
        
         
    }
}
