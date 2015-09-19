class MypageController < ApplicationController
    # skip_before_filter :verify_authenticity_token
    before_action :myprofile
    
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
        user = User.find_by_nickname(params[:username]) || User.new
        nav = Nav.find_by_user_id(user.id)
        @user_nav = nav
        
        respond_to do |format|
            format.png do
                html_string = %(
                <!DOCTYPE html>
                <html>
                  <head>
                    <meta charset="utf-8">
                    <title></title>
                    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/3.1.8/imagesloaded.pkgd.min.js"></script>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/3.0.3/normalize.min.css">
                    <style>
                    .wrapper {
                      display: inline-block;
                    }
                    .stage {
                      width: 170px;
                      height: 315px;
                      float: left;
                      display: inline-block;
                      position: relative;
                      overflow: hidden;
                    }
                    .stage .box {
                      position: absolute;
                      width: 100%;
                      height: 100%;
                      left: 0;
                      top: 0;
                      overflow: hidden;
                    }
                    .stage img {
                      position: absolute;
                      left: 50%;
                      -ms-transform: translateX(-50%);
                      -webkit-transform: translateX(-50%);
                      -o-transfrom: translateX(-50%);
                      transform: translateX(-50%);
                      overflow: hidden;
                    }
                    </style>
                  </head>
                  <body>
                      <div class="stage">
                        <div class="box">
                          <img class="image" src="#{@posts[0].file}">
                        </div>
                      </div>
                      <div class="stage">
                        <div class="box">
                          <img class="image" src="#{@posts[1].file}">
                        </div>
                      </div>
                      <div class="stage">
                        <div class="box">
                          <img class="image" src="#{@posts[2].file}">
                        </div>
                      </div>
                      <div class="stage">
                        <div class="box">
                          <img class="image" src="#{@posts[3].file}">
                        </div>
                      </div>
                      <div class="stage">
                        <div class="box">
                          <img class="image" src="#{@posts[4].file}">
                        </div>
                      </div>
                        <script>
                          $(document).ready(function() {
                            var divs = document.querySelectorAll(".stage");
                            imagesLoaded(divs, function(inst) {
                              for (var i = 0; i < divs.length; ++i) {
                                var div = divs[i];
                                var divAspect = div.offsetHeight / div.offsetWidth;
                                div.style.overflow = "hidden";
                    
                                var img = div.querySelector("img");
                                var imgAspect = img.height / img.width;
                    
                                if (imgAspect <= divAspect) {
                                  var imgWidthActual = div.offsetHeight / imgAspect;
                                  var imgWidthToBe = div.offsetHeight / divAspect;
                                  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
                                  img.style.cssText = "width: auto; height: 100%;"
                                } else {
                                  img.style.cssText = "width: 100%; height: auto; margin-left: 0;";
                                }
                              }
                            });
                          });
                          </script>
                  </body>
                </html>
                )
                @kit = IMGKit.new(html_string, width: 850, height: 315)
                send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')
            end
            format.html
        end
    end  
    
    def profile
        # check user_nav exist
        @user_nav = Nav.find_by_user_id(current_user.id)
        if @user_nav
            nav = @user_nav
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
    
   

    # 글쓰기
    def write
        post = Post.new
        post.post_username = current_user.nickname
        post.post_content = params[:content]
        post.file = params[:file]
        post.save
        redirect_to "/"
        
    end
    #지우기=
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
        if params[:file]
            one_post.file = params[:file]
        end
        one_post.save
        
        redirect_to  "/"
    end
    
    
    
    # 리플라이
    def write_reply
        my_reply = Reply.new
        my_reply.nickname_id = params[:my_reply_name]
        my_reply.post_id = params[:my_post_my_id]
        my_reply.content = params[:myreply]
        my_reply.save
        redirect_to "/" + params[:username]
    end
    def cover
    end
end