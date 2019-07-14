node() {
    // Check AWS_ACCESS_KEY_ID 
    try {
        println AWS_ACCESS_KEY_ID
    } catch(e) {
        println 'Variable AWS_ACCESS_KEY_ID is missing'
        System.exit(1)
    }

    // Check AWS_SECRET_ACCESS_KEY
    try {
        println AWS_ACCESS_KEY_ID
    } catch(e) {
        println 'Variable AWS_ACCESS_KEY_ID is missing'
        System.exit(1)
    }


    stage('Infra Setup - Terraform') {
        sh '''
            cd terraform
            terraform init
            terraform plan
        '''
    }
}