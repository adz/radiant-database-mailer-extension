require_dependency 'application_controller'

class DatabaseMailerExtension < Radiant::Extension
  version "1.0"
  description "Save fields from mailer forms to the database."
  url "http://blog.aissac.ro/radiant/database-mailer-extension/"
  
  def activate
    throw "MailerExtension must be loaded before DatabaseMailerExtension" unless defined?(MailerExtension)
    MailController.class_eval do
      include DatabaseMailerProcessing
      alias_method_chain :process_mail, :database
    end

    tab "Content" do
      add_item "Database Mailer", "/admin/form_datas"
    end
        
    Mime::Type.register "application/vnd.ms-excel", :xls
  end
  
  def deactivate
  end
end
