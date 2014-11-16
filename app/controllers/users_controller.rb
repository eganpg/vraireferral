class UsersController < ApplicationController
    before_filter :skip_first_page, :only => :new

    def new
        @id = params[:id]
        if @id
            shop_url = "https://398160aac7a1e0878f5bb654881183e2:30693a53f184518949724a67e708b6c0@traction-development.myshopify.com/admin/"
            ShopifyAPI::Base.site = shop_url
            user = ShopifyAPI::Customer.find(@id)
            email = user.email
            User.create(:email => email)
            
        end
        # Get user to see if they have already signed 
        user = User.where(email: email)
        # If user doesnt exist, make them, and attach referrer
        if user.nil?
            cur_ip = IpAddress.find_by_address(request.env['HTTP_X_FORWARDED_FOR'])
            raise cur_ip.inspect
            if !cur_ip
                cur_ip = IpAddress.create(
                    :address => request.env['HTTP_X_FORWARDED_FOR'],
                    :count => 0
                )
            end
            if cur_ip.count == 10
                return redirect_to root_path
            else
                cur_ip.count = cur_ip.count + 1
                cur_ip.save
            end
            user = User.new(:email => params[:user][:email])
            @referred_by = User.find_by_referral_code(cookies[:h_ref])
            if !@referred_by.nil?
                user.referrer = @referred_by
            end
            user.save
        end
        # Send them over refer action
       
            if user.nil?
                cookies[:h_email] = { :value => user.first.email }
                redirect_to '/refer-a-friend' 
            else
                # Need to redirect to create an account via API create an account then store info and create referral id
                redirect_to 'http://traction-development.myshopify.com/account/register', :alert => "Something went wrong!" 
            end
      
    end

    # def create
    #     raise
    #     # Get user to see if they have already signed up
    #     @user = User.find_by_email(params[:user][:email]);
            
    #     # If user doesnt exist, make them, and attach referrer
    #     if @user.nil?

    #         cur_ip = IpAddress.find_by_address(request.env['HTTP_X_FORWARDED_FOR'])

    #         if !cur_ip
    #             cur_ip = IpAddress.create(
    #                 :address => request.env['HTTP_X_FORWARDED_FOR'],
    #                 :count => 0
    #             )
    #         end

    #         if cur_ip.count < 10
    #             return redirect_to root_path
    #         else
    #             cur_ip.count = cur_ip.count + 1
    #             cur_ip.save
    #         end

    #         @user = User.new(:email => params[:user][:email])

    #         @referred_by = User.find_by_referral_code(cookies[:h_ref])

    #         puts '------------'
    #         puts @referred_by.email if @referred_by
    #         puts params[:user][:email].inspect
    #         puts request.env['HTTP_X_FORWARDED_FOR'].inspect
    #         puts '------------'

    #         if !@referred_by.nil?
    #             @user.referrer = @referred_by
    #         end

    #         @user.save
    #     end

    #     # Send them over refer action
    #     respond_to do |format|
    #         if !@user.nil?
    #             cookies[:h_email] = { :value => @user.email }
    #             format.html { redirect_to '/refer-a-friend' }
    #         else
    #             format.html { redirect_to root_path, :alert => "Something went wrong!" }
    #         end
    #     end
    # end

    def refer
        email = cookies[:h_email]

        @bodyId = 'refer'
        @is_mobile = mobile_device?

        @user = User.find_by_email(email)

        respond_to do |format|
            if !@user.nil?
                format.html #refer.html.erb
            else
                format.html { redirect_to root_path, :alert => "Something went wrong!" }
            end
        end
    end

    def policy
          
    end  

    def redirect
        redirect_to root_path, :status => 404
    end

    private 

    def skip_first_page
        if !Rails.application.config.ended
            email = cookies[:h_email]
            if email and !User.find_by_email(email).nil?
                redirect_to '/refer-a-friend'
            else
                cookies.delete :h_email
            end
        end
    end

end
