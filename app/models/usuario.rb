class Usuario < ApplicationRecord
  ACTIVO = 1
  INACTIVO = 0
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :usuario, presence: true,  length: {minimum: 4, maximum: 10}
  validates :telefono, presence: true, numericality: true, length: {is: 8}
  validates_uniqueness_of :usuario
  validates_uniqueness_of :telefono
  validates :usuario, format: { without: /\s/, message: "No puede haber espacios en blancos" }

  def active_for_authentication?
    super && self.activo
  end

  def inactive_message
    "Tu cuenta ha sido desactivada."
  end
end