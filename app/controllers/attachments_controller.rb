class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      flash[:success] = 'Attachment was successfully created.'
      redirect_to @attachment
    else
      render :new
    end
  end

  # PATCH/PUT /attachments/1
  def update
    if @attachment.update(attachment_params)
      flash[:success] = 'Attachment was successfully updated.'
      redirect_to @attachment.space
    else
      render :edit
    end
  end

  # DELETE /attachments/1
  def destroy
    File.delete('public' + @attachment.file_name.to_s)
    @attachment.destroy
    flash[:success] = 'Post attachment was successfully destroyed.'
    redirect_to @attachment.space
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attachment_params
    params.require(:attachment).permit(:space_id, :file_name)
  end
end
