pipeline {
    agent any
    stages {
        stage('Build Docker image') {
            steps {
                script {
                    try {
                        sshPublisher(continueOnError: true, failOnError: true,
                          publishers: [
                            sshPublisherDesc(configName: 'remote', verbose: true,
                              transfers: [
                                sshTransfer(execCommand: "docker stop app"),
                                //sshTransfer(execCommand: "docker rm app"),
                                //sshTransfer(execCommand: "docker rmi react_app:1.0"),
                                //sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0"),
                              ]
                            )
                          ]
                        )
                    } catch (Exception ex) {
                            echo "Ahmed Build failed: ${ex.getMessage()}"
                            currentBuild.result = 'FAILURE'
                            error("Build failed: ${ex.getMessage()}")
                    }
                }
            }
        }
        stage('Docker Run Container') {
            steps {
                script {
                    sshPublisher(continueOnError: true, failOnError: true,
                      publishers: [
                        sshPublisherDesc(configName: 'remote', verbose: true,
                          transfers: [
                            sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:1.0"),
                          ]
                        )
                      ]
                    )
                }
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
