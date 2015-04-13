class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  QUESTIONS_PER_PAGE = 20

 
  before_action :find_question, only: [:show, :edit, :update, :destroy]

 
  def index
    @questions = Question.page(params[:page]).per(QUESTIONS_PER_PAGE)
   
  end

  def new
   
    @question = Question.new
  end

 
  def create
   
    @question = current_user.questions.new(question_params)
    
    
    if @question.save
      
      flash[:notice] = "Idea Created Successfully!"
      
      redirect_to question_path(@question)
    else
     
      render :new
    end
  end

 
  def show
   
    Rails.logger.info ">>>>>>>>>>>>>>>> #{@question.title}"

    @question.increment_view_count
    
    @answer = Answer.new
  
    
  end

  
  def edit
  end

  
  
  def update
    
    if @question.update(question_params)
      
      redirect_to @question, notice: "Idea updated successfully!"
    else
      flash[:alert] = "Please correct errors below"
      render :edit
    end
  end

  
  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Idea deleted successfully!"
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
  
    params.require(:question).permit(:title, :body, {category_ids: []})
  end

end
