class IssueSolversController < ApplicationController
  respond_to :json
  def show
    Rails.logger.info "\n\n\nSHOW called"
    respond_with Issue.get().to_json
  end

  def create
    Rails.logger.info "CREATE called"
    Rails.logger.info "Params = " + params.to_json
    respond_with Issue.save(params).to_json
  end

  def update 
    options = {}
    options["field"] = params[:field]
    Rails.logger.info "UPDATE called"
    if option["field"] == "vote"
      issue = Issue.get_from_id(option["issue_id"])
      issue["voteCount"] = issue["voteCount"].to_i + 1
      Issue.save_existing(issue)  
    else
      
    end
  end
  
  def get_issue_from_id
    issue_id = params[:issueId]
    respond_with Issue.get_from_id(issue_id).to_json
  end
end
