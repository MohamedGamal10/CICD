pipeline {
    agent any
    stages {
        stage('Build Docker image') {
            steps {
                script {
                  try{
                    sshPublisher(publishers: [
                        sshPublisherDesc(configName: 'remote', verbose: true,
                            transfers: [
                                sshTransfer(execCommand: "docker stop app"),
                                sshTransfer(execCommand: "docker rm app"),
                                sshTransfer(execCommand: "docker rmi react_app:1.0"),
                                sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0"),
                            ]
                        )
                    ])
                    }catch (Execption ex){
                      currentBuild.result ='FAILURE'
                    }
                    
                    // Check the exit status of the previous step
                    if (currentBuild.result == 'FAILURE') {
                        sshPublisher(publishers: [
                            sshPublisherDesc(configName: 'remote', verbose: true,
                                transfers: [
                                    sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0"),
                                ]
                            )
                        ])
                    }
                }
            }
        }
        stage('Docker Run Container') {
            steps {
                script {
                    sshPublisher(publishers: [
                        sshPublisherDesc(configName: 'remote', verbose: true,
                            transfers: [
                                sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:1.0"),
                            ]
                        )
                    ])
                    
                    // Check the exit status of the previous step
                    if (currentBuild.result == 'FAILURE') {
                        error('sshPublisher step failed')
                    }
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
