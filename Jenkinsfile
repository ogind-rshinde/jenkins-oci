pipeline {
  agent {
    node {
      label 'secdev-server-agent'
    }
  }  
  stages {
    stage ('OCI Commit List') {
      steps {
          script {
                getCurrentBuildGitDetails()
            }
          //sh '/e/fin-ci/jenkins/scripts/oci-frontend.sh'
      }
    }
    stage ('OCI modified confirmation') {
      steps {
          ////sh '/e/fin-ci/jenkins/scripts/oci-updated.sh "$GIT_COMMIT" "$GIT_PREVIOUS_COMMIT" "$GIT_BRANCH"'
          sh '/c/projects/jenkins-oci/fin-ci/jenkins/scripts/oci-updated.sh "$GIT_COMMIT" "$GIT_BRANCH"'
      }
    }    
  }
}

@NonCPS
def getCurrentBuildGitDetails() {
    echo "getting SCM changes ***********************"
    def changeLogSets = currentBuild.changeSets
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            def entry = entries[j]
            echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
            def files = new ArrayList(entry.affectedFiles)
            for (int k = 0; k < files.size(); k++) {
                def file = files[k]
                echo "  ${file.editType.name} ${file.path}"
            }
        }
    }
  echo "****************** #### ***********************"
}
