class TasksViewsController < ApplicationController
  
  def index
   keys = REDIS.keys("swt2012-*")
   @issues = []
   keys.each do |key|
     @issues.push(JSON.parse(REDIS.get(key)))
   end
  end
end
