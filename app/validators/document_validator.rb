class DocumentValidator < ActiveModel::Validator
  def validate(user)
    unless CiUY.validate(user.document)
      user.errors[:document] << 'Bad document'
    end
  end
end