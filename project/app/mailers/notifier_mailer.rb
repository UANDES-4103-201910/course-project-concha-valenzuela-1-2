class NotifierMailer < ApplicationMailer
	default :from => 'crosspatch.web@gmail.com'

  	# send a signup email to the user, pass in the user object that   contains the user's email address
  	def send_email(descrip)
  		@d = descrip
    	mail( :to => 'crosspatch.web@gmail.com',
    	:subject => 'Abusive Content Report' )
  	end
end
