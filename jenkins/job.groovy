node() {
    // Check AWS_ACCESS_KEY_ID 
    try {
        println AWS_ACCESS_KEY_ID
    } catch(e) {
        println 'Variable AWS_ACCESS_KEY_ID is missing'
        sh 'false'
    }

    // Check AWS_SECRET_ACCESS_KEY
    try {
        println AWS_SECRET_ACCESS_KEY
    } catch(e) {
        println 'Variable AWS_SECRET_ACCESS_KEY is missing'
        sh 'false'
    }


    stage('Infra Setup - Terraform') {
        sh '''
            cd terraform
            terraform init
            terraform plan
        '''
    }
}