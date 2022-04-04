class NameValidator < ActiveModel::Validator
  def validate(record)
    unless record.name.length < 10
      record.errors[:name] << 'Name is too long'
    end
  end
end