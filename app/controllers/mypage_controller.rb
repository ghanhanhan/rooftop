class MypageController < ApplicationController
    # skip_before_filter :verify_authenticity_token
    def index
        @is_owner = true
    end    
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
    end  
    
    def profile
    end

    # 글쓰기
    def write
        post = Post.new
        post.post_username = current_user.nickname
        post.post_content = params[:content]
        post.cover_image = params[:cover_image]
        # post.my_image2 = params[:image_file]
        # post.my_image3 = params[:image_file]
        # post.my_image4 = params[:image_file]
        # post.my_image5 = params[:image_file]
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
        
        redirect_to  "/" + params[:username]
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