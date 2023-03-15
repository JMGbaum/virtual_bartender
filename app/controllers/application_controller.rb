class ApplicationController < ActionController::Base
    include Pagy::Backend
    
    layout 'standard'
end
