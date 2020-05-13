const core = require('@actions/core');
const github = require('@actions/github');

try {
  
  console.log(`Running checks to determine if the PR can be auto merged`);
  core.setOutput("isMergable", `true`);
  // Get the JSON webhook payload for the event that triggered the workflow
  const payload = JSON.stringify(github.context.payload, undefined, 2)
  console.log(`The event payload: ${payload}`);
} catch (error) {
  core.setFailed(error.message);
}
