class HomeController < ApplicationController

  # before_action authenticate!, only: [:create] 요걸 어떻게 해결해야함 (로그인 안해도 다른사람 페이지 들어가게 하기)
    def index
        if current_user
            redirect_to '/' + current_user.nickname
        end
    end
    
    def create
    end
end