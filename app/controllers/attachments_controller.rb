class AttachmentsController < ApplicationController
    def show
        attachment = Attachment.find(params[:id])
        authorize attachment, :show?
        send_file attachment.file.path
    end
end
