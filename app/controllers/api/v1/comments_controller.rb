class Api::V1::CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]

    def index 
        @comments = Comment.where(article_id: params[:article_id])
        render json: @comments
    end

    def show
        render json: @v
    end

    def create
        @comment = Comment.new(comments_params)

        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def update
        if @comment.update(comment_params)
            render json: @comment
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @comments.destroy
    end

    private
    
        def set_comment
            @comment = Comment.where(article_id: params[:article_id])
        end
    
        def comment_params
            params.require(:comment).permit(:title, :body)
        end
end
