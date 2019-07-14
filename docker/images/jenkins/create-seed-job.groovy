// This script is run as part of initializing Jenkins.
// It creates a seed job and copies the required DSL script to its workspace
import jenkins.model.*

println "Creating Jenkins job"
new File("/usr/share/jenkins/seed-job-config.xml").withInputStream { stream ->
  Jenkins.instance.createProjectFromXML("mediawiki-ci-cd", stream)
}

def commands = [
    "mkdir -p /var/jenkins_home/workspace/mediawiki-ci-cd",
    "cp -v /usr/share/jenkins/seeddsl.groovy /var/jenkins_home/workspace/mediawiki-ci-cd/"
  ]
commands.each {
  println "Executing command ${it}"
  def process = it.execute()
  process.waitFor()

  def output = process.in.text
  println output
}
