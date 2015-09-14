class MypageController < ApplicationController
    # skip_before_filter :verify_authenticity_token
    def index
        @is_owner = true
    end    
    
    @user_nav = nil
    
    # 메인페이지
    def page
        @post_count = Post.where(post_username: params[:username])
                          .count
        if @post_count == 0
            (0..4).each do |index|
                post = Post.new
                post.post_username = params[:username]
                post.post_content = ""
                post.save
            end
        end
        
        @posts = Post.where(post_username: params[:username])
        
        # get user nav if exist
        user_nav = Nav.find_by_user_id(current_user.id)
        @user_nav = user_nav ? user_nav : Nav.new
    end  
    
    def profile
        # check user_nav exist
        user_nav = Nav.find_by_user_id(current_user.id)
        if user_nav
            nav = user_nav
            nav.myname = params[:myname]
            nav.myage = params[:myage]
            nav.mygender = params[:mygender]
            nav.mynationality = params[:mynationality]
            nav.myetc = params[:myetc]
            nav.save
        else
            nav = Nav.new
            nav.myname = params[:myname]
            nav.myage = params[:myage]
            nav.mygender = params[:mygender]
            nav.mynationality = params[:mynationality]
            nav.myetc = params[:myetc]
            nav.user_id = current_user.id
            nav.save
        end
        
        redirect_to "/"
    end
    
    # def nav_modify
    #     @one_nav = Nav.find(params[:nav_id])
       
        
    # end
    
    # def nav_update
    #     one_nav = Nav.find(params[:user_id])
    #     one_nav.myname = params[:new_myname]
    #     one_nav.myage = params[:new_myage]
    #     one_nav.mygender = params[:new_mygender]
    #     one_nav.mynationality = params[:new_mynationality]
    #     one_nav.myetc = params[:new_myetc]
    #     one_nav.save
      
    #     redirect_to  "/"
    # end

    # 글쓰기
    def write
        post = Post.new
        post.post_username = current_user.nickname
        post.post_content = params[:content]
        post.cover_image = params[:cover_image]
        post.save
        redirect_to  "/"
        
    end
    #지우기
    def delete
        one_post = Post.find(params[:id])
        one_post.destroy
        redirect_to  "/"
    end
    #수정
    def modify
        @one_post = Post.find(params[:id])
        
    end
    # 업데이트
    
    def update
        one_post = Post.find(params[:post_id])
        one_post.post_content = params[:post_content]
        if params[:cover_image]
            one_post.cover_image = params[:cover_image]
        end
        one_post.save
        
        redirect_to  "/home#index"
    end
    # 리플라이
    def write_reply
        my_reply = Reply.new
        my_reply.post_id = params[:my_post_my_id]
        my_reply.content = params[:myreply]
        my_reply.save
        redirect_to "/" + params[:username]
    end
end