class ContactsController < ApplicationController
  
  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def index
    @contacts = Contact.all
  end

  def create
    @contact = Contact.create(contacts_params)
    if @contact.save
      # コンタクト画面で"お問い合わせありがとうございました！"とメッセージを表示します。
      redirect_to new_contact_path, notice: "お問い合わせありがとうございました！"
    else
      #コンタクトフォームを再描写
      render action: 'new'
    end
  end
  
  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end
  
  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :content)
    end
end
