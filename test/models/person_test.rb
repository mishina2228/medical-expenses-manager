require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def test_validation
    person = Person.new(valid_params)
    assert person.valid?
    assert person.save

    person = Person.new(valid_params.merge(name: nil))
    assert person.invalid?

    person = Person.new(valid_params.merge(relationship: nil))
    assert person.invalid?

    person_duplicate = Person.new(valid_params.merge(relationship: :unique_relationship))
    assert person_duplicate.invalid?
  end

  def valid_params
    {name: :test_name, relationship: :test_relationship}
  end
end
