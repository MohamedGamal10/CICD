pipeline {
agent any
  stages {
    stage('Retrieve Version') {
      steps {
        script {
          def gitUrl = 'https://raw.githubusercontent.com/MohamedGamal10/CICD'
          def branch = 'main'
          def packageJsonPath = 'package.json'
          def packageJsonUrl = "${gitUrl}/${branch}/${packageJsonPath}"
          def packageJsonStr = sh(returnStdout: true, script: "curl -s ${packageJsonUrl}")
          def packageJson = new groovy.json.JsonSlurperClassic().parseText(packageJsonStr)
           env.version = packageJson.version
        }
      }
    }

    stage('Clean Old Docker image') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker stop app"),
                sshTransfer(execCommand: "docker rm app",),
              ])
          ]) 
      }
    }

    stage('Build Docker image') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:${env.version}"),
              ])
          ])  
      }
    }

    stage('Docker Run Container') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:${version}"),
              ])
          ])
      }
    }
  }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build successful!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
