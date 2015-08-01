class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  def my_submissions
    @submissions = current_user.submissions
  end


  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if !@submission.professed_topic_option_id.present? || !@submission.true_topic_option_id.present? || !@submission.content.present?
        #they've changed the topic
        format.html { render :new }
      elsif @submission.save
        format.html { redirect_to user_my_submissions_url(current_user) }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      submit = true
      new_topic = Topic.find(submission_params[:topic_id].to_i)
      if !new_topic.topic_options.collect{ |to| to.id }.include?(submission_params[:professed_topic_option_id].to_i) ||
        !new_topic.topic_options.collect{ |to| to.id }.include?(submission_params[:true_topic_option_id].to_i)
        submit = false
      end
      #if they didn't pass us ids, or the ids are nil, dont submit
      if !submission_params[:professed_topic_option_id].present? || !submission_params[:true_topic_option_id].present?
        submit = false
      end
      if !submit
         #they've changed the topic... only proceed if the professed and true topic are correct
         @submission.topic_id = submission_params[:topic_id]
         @submission.professed_topic_option_id = nil
         @submission.true_topic_option_id = nil
         format.html { render :edit }
      elsif @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:topic_id, :professed_topic_option_id, :true_topic_option_id, :content, :user_id)
    end
end