class IssueSolversController < ApplicationController
  respond_to :json
  def show
    Rails.logger.info "\n\n\nSHOW called" + params.inspect
    respond_with Issue.get()
  end

  def create
    Rails.logger.info "CREATE called"
    Rails.logger.info "Params = " + params.to_json
    Issue.save(params).to_json
    resp = {}
    resp["status"] = "200"
    resp["Message"] = "OK"
    render :json => resp.as_json
  end

  def update 
  end
  
  def get_issue_from_id
    Rails.logger.info "get_issue_from_id" +  params.inspect
    issue_id = params[:id]
    issue = REDIS.get("swt2012-" + issue_id ) 
    render :json => issue.as_json
  end
  
  def upvote
    Rails.logger.info "upvote called" + params.inspect
    issue_id = params[:id]
    key = "swt2012-" + params[:id]
    issue = JSON.parse(REDIS.get(key))
    Rails.logger.info issue.inspect  
    issue["voteCount"] = (issue["voteCount"].to_i  + 1).to_s
    REDIS.set(key,issue.to_json)  
    resp = {}
       resp["status"] = "200"
       resp["Message"] = "OK"
       render :json => resp.as_json
  end
  
  def start
      Rails.logger.info "start called" + params.inspect
      issue_id = params[:id]
      key = "swt2012-" + params[:id]
      issue = JSON.parse(REDIS.get(key))
      Rails.logger.info issue.inspect  
      issue["status"] = "In Progress"
      Rails.logger.info "After change ...........dsjlfkdjf........"
      Rails.logger.info issue.inspect  
      REDIS.set(key,issue.to_json)  
      resp = {}
         resp["status"] = "200"
         resp["Message"] = "OK"
         render :json => resp.as_json
    end
    
    
  def done
      Rails.logger.info "start called" + params.inspect
      issue_id = params[:id]
      key = "swt2012-" + params[:id]
      issue = JSON.parse(REDIS.get(key))
      Rails.logger.info issue.inspect  
      issue["status"] = "Solved"
      Rails.logger.info "After change ...........dsjlfkdjf........"
      Rails.logger.info issue.inspect  
      REDIS.set(key,issue.to_json)  
      resp = {}
         resp["status"] = "200"
         resp["Message"] = "OK"
         render :json => resp.as_json
    end
end
