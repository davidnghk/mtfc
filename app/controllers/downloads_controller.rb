class DownloadsController < ApplicationController
 
  def show
    respond_to do |format|
      format.pdf { send_assignment_pdf }
      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end
 
  private
 
  def assignment
    Assignment.find(params[:assignment_id])
  end

  def assignment_pdf
    AssignmentPdf.new(assignment)
  end
 
  def send_assignment_pdf
    send_file assignment_pdf.to_pdf,
      filename: assignment_pdf.filename,
      type: "application/pdf",
      disposition: "inline"
  end

  def render_sample_html
    render template: "assignments/pdf", layout: "assignment_pdf", locals: { assignment: assignment }
  end
end
