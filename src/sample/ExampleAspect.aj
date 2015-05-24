package sample;

import java.net.URI;

import com.atlassian.jira.rest.client.JiraRestClient;
import com.atlassian.jira.rest.client.domain.BasicIssue;
import com.atlassian.jira.rest.client.domain.input.IssueInput;
import com.atlassian.jira.rest.client.domain.input.IssueInputBuilder;

public aspect ExampleAspect {
	pointcut any_function(): execution(* *(..));
	
	after() throwing (Exception e): any_function(){
		//
		try {
			JerseyJiraRestClientFactory factory = new JerseyJiraRestClientFactory();
	        URI jiraServerUri = new URI("http://localhost:8090/jira");
	        JiraRestClient restClient = factory.createWithBasicHttpAuthentication(jiraServerUri, "ziewiec", "Sofobega");
	        NullProgressMonitor pm = new NullProgressMonitor();
	        IssueInputBuilder issueInputBuilder = new IssueInputBuilder();
	        IssueInput issueInput = issueInputBuilder.setDescription(e.getStackTrace().toString())
	        		.setSummary(e.getMessage())
	        		.setProjectKey("AGE")
	        		.setIssueTypeID(0)
	        		.setComponent{"TestComponent"})
	        		.build();
	        Promise<BasicIssue> pBasicIssue = restClient.getIssueClient().createIssue(issueInput);
	        BasicIssue issue = pBasicIssue.get(100, TimeUnit.MINUTES);
	        System.err.println("Issue created: " + issue.getKey());
			//System.err.println("Exception captured: " + e.toString());
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

}
