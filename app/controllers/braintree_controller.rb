class BraintreeController < ApplicationController
  before_action :set_user
  
  def create_new_subscription
    @customer = BraintreeRails::Customer.new(customer_params)
    if @customer.save
      @user.update_attributes(customer_id: @customer.id)
      cc = @customer.credit_cards[0]
      pm = @user.payment_methods.create!(token: cc.token, 
                                         last_four: cc.last_4,
                                         masked_number: cc.masked_number,
                                         is_default: cc.default?, 
                                         expiration_date: Date.new(cc.expiration_year.to_i, cc.expiration_month.to_i, -1), 
                                         cardholder_name: cc.cardholder_name) unless cc.nil?
      plan = Plan.where(plan_id: params[:subscription][:plan_id]).first
      bt_sub = BraintreeRails::Subscription.new(payment_method_token: pm.token, plan_id: plan.plan_id) if plan
      if bt_sub.save
        @user.subscription.update_attributes(subscription_id: bt_sub.id, 
                                             end_date: Date.parse(bt_sub.paid_through_date), 
                                             plan_id: plan.id,
                                             status: bt_sub.status,
                                             subscription_type: bt_sub.plan_id,
                                             next_billing_date: Date.parse(bt_sub.next_billing_date),
                                             next_billing_period_amount: bt_sub.next_billing_period_amount,
                                             payment_method_token: bt_sub.payment_method_token)
      end
      redirect_to profile_path and return
    else
      render action: 'new'
    end
  end
  
  def add_card
    @customer = BraintreeRails::Customer.new(@user.customer_id)
    if cc = @customer.credit_cards.create(params[:customer][:credit_card])
      pm = @user.payment_methods.create!(token: cc.token, 
                                         last_four: cc.last_4,
                                         masked_number: cc.masked_number,
                                         is_default: cc.default?, 
                                         expiration_date: Date.new(cc.expiration_year.to_i, cc.expiration_month.to_i, -1), 
                                         cardholder_name: cc.cardholder_name) unless cc.nil?
      if pm.is_default?
        sub = BraintreeRails::Subscription.find(@user.subscription.subscription_id)
        sub.update_attributes(payment_method_token: pm.token)
        @user.payment_methods.where('id != ?', pm.id).update_all(is_default: false)
      end
      redirect_to profile_path and return
    else
      render action: 'new'
    end
  end   
  
  def verify
    render :text => Braintree::WebhookNotification.verify(params[:bt_challenge])
  end
  
  def notify
    # webhook_notification = Braintree::WebhookNotification.parse(params[:bt_signature], params[:bt_payload])
    # notification = Notification.create(:result => webhook_notification.subscription,
    #                                    :timestamp => webhook_notification.timestamp,
    #                                    :kind => webhook_notification.kind,
    #                                    :sub_id => webhook_notification.subscription.id,
    #                                    :sub_status => webhook_notification.subscription.status)
    head :ok
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end
    
    def customer_params
      params[:customer]
    end
  
end
