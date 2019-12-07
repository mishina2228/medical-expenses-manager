require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'validation of Person' do
    person = Person.new(valid_params)
    assert person.valid?

    person = Person.new(valid_params.merge(name: nil))
    assert person.invalid?

    person = Person.new(valid_params.merge(relationship: nil))
    assert person.invalid?
  end

  test 'unique validation of Person' do
    person = Person.new(valid_params)
    assert person.valid?
    assert person.save

    person_same_name = Person.new(valid_params.merge(relationship: :unique_relationship))
    assert person_same_name.valid?
    assert person_same_name.save

    person_duplicate = Person.new(valid_params)
    assert person_duplicate.invalid?

    assert person.destroy
    assert person.deleted_at.present?
    assert person_duplicate.valid?, 'should not violate unique constraints when a record logically deleted'
  end

  def valid_params
    {name: :test_name, relationship: :test_relationship}
  end
end
