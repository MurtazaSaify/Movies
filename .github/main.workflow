# .github/main.workflow
workflow "on pull request review update, check to auto merge the branch" {
  resolves = ["Auto-merge pull requests"]
  on       = "push"
}

action "Auto-merge pull requests" {
  uses = "./workflow-scripts/workflow.sh"
}
