/*:
Structural
==========

>In software engineering, structural design patterns are design patterns that ease the design by identifying a simple way to realize relationships between entities.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Structural_pattern)
*/
import Swift
import Foundation
/*:
🎁 Façade
---------

The facade pattern is used to define a simplified interface to a more complex subsystem.

### Example
*/
class Job {
  func doJob() {
    print("Job is progress...")
  }
}

class BugTracker {
  var isActiveSprint = false
  
  func startSprint() {
    print("Sprint is active")
    isActiveSprint = true
  }
  
  func stopSprint() {
    print("Sprint is not active")
    isActiveSprint = false
  }
}

class Developer {
  func doJobBeforeDeadline(bugTracker: BugTracker) {
    if bugTracker.isActiveSprint {
      print("Developer is solving problems...")
    } else {
      print("Developer is reading the news...")
    }
  }
}

class Workflow {
  let developer = Developer()
  let job = Job()
  let bugTracker = BugTracker()
  func solveProblems() {
    job.doJob()
    bugTracker.startSprint()
    developer.doJobBeforeDeadline(bugTracker: bugTracker)
  }
}
/*:
### Usage
*/
let workflow = Workflow()
workflow.solveProblems()
