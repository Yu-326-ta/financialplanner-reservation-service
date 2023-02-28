class ApplicationController < ActionController::Base
  include ClientsSessionsHelper
  include PlannersSessionsHelper
end
