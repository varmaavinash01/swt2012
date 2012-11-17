# Load the rails application
require File.expand_path('../application', __FILE__)

ENV["REDISTOGO_URL"] = 'redis://127.0.0.1:6379'
# Initialize the rails application
IssueSolver::Application.initialize!
