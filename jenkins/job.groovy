node() {

    def check_vars = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
    for (item in check_vars) {
        try {
            def a = "${item}"
            GroovyShell shell = new GroovyShell();
            Closure c = shell.evaluate("""{->"$a"}""")
        } catch(e) {
            println "Variable " item "is missing"
            System.exit(1)
        }
    }

    stage('Infra Setup - Terraform') {
        sh '''
            ls
        '''
    }
}