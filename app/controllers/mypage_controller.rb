class MypageController < ApplicationController
    # skip_before_filter :verify_authenticity_token
    def index
        @is_owner = true
    end    
        # 메인페이지
    def page
        @posts = Post.where(post_username: params[:username])
    end  
    def profile
    end

    # 글쓰기
    def write
        post = Post.new
        post.post_username = current_user.nickname
        post.post_content = params[:content]
        post.my_image = params[:image_file]
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
        one_post = Post.find(params[:id])
        one_post.post_username = params[:new_username]
        one_post.post_content = params[:new_content]
        one_post.save
        
        redirect_to  "/"
    end
    # 리플라이
    def write_reply
        my_reply = Reply.new
        my_reply.post_id = params[:my_post_my_id]
        my_reply.content = params[:myreply]
        my_reply.save
        redirect_to "/"
    end
end