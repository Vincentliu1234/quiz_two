class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question        = Question.find params[:question_id]
    @answer          = Answer.new(answer_params)
    @answer.user     = current_user
    
    @answer.question = @question
    if @answer.save
      # redirect_to @question
      redirect_to question_path(@question), 
                    notice: "Comment created!"
    else
      
      render "questions/show"
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.destroy
    redirect_to question_path(@question), 
                  notice: "Comment deleted"
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
