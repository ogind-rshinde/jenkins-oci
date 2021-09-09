pipeline {
  agent {
    node {
      label 'secdev-server-agent'
    }
  }  
  stages {
//     stage ('OCI Commit List') {
//       steps {
//           script {
//                 getCurrentBuildGitDetails()
//             }
//           //sh '/e/fin-ci/jenkins/scripts/oci-frontend.sh'
//       }
//     }
    stage ('OCI modified confirmation') {
      when {
            expression {
                getCurrentBuildGitDetails()
            }
        }
      steps {
          sh '/c/projects/jenkins-oci/fin-ci/jenkins/scripts/oci-updated.sh "$GIT_COMMIT" "$GIT_BRANCH"'
      }
    }    
  }
}

@NonCPS
def getCurrentBuildGitDetails() {
    echo "getting SCM changes ***********************"
    def changeLogSets = currentBuild.changeSets
    def isOciBuildRequired = false
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            def entry = entries[j]
            echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
            def files = new ArrayList(entry.affectedFiles)
            for (int k = 0; k < files.size(); k++) {
                def file = files[k]
                echo "File Path:  ${file.path} "
                def modifiedFile = file.path
                def ismodify = modifiedFile.matches("stw/stw_php/oci-app(.*)")
                echo "Is modified : ${ismodify}"
                echo "  ${file.editType.name} ${file.path}"
              if (ismodify) {
                isOciBuildRequired = true
              }
            }
        }
    }
  echo " Returning a value as : ${isOciBuildRequired}"
  echo "****************** #### ***********************"
  return isOciBuildRequired
}
