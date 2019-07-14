node() {
    stage('Infra Setup - Terraform') {
        sh '''
            env
        '''
    }
}