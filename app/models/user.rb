class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    

    
  def change
    add_column :users, :role, :string, default: 'user' # roles: admin, user
  end
  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum :role, [:normal_user, :author, :admin]

end      
