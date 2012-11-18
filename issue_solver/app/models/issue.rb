class Issue
  class << self
    def get()
      Rails.logger.info "in get"
      keys = REDIS.keys("swt2012-*")
      issues = []
      keys.each do |key|
        Rails.logger.info "Key is " + key
        issues.push(JSON.parse((REDIS.get(key))))
      end
      return issues
    end

    def save(params)
      Rails.logger.info "in save" + params.inspect
      id = inclease_count
      key    = "swt2012-" + id
      issue = {}
        
      issue["id"] = id
      issue["title"] = params[:title]
      issue["description"] = params[:description]
      issue["location"] = params[:location]
      issue["status"] = "Open"
      issue["voteCount"] = "0"
        
      if REDIS.set(key,issue.to_json)
        resp = {}
        resp["status"] = "200"
        resp["Message"] = "OK"
        return resp.to_json
      end
    end

    def delete(report)
      Rails.logger.info "in delete"
      REDIS.delete(params[:key])
    end

    def update(report)
      Rails.logger.info "in update"
    end
    
    def get_from_id(issue_id)
      Rails.logger.info "in get" + issue_id
      REDIS.get("swt2012-" + issue_id)
    end
    
    def save_existing(issue)
      key    = "swt2012-" + issue["id"]
      REDIS.set(key, issue)
    end

    def inclease_count 
      id = REDIS.get("issue-count").to_i
      unless id
        REDIS.set("issue-count", "0")
      end
      id +=1
      REDIS.set("issue-count", id)
      id.to_s
    end
    
    def create_key(options)
      Rails.logger.info "create_key " + options[:issueId]
      if options[:issueId]
        key = "swt2012-" + options[:issueId]
      else
        key = false
      end
      key
    end
  end
end