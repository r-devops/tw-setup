node() {
    if(typeof(PROJ_NAME1)=="undefined"){   
        println "Hello PROJ_NAME is not there"   
    }
    stage('Infra Setup - Terraform') {
        sh '''
            cd terraform
            terraform init
            terraform plan
        '''
    }
}