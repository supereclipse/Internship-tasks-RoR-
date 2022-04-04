class UserValidator < ActiveModel::Validator
  def validate(record)
    unless record.first_name > 3 && record.last_name > 3 && record.first_name[0].upcase? && record.last_name[0].upcase?
      record.errors[:name] << 'Unsuitable name'
    end
  end
end